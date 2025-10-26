
-- Totals
SELECT SUM(revenue) AS total_revenue, SUM(profit) AS total_profit FROM fact_sales;

-- Revenue by YYYY-MM
SELECT substr(date,1,7) AS ym, SUM(revenue) AS revenue
FROM fact_sales
GROUP BY ym
ORDER BY ym;

-- Top 10 products by revenue
SELECT product, SUM(revenue) AS revenue
FROM fact_sales
GROUP BY product
ORDER BY revenue DESC
LIMIT 10;

-- Best managers by profit
SELECT dm.manager_name, SUM(fs.profit) AS profit
FROM fact_sales fs
JOIN dim_manager dm ON dm.manager_id = fs.manager_id
GROUP BY dm.manager_name
ORDER BY profit DESC;

-- ABC by revenue
WITH prod AS (
  SELECT product, SUM(revenue) AS revenue
  FROM fact_sales
  GROUP BY product
),
ranked AS (
  SELECT product, revenue,
         SUM(revenue) OVER (ORDER BY revenue DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cum_rev,
         SUM(revenue) OVER () AS total_rev
  FROM prod
)
SELECT product, revenue,
       cum_rev*1.0/total_rev AS cum_share,
       CASE
         WHEN cum_share <= 0.8 THEN 'A'
         WHEN cum_share <= 0.95 THEN 'B'
         ELSE 'C'
       END AS abc_class
FROM ranked
ORDER BY revenue DESC;
