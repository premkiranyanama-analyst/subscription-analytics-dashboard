-- Cohort retention (2022 into 2023)
CREATE VIEW subs_cohort AS
SELECT
  customer_id,
  YEAR(created_date) AS cohort_year,
  created_date,
  canceled_date
FROM subs_view;

SELECT
  cohort_year,
  COUNT(*) AS cohort_size,
  SUM(
    CASE
      WHEN canceled_date IS NULL
           OR canceled_date >= '2023-01-01'
      THEN 1 ELSE 0
    END
  ) AS retained_into_2023,
  ROUND(
    SUM(
      CASE
        WHEN canceled_date IS NULL
             OR canceled_date >= '2023-01-01'
        THEN 1 ELSE 0
      END
    ) * 100.0 / COUNT(*),
    2
  ) AS retention_2023_pct
FROM subs_cohort
WHERE cohort_year = 2022
GROUP BY cohort_year;

-- Subscriber tenure by cohort month
SELECT
  customer_id,
  DATE_FORMAT(created_date, '%Y-%m-01') AS cohort_month,
  TIMESTAMPDIFF(
    MONTH,
    created_date,
    COALESCE(canceled_date, CURRENT_DATE)
  ) AS months_active
FROM subs;
