SELECT * FROM intern_files.telco_churn_cleaned;

-- Data Quality

-- Row count
SELECT COUNT(*) FROM telco_churn_cleaned;

-- Duplicate customers

ALTER TABLE telco_churn_cleaned
RENAME COLUMN ï»¿customerID TO CustomerID;

SELECT CustomerID, COUNT(*) AS n 
FROM telco_churn_cleaned
GROUP BY CustomerID
HAVING COUNT(*)>1;

-- Missing values
SELECT
SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS null_tenure,
SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total,
SUM(CASE WHEN Churn IS NULL OR Churn = '' THEN 1 ELSE 0 END) AS null_churn
FROM telco_churn_cleaned;

-- Category Check 
SELECT Churn, COUNT(*) AS n FROM telco_churn_cleaned
GROUP BY Churn;

-- Overall Churn Rate
SELECT COUNT(*) AS customers, SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM telco_churn_cleaned;

-- Churn rate by contract
SELECT Contract, COUNT(*) AS customers, SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM telco_churn_cleaned
GROUP BY Contract
ORDER BY churn_pct DESC;

-- Churn rate by tenure group
WITH t AS ( 
SELECT *, 
CASE WHEN tenure <= 12 THEN '1: 0-12'
	 WHEN tenure <= 24 THEN '2: 13-24'
     WHEN tenure <= 48 THEN '3: 25-48'
     ELSE '4: 49+' END AS tenure_group
     FROM telco_churn_cleaned
     )
SELECT tenure_group,
		COUNT(*) AS customers,
		ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM t
GROUP BY tenure_group
ORDER BY tenure_group;
    
-- Churn by Internet service
SELECT InternetService AS grp,
		COUNT(*) AS customers,
		ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM telco_churn_cleaned
GROUP BY InternetService
ORDER BY churn_PCT DESC;
            
-- Churn by Payment Method
SELECT PaymentMethod AS grp,
	COUNT(*) AS customers,
	ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM telco_churn_cleaned
GROUP BY PaymentMethod
ORDER BY churn_PCT DESC;

-- Churn by Tech Support
SELECT TechSupport AS grp,
	COUNT(*) AS customers,
	ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_pct
FROM telco_churn_cleaned
GROUP BY TechSupport
ORDER BY churn_PCT DESC;

-- Churned vs retained
SELECT Churn,
	   COUNT(*) AS customers,
       ROUND(AVG(tenure), 1) AS avg_tenure,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly,
       ROUND(AVG(TotalCharges), 2) AS avg_total
FROM telco_churn_cleaned
GROUP BY Churn;

-- Where the churn sits
SELECT Contract,
	   SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)
			/ (SELECT SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) FROM telco_churn_cleaned), 1) AS share_of_all_churners
FROM telco_churn_cleaned
GROUP BY Contract;

-- Revenue lost to churn 
SELECT ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 0) AS churned_monthly_revenue,
	   ROUND(SUM(MonthlyCharges), 0) AS total_monthly_revenue,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) / SUM(MonthlyCharges), 1) AS pct_revenue_lost
FROM telco_churn_cleaned;

-- Contract and Internet service combined 
SELECT Contract, InternetService, COUNT(*) AS customers,
	   ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_pct
FROM telco_churn_cleaned
GROUP BY Contract, InternetService
ORDER BY churn_pct DESC;

-- Contract and tenure combined 
WITH t AS (
	SELECT *, CASE WHEN tenure <= 12 THEN '0-12' WHEN tenure <= 24 THEN '13-24'
				   WHEN tenure <= 48 THEN '25-48' ELSE '49+' END AS tenure_group
FROM telco_churn_cleaned)
SELECT Contract, tenure_group, COUNT(*) AS customers,
	   ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS churn_pct
FROM t GROUP BY Contract, tenure_group ORDER BY churn_pct DESC;