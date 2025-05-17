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
CREATE VIEW retention_rate AS 
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
    WHERE timestamp BETWEEN DATEADD(WEEK, -2, '2025-02-20') AND DATEADD(WEEK, 6, '2025-02-20')
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
),

-- Final output: weekly retention rate for each group
retention_rate AS (SELECT 
    wr.adopter_group, 
    week_diff, 
    retained_users, 
    all_users, 
   ROUND(CAST(retained_users * 100.0 AS FLOAT) / all_users,2) AS retention_rate
FROM Weekly_retention wr 
JOIN grouped g ON g.adopter_group = wr.adopter_group
),
--SELECT * FROM retention_rate

pivoted AS (
SELECT week_diff,
MAX(CASE WHEN adopter_group = 'adopter' THEN retention_rate END) AS 'Adopter',
MAX(CASE WHEN adopter_group = 'non_adopter' THEN retention_rate END) AS 'non_adopter'
FROM retention_rate
GROUP BY week_diff
)
SELECT week_diff, adopter, non_adopter, 
(adopter - non_adopter) AS percent_diff
FROM pivoted;

CREATE VIEW user_weekly AS
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

Weeks AS (SELECT -2 AS wk
UNION ALL
SELECT -1 AS wk
UNION ALL
SELECT 0 AS wk
UNION ALL
SELECT 1 AS wk
UNION ALL
SELECT 2 AS wk
UNION ALL
SELECT 3 AS wk
UNION ALL
SELECT 4 AS wk
UNION ALL
SELECT 5 AS wk
UNION ALL
SELECT 6 AS wk),

user_weeks AS (SELECT eu.user_id,wk FROM eligible_users AS eu
CROSS JOIN Weeks)

SELECT uw.user_id,wk, CASE WHEN a.user_id IS NOT NULL THEN 'adopter' ELSE 'non_adopter' END AS adopter_group
,MAX(CASE WHEN al.user_id IS NOT NULL THEN 1 ELSE 0 END) AS active
FROM user_weeks uw
LEFT JOIN adopters a ON uw.user_id = a.user_id
LEFT JOIN activity_log al ON al.user_id = uw.user_id
AND DATEDIFF(WEEK,'2025-02-20',timestamp) = wk
GROUP BY uw.user_id,wk, a.user_id
--ORDER BY uw.user_id,wk;
SELECT * FROM user_weekly


-- UPGRADE STATUS
CREATE VIEW Plan_change AS 
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
)--,

--billing_check AS (
SELECT eu.user_id, b.billing_date,plan_type, 
CASE WHEN a.user_id IS NOT NULL THEN 'adopter' ELSE 'non_adopter' END AS adopter_group,
ROW_NUMBER() OVER (PARTITION BY eu.user_id ORDER BY billing_date) RowN
FROM eligible_users eu
LEFT JOIN adopters a ON eu.user_id = a.user_id
LEFT JOIN billing b ON eu.user_id = b.user_id
WHERE billing_date BETWEEN DATEADD(DAY,-30,'2025-02-20') AND DATEADD(DAY,30,'2025-02-20')
),

first_bill AS (SELECT * FROM billing_check
WHERE RowN = 1),

second_bill AS (SELECT * FROM billing_check
WHERE RowN = 2)

--plan_change AS (
SELECT f.user_id, f.adopter_group, f.billing_date AS first_billing,
f.plan_type AS first_plan, s.billing_date AS second_billing,
s.plan_type AS second_plan
FROM first_bill f 
JOIN second_bill s ON f.user_id = s.user_id




/* CASE WHEN f.plan_type = s.plan_type THEN 'Same_plan'
WHEN f.plan_type IN ('Basic','Pro') AND  s.plan_type IN ('Pro', 'Enterprise') THEN 'Upgraded'
WHEN f.plan_type = 'Pro' AND  s.plan_type = 'Basic' THEN 'Down_graded' END AS plan_change
FROM first_bill f */
JOIN second_bill s ON f.user_id = s.user_id)

SELECT adopter_group, COUNT(CASE WHEN plan_change = 'Same_plan' THEN 1 ELSE NULL  END) AS same_plan_cnt,
COUNT(CASE WHEN plan_change = 'Upgraded' THEN 1 ELSE NULL  END) AS Upgrade_cnt,
COUNT(CASE WHEN plan_change = 'Down_graded' THEN 1  ELSE NULL END ) AS DownGrade_plan_cnt
FROM plan_change
GROUP BY adopter_group


SELECT * FROM retention_rate
SELECT * FROM Plan_change
SELECT * FROM adoption_rate

CREATE VIEW adoption_rate AS 
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
)

SELECT COUNT(eu.user_id) all_users,COUNT(a.user_id) adopter_cnt, COUNT(CASE WHEN a.user_id IS NULL THEN 1 END) AS non_adopter_cnt,
ROUND(CAST(COUNT(a.user_id) AS FLOAT) * 100.0/COUNT(eu.user_id),2) AS adoption_rate FROM eligible_users eu
LEFT JOIN adopters a ON a.user_id = eu.user_id;

SELECT * FROM Plan_change


SELECT  FROM Plan_change