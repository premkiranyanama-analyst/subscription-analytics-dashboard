-- Create clean analytical view
CREATE VIEW subs_view AS
SELECT
  customer_id,
  created_date,
  canceled_date,
  subscription_cost,
  subscription_interval,
  was_subscription_paid,
  CASE WHEN canceled_date IS NULL THEN 1 ELSE 0 END AS is_active
FROM subs;

-- Core KPIs
SELECT
  COUNT(*) AS total_subscribers,
  SUM(is_active) AS active_subscribers,
  SUM(is_active = 0) AS canceled_subscribers,
  ROUND(SUM(is_active) * 100.0 / COUNT(*), 2) AS retention_percentage
FROM subs_view;

-- Monthly paid revenue
SELECT
  SUM(subscription_cost) AS monthly_revenue
FROM subs_view
WHERE was_subscription_paid = 1
  AND subscription_interval = 'monthly'
  AND is_active = 1;
