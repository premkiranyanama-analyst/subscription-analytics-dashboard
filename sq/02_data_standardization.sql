-- Standardize date fields
UPDATE subs
SET created_date = STR_TO_DATE(created_date, '%m/%d/%Y')
WHERE created_date LIKE '%/%';

UPDATE subs
SET canceled_date = STR_TO_DATE(canceled_date, '%m/%d/%Y')
WHERE canceled_date LIKE '%/%';

-- Convert blank cancel dates to NULL
UPDATE subs
SET canceled_date = NULL
WHERE canceled_date = '';

-- Standardize payment flag
UPDATE subs
SET was_subscription_paid =
  CASE
    WHEN was_subscription_paid = 'yes' THEN 1
    WHEN was_subscription_paid = 'no' THEN 0
    ELSE 0
  END;

-- Enforce correct data types
ALTER TABLE subs
MODIFY customer_id INT NOT NULL,
MODIFY created_date DATE NOT NULL,
MODIFY subscription_cost DECIMAL(10,2) NOT NULL,
MODIFY subscription_interval VARCHAR(20) NOT NULL,
MODIFY was_subscription_paid TINYINT(1) NOT NULL DEFAULT 0,
MODIFY canceled_date DATE NULL;
