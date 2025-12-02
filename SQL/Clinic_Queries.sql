--Q1: Revenue by Sales Channel in a Given Year
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

--Q2: Top 10 Most Valuable Customers
SELECT c.uid, c.name, SUM(s.amount) AS total_spent
FROM customer c
JOIN clinic_sales s ON c.uid = s.uid
WHERE YEAR(s.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;


--Q3: Month-wise Revenue, Expense, Profit, Status
SELECT 
    DATE_FORMAT(s.datetime, '%Y-%m') AS month,
    SUM(s.amount) AS revenue,
    COALESCE(SUM(e.amount), 0) AS expense,
    SUM(s.amount) - COALESCE(SUM(e.amount),0) AS profit,
    CASE WHEN SUM(s.amount) - COALESCE(SUM(e.amount),0) >= 0 THEN 'profitable'
         ELSE 'not-profitable'
    END AS status
FROM clinic_sales s
LEFT JOIN expenses e 
    ON s.cid = e.cid AND DATE_FORMAT(s.datetime,'%Y-%m') = DATE_FORMAT(e.datetime,'%Y-%m')
WHERE YEAR(s.datetime) = 2021
GROUP BY month
ORDER BY month;

--Q4: Most Profitable Clinic per City per Month
WITH clinic_profit AS (
    SELECT 
        c.city, s.cid,
        DATE_FORMAT(s.datetime, '%Y-%m') AS month,
        SUM(s.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    JOIN clinic_sales s ON c.cid = s.cid
    LEFT JOIN expenses e 
        ON s.cid = e.cid AND DATE_FORMAT(s.datetime,'%Y-%m') = DATE_FORMAT(e.datetime,'%Y-%m')
    WHERE YEAR(s.datetime) = 2021
    GROUP BY c.city, s.cid, month
)
SELECT city, month, cid, profit
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY city, month ORDER BY profit DESC) AS rn
    FROM clinic_profit
) t
WHERE rn = 1;


--Q5: Second Least Profitable Clinic per State per Month
WITH clinic_profit AS (
    SELECT 
        c.state, s.cid,
        DATE_FORMAT(s.datetime, '%Y-%m') AS month,
        SUM(s.amount) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics c
    JOIN clinic_sales s ON c.cid = s.cid
    LEFT JOIN expenses e 
        ON s.cid = e.cid AND DATE_FORMAT(s.datetime,'%Y-%m') = DATE_FORMAT(e.datetime,'%Y-%m')
    WHERE YEAR(s.datetime) = 2021
    GROUP BY c.state, s.cid, month
)
SELECT state, month, cid, profit
FROM (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY state, month ORDER BY profit ASC) AS rn
    FROM clinic_profit
) t
WHERE rn = 2;
