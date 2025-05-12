-- DATA EXPLORATION AND INITIAL COUNTING

-- Count the total number of records in the activity_log table
SELECT COUNT(*) FROM activity_log;

-- Count the total number of records in the billing table
SELECT COUNT(*) FROM billing;

-- Count the total number of records in the features table
SELECT COUNT(*) FROM features;

-- Count the total number of records in the sessions table
SELECT COUNT(*) FROM sessions;

-- Count the total number of records in the subscriptions table
SELECT COUNT(*) FROM subscriptions;

-- Count the total number of records in the support_tickets table
SELECT COUNT(*) FROM support_tickets;

-- Count the total number of records in the system_metrics table
SELECT COUNT(*) FROM system_metrics;

-- Count the total number of records in the users table
SELECT COUNT(*) FROM users;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN activity_log TABLE

-- Count null values for each specified column in the activity_log table
SELECT
    SUM(CASE WHEN activity_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
    SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session, -- Note: Duplicate check for session_id nulls
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN activity_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_activity_type,
    SUM(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_in_timestamp -- Corrected alias to reflect timestamp column
FROM activity_log;

-- Retrieve all records from the billing table for inspection
SELECT * FROM billing;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN feedback TABLE

-- Count null values for each specified column in the feedback table
SELECT
    SUM(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_session,
    SUM(CASE WHEN submission_timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_in_timestamp,
    SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS Nulls_in_rating,
    SUM(CASE WHEN comment_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_comment_type,
    SUM(CASE WHEN comment IS NULL THEN 1 ELSE 0 END) AS Nulls_in_comment,
    SUM(CASE WHEN feature_area IS NULL THEN 1 ELSE 0 END) AS Nulls_in_feature_area
FROM feedback;

-- Retrieve all records from the feedback table for inspection
SELECT * FROM feedback;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN billing TABLE

-- Count null values for each specified column in the billing table
SELECT
    SUM(CASE WHEN feedback_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id, -- This seems to be a copy-paste error, should be billing_id or similar
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN billing_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_billingDate,
    SUM(CASE WHEN plan_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan,
    SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS Nulls_in_amount,
    SUM(CASE WHEN currency IS NULL THEN 1 ELSE 0 END) AS Nulls_in_currency,
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS Nulls_in_payment
FROM billing;

-- Retrieve all records from the subscriptions table for inspection
SELECT * FROM subscriptions;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN sessions TABLE

-- Count null values for each specified column in the sessions table
SELECT
    SUM(CASE WHEN session_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN login_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_login,
    SUM(CASE WHEN logout_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_logout_time,
    SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_device_type
FROM sessions;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES AND PERCENTAGES IN subscriptions TABLE

-- Count null values and calculate the percentage of nulls for specified columns in the subscriptions table
SELECT
    SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
    CAST(SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS FLOAT) * 100.0 / COUNT(*) AS percent_in_user,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN [plan] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan,
    CAST(SUM(CASE WHEN [plan] IS NULL THEN 1 ELSE 0 END) AS FLOAT) * 100.0 / COUNT(*) AS percent_in_plan,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS Nulls_in_duration,
    SUM(CASE WHEN start_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_start_date,
    SUM(CASE WHEN end_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_endDate,
    SUM(CASE WHEN [status] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status
FROM subscriptions;

-- Retrieve all records from the support_tickets table for inspection
SELECT * FROM support_tickets;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN support_tickets TABLE

-- Count null values for each specified column in the support_tickets table
SELECT
    SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_id,
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_in_user,
    SUM(CASE WHEN feature IS NULL THEN 1 ELSE 0 END) AS Nulls_in_feature,
    SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS Nulls_in_submitted_at,
    SUM(CASE WHEN [priority] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_priority,
    SUM(CASE WHEN resolved IS NULL THEN 1 ELSE 0 END) AS Nulls_in_resolved,
    SUM(CASE WHEN resolved_at IS NULL THEN 1 ELSE 0 END) AS Nulls_in_resolved_at,
    SUM(CASE WHEN [status] IS NULL THEN 1 ELSE 0 END) AS Nulls_in_status
FROM support_tickets;

-- Retrieve all records from the system_metrics table for inspection
SELECT * FROM system_metrics;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN system_metrics TABLE

-- Count null values for each specified column in the system_metrics table
SELECT
    SUM(CASE WHEN timestamp IS NULL THEN 1 ELSE 0 END) AS Nulls_timestamp,
    SUM(CASE WHEN active_users IS NULL THEN 1 ELSE 0 END) AS active_users, -- Alias could be more descriptive like Nulls_in_active_users
    SUM(CASE WHEN request_count IS NULL THEN 1 ELSE 0 END) AS Nulls_in_request_count,
    SUM(CASE WHEN error_count IS NULL THEN 1 ELSE 0 END) AS Nulls_in_error_count ,
    SUM(CASE WHEN error_rate IS NULL THEN 1 ELSE 0 END) AS Nulls_in_error_rate,
    SUM(CASE WHEN cpu_usage IS NULL THEN 1 ELSE 0 END) AS Nulls_in_cpu_usage,
    SUM(CASE WHEN memory_usage IS NULL THEN 1 ELSE 0 END) AS Nulls_in_memory_usage ,
    SUM(CASE WHEN response_time IS NULL THEN 1 ELSE 0 END) AS Nulls_in_response_time
FROM system_metrics;

-- Retrieve all records from the users table for inspection
SELECT * FROM users;

-- DATA QUALITY ASSESSMENT - CHECKING FOR NULL VALUES IN users TABLE

-- Count null values for each specified column in the users table
SELECT
    SUM(CASE WHEN user_id IS NULL THEN 1 ELSE 0 END) AS Nulls_id,
    SUM(CASE WHEN full_name IS NULL THEN 1 ELSE 0 END) AS full_name, -- Alias could be more descriptive like Nulls_in_full_name
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Nulls_in_email,
    SUM(CASE WHEN location IS NULL THEN 1 ELSE 0 END) AS Nulls_in_location ,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS Nulls_in_age,
    SUM(CASE WHEN plan_type IS NULL THEN 1 ELSE 0 END) AS Nulls_in_plan_type,
    SUM(CASE WHEN sign_up_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_sign_up_date ,
    SUM(CASE WHEN is_active IS NULL THEN 1 ELSE 0 END) AS Nulls_in_is_active,
    SUM(CASE WHEN churn_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_churn_date,
    SUM(CASE WHEN last_login_date IS NULL THEN 1 ELSE 0 END) AS Nulls_in_last_login_date
FROM users;

-- Retrieve all records from the users table again for inspection (redundant if no changes made since last select *)
SELECT * FROM users;



-- Count subscriptions per user, which can be an indicator of engagement or different service tiers
SELECT user_id, COUNT(*) FROM subscriptions
GROUP BY user_id;

-- Retrieve all subscriptions for a specific user_id '2v8fcv'
SELECT * FROM subscriptions WHERE user_id = '2v8fcv';


-- DATA CLEANING AND PREPARATION

-- CHECKING THE PERCENTAGE OF NULLS IN EACH COLUMN FOR THE 'users' TABLE

-- Calculate total rows, count of non-null user_id, and percentage of null user_id
SELECT COUNT(*) AS all_rows, COUNT(user_id) AS user_cnt,
(COUNT(*) - COUNT(user_id)) * 100.0 /COUNT(*) AS percentage_of_null_user_id -- Added descriptive alias
FROM users;

-- Retrieve all users (redundant if no changes)
SELECT * FROM users;

-- Calculate percentage of nulls for selected columns in the 'users' table using UNION ALL
SELECT 'user_id' AS [columns],(COUNT(*) - COUNT(user_id)) * 100.0 /COUNT(*) AS percentage_of_nulls
FROM users
UNION ALL
SELECT 'Full_name' AS columns,(COUNT(*) - COUNT(Full_name)) * 100.0 /COUNT(*) AS percentage_of_nulls -- Corrected alias to 'columns' for consistency
FROM users
UNION ALL
SELECT 'Email' AS columns,(COUNT(*) - COUNT(Email)) * 100.0 /COUNT(*) AS percentage_of_nulls -- Corrected alias
FROM users
UNION ALL
SELECT 'location' AS columns, -- Corrected alias
CAST((COUNT(*) - COUNT(location)) * 100.0 /COUNT(*) AS DECIMAL(5,2)) AS percentage_of_nulls
FROM users;

-- CHECK FOR DUPLICATE VALUES IN 'users' TABLE

-- Retrieve all users (redundant)
SELECT * FROM USERS;
-- Identify user_ids that appear more than once in the (presumably to be created) 'clean_user' table
SELECT user_id, COUNT(*) AS cnt
FROM clean_user -- This table does not exist yet based on the script flow
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Attempt to deduplicate 'Clean_user' table by selecting one row per group of duplicates based on all columns.
-- The result is intended to be inserted into 'Clean_user' itself, which is problematic.
-- This should ideally select from the original 'users' table and insert into a new 'Clean_user' table.
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date ORDER BY (SELECT NULL)) rowN
FROM Clean_user) -- Should be FROM users if Clean_user is the target

-- This attempts to create and populate 'Clean_user'.
-- It selects distinct rows based on all specified columns from the CTE (which should be based on the original 'users' table).
-- It also filters out rows where user_id is NULL.
SELECT user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date
INTO Clean_user -- Creates Clean_user table
FROM CTE -- This CTE is based on Clean_user which is being created, this is a logical error. Should be from users.
WHERE rowN = 1 AND user_id IS NOT NULL; -- This implies the source table might have user_id as NULL.


-- Check for duplicate user_ids in the newly created 'Clean_users' table.
SELECT user_id, COUNT(*) FROM Clean_users -- Assuming Clean_users was created successfully
GROUP BY user_id
HAVING COUNT(*) > 1;

-- Deduplicate 'Clean_user' based only on 'user_id', keeping the first encountered row.
-- Inserts the result into a new table 'Clean_users'.
WITH CTE AS(SELECT *, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY (SELECT NULL)) rowN
FROM Clean_user) -- Source is Clean_user
SELECT user_id, full_name,email,location,
age,plan_type,sign_up_date,is_active,churn_date,last_login_date
INTO Clean_users -- Creates Clean_users table
FROM CTE
WHERE rowN = 1; -- Keeps only the first row for each user_id

-- Drop the intermediate table 'Clean_user'
DROP TABLE Clean_user;

-- CHECK FOR DUPLICATE VALUES AND CLEAN 'sessions' TABLE

-- Retrieve all sessions for inspection
SELECT * FROM sessions;

-- Deduplicate 'sessions' table based on a combination of all its columns.
-- Inserts the result into a new table 'clean_sessions'.
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY session_id,user_id,login_time,logout_time, device_type
ORDER BY (SELECT NULL)) rowN
FROM sessions) -- Source is the original sessions table
SELECT session_id,user_id,login_time,logout_time, device_type
INTO clean_sessions -- Creates clean_sessions table
FROM CTE
WHERE rowN = 1; -- Keeps unique rows based on all partition columns

-- Retrieve specific session for inspection
SELECT * FROM sessions WHERE session_id = 'sess_09179662';

-- Further deduplication of 'clean_sessions' based on 'session_id', keeping the row with the earliest 'login_time'.
-- Inserts the result into a new table 'sessions1'.
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY session_id
ORDER BY login_time ASC) rowN -- Orders by login_time to keep the earliest
FROM clean_sessions) -- Source is clean_sessions
SELECT session_id,user_id,login_time,logout_time, device_type
INTO sessions1 -- Creates sessions1 table
FROM CTE WHERE rowN = 1;

-- Drop the intermediate table 'clean_sessions'
DROP TABLE clean_sessions;
-- Check for duplicate session_ids in the 'sessions1' table.
SELECT session_id, COUNT(*) FROM sessions1
GROUP BY session_id
HAVING COUNT(*) > 1; -- This should ideally return no rows if deduplication was successful.


-- CHECK FOR DUPLICATE PRIMARY KEYS IN OTHER TABLES (Assumes these are primary keys)

-- Retrieve all subscriptions for inspection
SELECT * FROM subscriptions;
-- Check for duplicate subscription_ids in the 'subscriptions' table
SELECT subscription_id, COUNT(*) FROM subscriptions
GROUP BY subscription_id
HAVING COUNT(*) > 1;

-- Retrieve all activity_log for inspection
SELECT * FROM activity_log;
-- Check for duplicate activity_ids in the 'activity_log' table
SELECT activity_id, COUNT(*) FROM activity_log
GROUP BY activity_id
HAVING COUNT(*) > 1;

-- Retrieve all support_tickets for inspection
SELECT * FROM support_tickets;
-- Check for duplicate ticket_ids in the 'support_tickets' table
SELECT ticket_id, COUNT(*) FROM support_tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;

-- Retrieve all billing for inspection
SELECT * FROM billing;
-- Check for duplicate billing_ids in the 'billing' table
SELECT billing_id, COUNT(*) FROM billing
GROUP BY billing_id
HAVING COUNT(*) > 1;

-- SCHEMA INFORMATION AND MODIFICATIONS

-- CHECKING FOR DATA TYPES of columns in the 'users' table
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'users'; -- This 'users' is the original table, not 'Clean_users' yet.

-- Drop original 'sessions' and 'users' tables. This is a significant step, usually done after confirming cleaned data.
DROP TABLE sessions;
DROP TABLE users;

-- RENAMING THE CLEAN TABLES to their original names
-- Rename 'sessions1' to 'sessions'
EXEC SP_RENAME 'sessions1', 'sessions';
-- Rename 'Clean_users' to 'users'
EXEC SP_RENAME 'Clean_users', 'users'; -- Note: SQL Server might require schema qualification for SP_RENAME with tables.

-- ADDING PRIMARY KEYS TO TABLES

-- Attempt to add a primary key constraint on user_id in the 'users' table
ALTER TABLE users
ADD CONSTRAINT pk_userid PRIMARY KEY (user_id); -- This will fail if user_id contains NULLs or duplicates.

-- Check for NULL user_ids in the 'users' table (the renamed Clean_users)
SELECT * FROM users WHERE user_id IS NULL;

-- Check for duplicate user_ids in the 'users' table
SELECT user_id, COUNT(*) FROM users
GROUP BY user_id
HAVING COUNT(*) > 1;
-
-- Ensure user_id is unique before making it a PK,
-- but it creates a new table 'check_user' with distinct user_ids, which isn't directly used to modify 'users'
SELECT DISTINCT user_id
INTO check_user
FROM users;

-- Re-attempt to add a primary key constraint on user_id in the 'users' table
ALTER TABLE users
ADD CONSTRAINT pk_userid PRIMARY KEY (user_id); -- Still subject to failure if user_id has issues.

-- Check for NULL user_ids again.
SELECT * FROM users WHERE user_id IS NULL;

-- Attempt to alter the user_id column to be NOT NULL. This should be done BEFORE adding PK if NULLs exist.
ALTER TABLE users
ALTER COLUMN user_id nvarchar NOT NULL; -- This will fail if NULLs exist.

-- Drop the 'check_user' table.
DROP TABLE check_user;

-- Alter the user_id column to nvarchar(255) and make it NOT NULL.
ALTER TABLE users
ALTER COLUMN user_id nvarchar(255) NOT NULL; -- This assumes user_id does not have NULLs.

-- Add a primary key constraint on session_id in the 'sessions' table
ALTER TABLE sessions
ADD CONSTRAINT pk_sessionid PRIMARY KEY (session_id); -- This will fail if session_id contains NULLs or duplicates.

-- DATA CLEANING - ADDRESSING DATA INCONSISTENCIES

-- CHECKING FOR TRAILING AND LEADING SPACES in 'full_name' column of 'users' table
SELECT full_name,
LEN(full_name) AS original_length, RTRIM(LTRIM(full_name)) AS trimmed_name -- Show original and trimmed
FROM users
WHERE LEN(full_name) <> LEN(RTRIM(LTRIM(full_name))); -- Filter for names that have leading/trailing spaces

-- Update 'full_name' to remove leading and trailing spaces
UPDATE users SET full_name = RTRIM(LTRIM(full_name));

-- CHECKING FOR INVALID NUMBERS in 'age' column of 'users' table
-- Select ages that are outside the plausible range of 16 to 90
SELECT age FROM users
WHERE age < 16 OR age > 90;

-- Update 'age' to NULL for values outside the plausible range
UPDATE users SET age = NULL WHERE age < 16 OR age > 90;

-- Check for non-numeric values in 'age' column (ISNUMERIC might not be foolproof for all non-numeric cases)
SELECT * FROM users WHERE ISNUMERIC(age) = 0;

-- CHECKING FOR INVALID DATE RANGES in 'users' table
-- Select records where churn_date is before sign_up_date (and they are not the same day)
SELECT * FROM users
WHERE churn_date < sign_up_date AND churn_date <> sign_up_date;

-- Update 'churn_date' to be equal to 'sign_up_date' where churn_date is incorrectly before sign_up_date
UPDATE users SET churn_date = sign_up_date
WHERE churn_date < sign_up_date AND churn_date <> sign_up_date;


-- CHECKING FOR INVALID CATEGORICAL VALUES

-- Show distinct status values in the 'subscriptions' table to identify inconsistencies
SELECT DISTINCT status FROM subscriptions;

-- Show distinct plan_type values in the 'users' table to identify inconsistencies
SELECT DISTINCT plan_type FROM users;

-- Standardize 'plan_type' values in the 'users' table
UPDATE users SET plan_type =
CASE
    WHEN plan_type = 'Basicc' THEN 'Basic'
    WHEN plan_type IN('Enterpris', 'Pro Plus','Bronze') THEN 'Enterprise' -- Consolidating multiple variations to 'Enterprise'
    ELSE plan_type -- Keep other values as they are
END


-- Inspect 'subscriptions' table (likely to check plan consistency or other values)
SELECT * FROM subscriptions;

-- Inspect 'billing' table records where plan_type is 'Bronze' (perhaps before a cleanup or cross-check)
SELECT * FROM billing
WHERE plan_type = 'Bronze';

-- Standardize 'currency' values in the 'billing' table
UPDATE billing SET currency =  CASE WHEN currency = 'XYZ' THEN 'USD'
ELSE currency END;

-- Join billing, subscriptions, and users tables to check data consistency for 'Pro Plus' plan
SELECT b.user_id, s.[plan], u.plan_type -- Using u.plan_type from users and s.[plan] from subscriptions
FROM billing b
JOIN subscriptions s ON s.user_id = b.user_id
JOIN users u ON u.user_id = b.user_id
WHERE u.plan_type = 'Pro Plus'; -- And plan_type = 'Pro Plus' in the original script was ambiguous, assumed users table

-- CHECKING FOR CROSS COLUMN LOGICAL VALIDATION AND CORRECTING AMOUNTS IN 'billing' TABLE

-- Standardize 'amount' in 'billing' based on 'plan_type' and 'currency' (NGN)
UPDATE billing SET amount =  CASE
    WHEN plan_type = 'Basic' AND currency = 'NGN' THEN 15000
    WHEN plan_type = 'Pro' AND currency = 'NGN' THEN 55500
    WHEN plan_type = 'Enterprise' AND currency = 'NGN' THEN  283500
    ELSE amount -- Keep other amounts as they are
END;

-- Standardize 'amount' in 'billing' based on 'plan_type' and 'currency' (USD)
UPDATE billing SET amount =  CASE
    WHEN plan_type = 'Basic' AND currency = 'USD' THEN 10
    WHEN plan_type = 'Pro' AND currency = 'USD' THEN 37
    WHEN plan_type = 'Enterprise' AND currency = 'USD' THEN  189
    ELSE amount
END;

-- This seems to be an attempt to correct plan_type based on amount and currency,
-- but the condition `plan_type = 'USD'` is likely an error, should be `currency = 'USD'`
UPDATE billing SET plan_type = CASE
    WHEN currency = 'USD' AND amount <= 10 THEN 'Basic' -- Corrected: currency = 'USD'
    WHEN currency = 'USD' AND amount = 37 THEN 'Pro'    -- Corrected: currency = 'USD'
    WHEN currency = 'USD' AND amount = 189 THEN  'Enterprise' -- Corrected: currency = 'USD'
    ELSE plan_type
END;

-- Inspect 'billing' for 'Enterprise' plan in 'GBP'
SELECT * from billing
WHERE plan_type = 'Enterprise' AND currency = 'GBP';

-- Standardize 'amount' in 'billing' based on 'plan_type' and 'currency' (GBP)
-- Note: 'GPB' typo for 'GBP' in the Enterprise condition
UPDATE billing SET amount =  CASE
    WHEN plan_type = 'Basic' AND currency = 'GBP' THEN 7.5
    WHEN plan_type = 'Pro' AND currency = 'GBP' THEN 27.5
    WHEN plan_type = 'Enterprise' AND currency = 'GBP' THEN  141.75 -- Corrected typo from GPB to GBP
    ELSE amount
END;

-- Inspect 'billing' for 'Enterprise' plan in 'INR'
SELECT * from billing
WHERE plan_type = 'Enterprise' AND currency = 'INR';

-- Standardize 'amount' in 'billing' based on 'plan_type' and 'currency' (INR)
UPDATE billing SET amount =  CASE
    WHEN plan_type = 'Basic' AND currency = 'INR' THEN 750
    WHEN plan_type = 'Pro' AND currency = 'INR' THEN 2775
    WHEN plan_type = 'Enterprise' AND currency = 'INR' THEN 14175
    ELSE amount
END;

-- Inspect 'billing' for 'Enterprise' plan in 'EURO'
SELECT * FROM billing
WHERE currency = 'EURO' AND plan_type = 'Enterprise';

-- Standardize 'amount' in 'billing' based on 'plan_type' and 'currency' (EURO)
UPDATE billing SET amount = CASE
    WHEN plan_type = 'Basic' AND currency = 'EURO' THEN 9.20
    WHEN plan_type = 'Pro' AND currency = 'EURO' THEN 34.04
    WHEN plan_type = 'Enterprise' AND currency = 'EURO' THEN  173.89
    ELSE amount
END;


-- CLEANING CURRENCY COLUMN in 'billing' table

-- Show distinct currency values in the 'billing' table to identify inconsistencies
SELECT DISTINCT currency FROM billing;

-- Standardize 'currency' values in the 'billing' table
UPDATE billing SET currency =
CASE
    WHEN currency IN ('USS','XYZ') THEN 'USD' -- Consolidate variations to 'USD'
    WHEN currency IN ('EURo','EUR') THEN 'EURO' -- Consolidate variations to 'EURO'
    WHEN currency = 'NGNN' THEN 'NGN' -- Correct typo for 'NGN'
    WHEN currency IS NULL THEN 'Unknown' -- Replace NULL with 'Unknown'
    ELSE currency -- Keep other values as they are
END
FROM billing; -- Redundant FROM clause for UPDATE in some SQL dialects

-- Set 'amount' to NULL for Basic plan with paypal if amount is zero or negative.
-- This logic might need review for its specific business meaning.
UPDATE billing SET amount = CASE
    WHEN plan_type = 'Basic' AND payment_method = 'paypal' THEN NULL
    ELSE amount
END
WHERE amount <= 0; -- Condition applies to rows where amount is non-positive

-- Change the data type of the 'amount' column in 'billing' to FLOAT and allow NULLs
ALTER TABLE billing
ALTER COLUMN amount FLOAT NULL;

-- Check for records in 'billing' where amount is still less than or equal to 0 after cleaning
SELECT * FROM billing
WHERE amount <= 0;

-- Retrieve column names and data types for the 'billing' table
SELECT COLUMN_NAME, DATA_TYPE FROM
INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'billing';

-- CHECKING INVALID FOREIGN KEYS

-- Select user_ids from 'support_tickets' that do not exist in the 'users' table (potential orphaned records)
SELECT user_id FROM support_tickets WHERE user_id NOT IN (SELECT user_id FROM users);

-- Retrieve all users for inspection
SELECT * FROM users;

-- FEATURE ENGINEERING: SPLITTING 'full_name' into 'first_name' and 'last_name'

-- Add new columns 'first_name' and 'last_name' to the 'users' table
ALTER TABLE users ADD first_name VARCHAR(50), last_name VARCHAR(50);

-- CTE to find the position of the first space and the length of the full_name
WITH CTE AS (
    SELECT
        full_name,
        CHARINDEX(' ',full_name) -1 AS first_space_pos, -- Position of space minus 1 for first name length
        LEN(full_name) AS name_length
    FROM users
)
-- Select the full_name, extracted first_name, and extracted last_name
SELECT
    full_name,
    SUBSTRING(full_name,1,first_space_pos) AS first_name_extracted,
    SUBSTRING(full_name,first_space_pos + 2, name_length - (first_space_pos + 1)) AS last_name_extracted -- Corrected last_name extraction
FROM CTE
WHERE first_space_pos >= 0; -- Ensure there is a space; first_space_pos would be -1 if no space

-- Retrieve all users for inspection
SELECT * FROM users;

-- Update 'first_name' column:
-- If a space exists in 'full_name', take the substring before the first space
-- Otherwise (no space), 'first_name' becomes the entire 'full_name'.
UPDATE users SET first_name = CASE
    WHEN CHARINDEX(' ', full_name) > 0
    THEN SUBSTRING(full_name, 1, CHARINDEX(' ', full_name) -1)
    ELSE full_name
END;

-- Update 'last_name' column:
-- If a space exists in 'full_name', take the substring after the first space
-- Otherwise (no space), 'last_name' becomes NULL.
UPDATE users SET last_name = CASE
    WHEN CHARINDEX(' ', full_name) > 0
    THEN SUBSTRING(full_name,CHARINDEX(' ', full_name) + 1,LEN(full_name))
    ELSE NULL
END;

-- Remove the original 'full_name' column from the 'users' table
ALTER TABLE users
DROP COLUMN full_name;