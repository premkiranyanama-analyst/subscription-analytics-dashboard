# SQL Scripts – Subscription Analytics (MySQL)

These scripts document the SQL work used to clean and analyze the dataset before building the Power BI dashboard.

## Workflow (run order)
1. `01_schema_and_cleaning.sql`  
   - Base schema/table setup (optional if using Import Wizard)

2. `02_data_standardization.sql`  
   - Convert date formats (text → DATE)  
   - Convert blanks to NULL  
   - Standardize payment flag (yes/no → 1/0)  
   - Enforce correct data types

3. `03_metrics_and_retention.sql`  
   - Create `subs_view` with `is_active` flag  
   - Compute KPIs: total, active, cancelled, retention %  
   - Compute paid revenue metric (monthly plan)

4. `04_cohort_and_tenure.sql`  
   - Cohort retention (2022 retained into 2023)  
   - Subscriber tenure by cohort month (`months_active`)

## Definitions
- **Active subscriber:** `canceled_date IS NULL`
- **Tenure for active users:** calculated until `CURRENT_DATE`
- **Paid revenue:** filtered using `was_subscription_paid = 1`

## Notes
- Final scripts avoid trial/error statements and keep naming consistent (`canceled_date`).
