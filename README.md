
# Telco Customer Churn EDA: Who Leaves and Why

**Author:** Sadiq Kabiru Samuel, Data Analyst
**Tools:** Excel | SQL | Power BI

## Business Problem

Who is leaving, and what do those customers have in common?

## Dataset and Credit

- **Source:** IBM Telco Customer Churn sample dataset, a fictional telecom company created by IBM for data science practice. Available on Kaggle: https://www.kaggle.com/datasets/blastchar/telco-customer-churn
- **Size:** 7,043 customers, 21 fields (demographics, services, contract, billing, tenure, charges and the Churn outcome)
- **Licence:** please see the dataset page for its licence terms. All credit for the original data goes to IBM.
- This repository contains my own analysis, queries, dashboard and reports.

## Questions Investigated

1. What is the overall churn rate?
2. Does contract type affect churn?
3. Does tenure affect churn?
4. Do monthly charges differ between churned and retained customers?
5. Which services and payment methods are linked to churn?
6. Where does the churn, and the lost revenue, concentrate?

## Process

1. **Clean and explore (Excel):** fixed blank values and data types, added helper columns (Churn Flag, Tenure Group), ran descriptive statistics and PivotTables with charts. Every change is logged in the Cleaning Log sheet.
2. **Confirm and go deeper (SQL):** reproduced the Excel results, then measured each group's share of churners, revenue lost to churn and combined-factor risk.
3. **Visualise (Power BI):** a three-page dashboard (Overview, Churn Drivers, Customers and Services).
4. **Report:** findings report (PDF) and presentation (PowerPoint).

## Dashboard Preview

![Overview](dashboard/screenshots/1_overview.png)
![Churn Drivers](dashboard/screenshots/2_churn_drivers.png)
![Customers and Services](dashboard/screenshots/3_customers_services.png)

## Key Insights

- **Overall churn is 26.54%**, about 1 in 4 customers (1,869 of 7,043).
- **Contract type is the strongest factor:** month-to-month customers churn at 42.71%, against 11.27% for one-year and 2.83% for two-year contracts. Month-to-month customers hold about 89% of all churners.
- **Churn falls as tenure grows:** nearly half of first-year customers leave, against about 10% after four years.
- **Fiber optic and electronic check customers churn most:** about 42% and 45%.
- **Support and security matter:** customers without tech support or online security churn at nearly three times the rate of those with them.
- **Churners pay more and stay about half as long**, and represent about 30% of monthly revenue.

## Recommendations

1. Move month-to-month customers onto annual plans with discounts or bundles
2. Protect the first year with onboarding and loyalty offers
3. Review price and service for fiber optic customers on month-to-month plans
4. Bundle tech support and security for new customers, and reward automatic payment

## Limitations

- Single snapshot with no time dimension
- The data shows who churned, not why
- Patterns show association, not cause
- Fictional sample dataset, so findings illustrate method rather than describe a real company

## Repository Structure

```
telco-churn-eda/
├── README.md
├── data/
│   ├── telco_churn_raw.xlsx
│   └── telco_churn_eda_excel.xlsx
├── sql/
│   ├── eda_queries.sql
│   └── results/
├── dashboard/
│   ├── telco_churn_dashboard.pbix
│   └── screenshots/
└── reports/
    ├── Telco_Churn_Findings_Report.pdf
    └── Telco_Churn_Presentation.pptx
```

## How to Open

- **Dashboard:** download `telco_churn_dashboard.pbix` and open it in Power BI Desktop.
- **Excel workbook:** `telco_churn_eda_excel.xlsx` holds the cleaned data, cleaning log, statistics, pivots, charts and findings.
- **Report and slides:** see the `reports/` folder.
