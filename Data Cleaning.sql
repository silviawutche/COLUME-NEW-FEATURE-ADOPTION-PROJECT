SELECT COUNT(*) FROM activity_log

SELECT COUNT(*) FROM billing

SELECT COUNT(*) FROM features

SELECT COUNT(*) FROM sessions

SELECT COUNT(*) FROM subscriptions

SELECT COUNT(*) FROM support_tickets

SELECT COUNT(*) FROM system_metrics

SELECT COUNT(*) FROM users

SELECT SUM(CASE WHEN activity_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session,
 SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
SUM(CASE WHEN activity_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_activity_type,
SUM(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session
FROM activity_log

SELECT * FROM billing

SELECT SUM(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
 SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session,
SUM(CASE WHEN submission_timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_in_timestamp,
SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS Nulls_in_rating,
SUM(CASE WHEN comment_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_comment_type,
SUM(CASE WHEN comment IS NULL THEN 1 ELSE 0 END) AS Nulls_in_comment,
SUM(CASE WHEN feature_area IS NULL THEN 1 ELSE 0 END) AS Nulls_in_feature_area
FROM feedback


SELECT * FROM feedback

SELECT SUM(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
SUM(CASE WHEN billing_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_billingDate,
SUM(CASE WHEN plan_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan,
SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS Nulls_in_amount,
SUM(CASE WHEN currency IS NULL THEN 1 ELSE 0 END) AS Nulls_in_currency,
SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status,
SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS Nulls_in_payment
FROM billing


SELECT * FROM subscriptions


SELECT SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
 SUM(CASE WHEN login_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_login,
SUM(CASE WHEN logout_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_logout_time,
SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_device_type
FROM sessions


SELECT SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
CAST(SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS FLOAT) * 100.0/COUNT(*) AS percent_in_user,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
 SUM(CASE WHEN [plan] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan,
 CAST(SUM(CASE WHEN [plan] IS NULL THEN 1 ELSE 0 END) AS FLOAT) * 100.0/COUNT(*) AS percent_in_plan,
SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS Nulls_in_duration,
SUM(CASE WHEN start_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_start_date,
SUM(CASE WHEN end_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_endDate,
SUM(CASE WHEN [status] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status
FROM subscriptions


SELECT * FROM support_tickets

SELECT SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
 SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
 SUM(CASE WHEN feature IS NULL THEN 1 ELSE 0 END) AS Nulls_in_feature,
SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS Nulls_in_submitted_at,
SUM(CASE WHEN [priority] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_priority,
SUM(CASE WHEN resolved IS NULL THEN 1 ELSE 0 END) AS Nulls_in_resolved,
SUM(CASE WHEN resolved_at IS NULL THEN 1 ELSE 0 END) AS Nulls_in_resolved_at,
SUM(CASE WHEN [status] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status
FROM support_tickets

SELECT * FROM system_metrics

SELECT SUM(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_timestamp,
 SUM(CASE WHEN active_users IS NULL THEN 1 ELSE 0 END) AS active_users,
 SUM(CASE WHEN request_count IS NULL THEN 1 ELSE 0 END) AS Nulls_in_request_count,
SUM(CASE WHEN error_count  IS NULL THEN 1 ELSE 0 END) AS Nulls_in_error_count ,
SUM(CASE WHEN error_rate IS NULL THEN 1 ELSE 0 END) AS Nulls_in_error_rate,
SUM(CASE WHEN cpu_usage IS NULL THEN 1 ELSE 0 END) AS Nulls_in_cpu_usage,
SUM(CASE WHEN memory_usage  IS NULL THEN 1 ELSE 0 END) AS Nulls_in_memory_usage ,
SUM(CASE WHEN response_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_response_time
FROM system_metrics


SELECT * FROM users




SELECT SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_id,
 SUM(CASE WHEN full_name IS NULL THEN 1 ELSE 0 END) AS full_name,
 SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Nulls_in_email,
SUM(CASE WHEN location  IS NULL THEN 1 ELSE 0 END) AS Nulls_in_location ,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS Nulls_in_age,
SUM(CASE WHEN plan_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan_type,
SUM(CASE WHEN sign_up_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_sign_up_date ,
SUM(CASE WHEN is_active IS NULL THEN 1 ELSE 0 END) AS Nulls_in_is_active,
SUM(CASE WHEN churn_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_churn_date,
SUM(CASE WHEN last_login_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_last_login_date
FROM users

SELECT * FROM users


-- Quantify the weekly retention rate of users who adopted the new features within 7 days 
--of launch

SELECT * FROM activity_log
SELECT * FROM features
WHERE launch_date = '2025-02-20'

-- Compare retention rates of feature adopters versus non-adopters

SELECT * FROM users

--Analyze whether engaging with new features leads to increased user retention and 
-- sustained engagement over time 

SELECT user_id, COUNT(*) FROM subscriptions
GROUP BY user_id


SELECT * FROM subscriptions WHERE user_id = '2v8fcv'



-- CHECKING THE PERCENTAGE OF NULLS IN EACH COLUMN

SELECT COUNT(*) AS all_rows, COUNT(user_id) AS user_cnt, 
(COUNT(*) - COUNT(user_id)) *  100.0 /COUNT(*)
FROM users

SELECT * FROM users

SELECT 'user_id' AS [columns],(COUNT(*) - COUNT(user_id)) *  100.0 /COUNT(*) AS percentage_of_nulls
FROM users
UNION ALL 
SELECT 'Full_name' AS full_name,(COUNT(*) - COUNT(Full_name)) *  100.0 /COUNT(*) AS percentage_of_nulls
FROM users
UNION ALL 
SELECT 'Email' AS full_name,(COUNT(*) - COUNT(Email)) *  100.0 /COUNT(*) AS percentage_of_nulls
FROM users
UNION ALL 
SELECT 'location' AS full_name,
CAST((COUNT(*) - COUNT(location)) *  100.0 /COUNT(*) AS DECIMAL(5,2)) AS percentage_of_nulls
FROM users

-- CHECK FOR DUPLICATE VALUES

SELECT * FROM USERS
SELECT user_id, COUNT(*) AS cnt
FROM clean_user
GROUP  BY user_id
HAVING COUNT(*) > 1

WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date ORDER BY (SELECT NULL)) rowN
FROM Clean_user)

SELECT user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date 
INTO Clean_user
FROM CTE 
WHERE rowN = 1 AND user_id IS NOT NULL


SELECT user_id, COUNT(*) FROM Clean_users
GROUP  BY user_id
HAVING COUNT(*) > 1

WITH CTE AS(SELECT *, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY (SELECT NULL)) rowN
FROM Clean_user)
SELECT user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date 
INTO Clean_users
FROM CTE 
WHERE rowN = 1

DROP TABLE Clean_user

SELECT * FROM sessions

WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY session_id,user_id,login_time,logout_time, device_type
ORDER BY (SELECT NULL)) rowN
FROM sessions)

SELECT session_id,user_id,login_time,logout_time, device_type
INTO clean_sessions
FROM CTE
WHERE rowN = 1

SELECT * FROM sessions WHERE session_id = 'sess_09179662'

WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY session_id
ORDER BY login_time ASC) rowN
FROM clean_sessions)

SELECT session_id,user_id,login_time,logout_time, device_type
INTO sessions1
FROM CTE WHERE rowN = 1 

DROP TABLE clean_sessions
SELECT session_id, COUNT(*) FROM sessions1
GROUP  BY session_id
HAVING COUNT(*) > 1


SELECT * FROM subscriptions
SELECT subscription_id, COUNT(*) FROM subscriptions
GROUP  BY subscription_id
HAVING COUNT(*) > 1

SELECT * FROM activity_log

SELECT activity_id, COUNT(*) FROM activity_log
GROUP  BY activity_id
HAVING COUNT(*) > 1


SELECT * FROM support_tickets
SELECT ticket_id, COUNT(*) FROM support_tickets
GROUP  BY ticket_id
HAVING COUNT(*) > 1


SELECT * FROM billing

SELECT billing_id, COUNT(*) FROM billing
GROUP  BY billing_id
HAVING COUNT(*) > 1

-- CHECKING FOR DATA TYPES

SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'users'

DROP TABLE sessions
DROP TABLE users

-- RENAMING THE CLEAN TABLES COLUMNS

EXEC SP_RENAME 'sessions1', 'sessions'

EXEC SP_RENAME 'Clean_users', users

-- ADDING PRIMARY KEYS TO TABLES

ALTER TABLE users
ADD CONSTRAINT pk_userid PRIMARY KEY (user_id)

SELECT * FROM users WHERE user_id IS NULL

SELECT user_id, COUNT(*) FROM users
GROUP BY user_id
HAVING COUNT(*) > 1

SELECT DISTINCT user_id
INTO check_user
FROM users

ALTER TABLE users
ADD CONSTRAINT pk_userid PRIMARY KEY (user_id)

SELECT * FROM users WHERE user_id IS NULL

ALTER TABLE users
ALTER COLUMN user_id nvarchar NOT NULL

DROP TABLE check_user

ALTER TABLE  users
ALTER COLUMN user_id nvarchar(255) NOT NULL

ALTER TABLE sessions
ADD CONSTRAINT pk_sessionid PRIMARY KEY (session_id)

-- CHECKING TRAILING AND LEADING SPACES

SELECT full_name, 
LEN(full_name), RTRIM(LTRIM(full_name))
FROM users
WHERE LEN(full_name) <> LEN(RTRIM(LTRIM(full_name)))

UPDATE users SET full_name = RTRIM(LTRIM(full_name))

-- CHECKING FOR INVALID NUMBERS

SELECT age FROM users
WHERE age < 16 OR age > 90

UPDATE users SET age = NULL WHERE age < 16 OR age > 90

SELECT * FROM users WHERE ISNUMERIC(age) = 0

-- CHECKING FOR INVALID DATE RANGES

SELECT * FROM users
WHERE churn_date < sign_up_date AND churn_date <> sign_up_date

UPDATE users SET churn_date = sign_up_date
WHERE churn_date < sign_up_date AND churn_date <> sign_up_date


-- CHECKING FOR INVALID CATEGORICAL VALUES
SELECT DISTINCT status FROM subscriptions

SELECT DISTINCT plan_type FROM users


UPDATE users SET plan_type =
CASE WHEN plan_type = 'Basicc' THEN 'Basic'
WHEN plan_type IN('Enterpris', 'Pro Plus','Bronze') THEN 'Enterprise'
ELSE plan_type END
FROM users

SELECT * FROM subscriptions

SELECT * FROM billing
WHERE plan_type = 'Bronze'


UPDATE billing SET currency =  CASE WHEN currency = 'XYZ' THEN 'USD' 
ELSE currency END 

SELECT b.user_id, [plan], plan_type FROM billing b 
JOIN subscriptions s ON s.user_id = b.user_id
JOIN users u ON u.user_id = b.user_id
AND plan_type = 'Pro Plus'

-- CHECKING FOR CROSS COLUMN LOGICAL VALIDATION
-- FOR NAIRA
UPDATE billing SET amount =  CASE WHEN plan_type = 'Basic' AND currency = 'NGN' THEN 15000
WHEN plan_type = 'Pro' AND currency = 'NGN' THEN 55500
WHEN plan_type = 'Enterprise' AND currency = 'NGN' THEN  283500
ELSE amount END 

-- FOR USD
UPDATE billing SET amount =  CASE WHEN plan_type = 'Basic' AND currency = 'USD' THEN 10
WHEN plan_type = 'Pro' AND currency = 'USD' THEN 37
WHEN plan_type = 'Enterprise' AND currency = 'USD' THEN  189
ELSE amount END 

UPDATE billing SET plan_type = CASE WHEN plan_type = 'USD' AND amount <= 10 THEN 'Basic'
WHEN plan_type = 'USD' AND amount = 37 THEN 'Pro'
WHEN plan_type = 'USD' AND amount = 189 THEN  'Enterprise'
ELSE plan_type END 

-- FOR GBP
SELECT * from billing
WHERE plan_type = 'Enterprise' AND currency = 'GBP'

UPDATE billing SET amount =  CASE WHEN plan_type = 'Basic' AND currency = 'GBP' THEN 7.5
WHEN plan_type = 'Pro' AND currency = 'GBP' THEN 27.5
WHEN plan_type = 'Enterprise' AND currency = 'GPB' THEN  141.75
ELSE amount END 

-- FOR INR
SELECT * from billing
WHERE plan_type = 'Enterprise' AND currency = 'INR'

UPDATE billing SET amount =  CASE WHEN plan_type = 'Basic' AND currency = 'INR' THEN 750
WHEN plan_type = 'Pro' AND currency = 'INR' THEN 2775
WHEN plan_type = 'Enterprise' AND currency = 'INR' THEN 14175
ELSE amount END 


-- CLEANING CURRENCY CULUMN
SELECT DISTINCT currency FROM billing 

UPDATE billing SET currency =
CASE WHEN currency IN ('USS','XYZ') THEN 'USD'
WHEN currency IN ('EURo','EUR') THEN 'EURO'
WHEN currency = 'NGNN' THEN 'NGN'
WHEN currency IS NULL THEN 'Unknown'
ELSE currency END
FROM billing

