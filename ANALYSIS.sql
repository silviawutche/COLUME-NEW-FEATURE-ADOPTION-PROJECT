-- Step 1: View features launched on February 20, 2025
SELECT * FROM features
WHERE launch_date = '2025-02-20';

-- Step 2: View all users
SELECT * FROM users;

-- ============================================
-- STEP 3: EARLY ADOPTION ANALYSIS PIPELINE
-- ============================================

-- Get all users eligible for feature adoption
-- (Signed up before launch date and still active after or not churned)
WITH eligible_users AS (
    SELECT user_id 
    FROM users
    WHERE sign_up_date < '2025-02-20' 
      AND (churn_date > '2025-02-20' OR churn_date IS NULL)
),

-- Identify users who engaged with new features in the first 7 days after launch
adopters AS (
    SELECT DISTINCT user_id 
    FROM activity_log
    WHERE activity_type IN ('task_reminder','voice_assistant', 'custom_theme')
      AND timestamp BETWEEN '2025-02-20' AND DATEADD(DAY, 7,'2025-02-20')
      AND user_id IN (SELECT user_id FROM eligible_users)
),

-- Identify eligible users who did not adopt any new feature
non_adopters AS (
    SELECT eu.user_id AS user_id 
    FROM eligible_users eu 
    LEFT JOIN adopters a ON eu.user_id = a.user_id
    WHERE a.user_id IS NULL
),

-- Combine all eligible users and mark their adoption status
all_users AS (
    SELECT 
        eu.user_id as eligible_users, 
        a.user_id AS adopted, 
        na.user_id AS non_adopted
    FROM eligible_users eu 
    LEFT JOIN adopters a ON eu.user_id = a.user_id
    LEFT JOIN non_adopters na ON na.user_id = eu.user_id
),

-- Get count and percentage of adopters vs non-adopters
adopter_percentage AS (
    SELECT 
        ROUND(COUNT(CASE WHEN adopted IS NOT NULL THEN 1 END) * 100.0 / COUNT(eligible_users), 2) AS adopters_count,
        ROUND(COUNT(CASE WHEN non_adopted IS NOT NULL THEN 1 END) * 100.0 / COUNT(eligible_users), 2) AS non_adopters_count
    FROM all_users
),

-- ============================================
-- STEP 4: WEEKLY RETENTION ANALYSIS
-- ============================================

-- Assign user group (adopter or non-adopter), calculate activity week, and assign row number per user per week
user_group AS (
    SELECT 
        eligible_users, 
        CASE WHEN adopted IS NOT NULL THEN 'adopter' ELSE 'non_adopter' END AS adopter_group,
        timestamp, 
        DATEDIFF(WEEK, '2025-02-20', timestamp) AS week_diff,
        ROW_NUMBER() OVER (
            PARTITION BY eligible_users, DATEDIFF(WEEK, '2025-02-20', timestamp)
            ORDER BY timestamp
        ) AS RowN
    FROM all_users 
    JOIN activity_log a ON a.user_id = all_users.eligible_users
    WHERE timestamp BETWEEN DATEADD(WEEK, -2, '2025-02-20') AND DATEADD(WEEK, 3, '2025-02-20')
),

-- Count total users per group (adopter vs non-adopter)
grouped AS (
    SELECT adopter_group, COUNT(DISTINCT eligible_users) AS all_users
    FROM user_group
    GROUP BY adopter_group
),

-- Count retained users per group per week
-- Retained means they were active at least once in that week (RowN = 1 ensures 1st appearance)
Weekly_retention AS (
    SELECT 
        adopter_group,
        week_diff, 
        COUNT(DISTINCT eligible_users) AS retained_users
    FROM user_group
    WHERE RowN = 1
    GROUP BY adopter_group, week_diff
)

-- Final output: weekly retention rate for each group
SELECT 
    wr.adopter_group, 
    week_diff, 
    retained_users, 
    all_users, 
    retained_users * 100 / all_users AS retention_rate
FROM Weekly_retention wr 
JOIN grouped g ON g.adopter_group = wr.adopter_group
ORDER BY wr.adopter_group, week_diff;
