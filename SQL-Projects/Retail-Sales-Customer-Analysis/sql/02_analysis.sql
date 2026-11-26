-- Retail Sales & Customer Analysis | PostgreSQL

-- 1. Duplicate order check
SELECT order_id, COUNT(*) AS row_count
FROM orders GROUP BY order_id HAVING COUNT(*) > 1;

-- 2. Executive KPIs
SELECT COUNT(DISTINCT o.order_id) AS completed_orders,
 COUNT(DISTINCT o.customer_id) AS unique_customers,
 SUM(i.quantity) AS units_sold,
 ROUND(SUM(i.quantity*i.unit_price),2) AS revenue_inr,
 ROUND(SUM(i.quantity*(i.unit_price-i.unit_cost)),2) AS gross_profit_inr,
 ROUND(100.0*SUM(i.quantity*(i.unit_price-i.unit_cost)) /
       NULLIF(SUM(i.quantity*i.unit_price),0),2) AS gross_margin_pct
FROM orders o JOIN order_items i ON i.order_id=o.order_id
WHERE o.order_status='Completed';

-- 3. Monthly revenue and month-over-month movement (CTE + LAG)
WITH monthly AS (
 SELECT DATE_TRUNC('month',o.order_date)::date AS sales_month,
        SUM(i.quantity*i.unit_price) AS revenue
 FROM orders o JOIN order_items i ON i.order_id=o.order_id
 WHERE o.order_status='Completed'
 GROUP BY 1
)
SELECT sales_month, ROUND(revenue,2) AS revenue_inr,
 ROUND(revenue-LAG(revenue) OVER(ORDER BY sales_month),2) AS mom_change_inr,
 ROUND(100.0*(revenue-LAG(revenue) OVER(ORDER BY sales_month)) /
 NULLIF(LAG(revenue) OVER(ORDER BY sales_month),0),2) AS mom_change_pct
FROM monthly ORDER BY sales_month;

-- 4. Category profitability
SELECT i.category,
 ROUND(SUM(i.quantity*i.unit_price),2) AS revenue_inr,
 ROUND(SUM(i.quantity*(i.unit_price-i.unit_cost)),2) AS gross_profit_inr,
 SUM(i.quantity) AS units_sold
FROM orders o JOIN order_items i ON i.order_id=o.order_id
WHERE o.order_status='Completed'
GROUP BY i.category ORDER BY revenue_inr DESC;

-- 5. Top products using DENSE_RANK
WITH product_sales AS (
 SELECT i.product_id,i.product_name,
        SUM(i.quantity*i.unit_price) AS revenue
 FROM orders o JOIN order_items i ON i.order_id=o.order_id
 WHERE o.order_status='Completed'
 GROUP BY i.product_id,i.product_name
)
SELECT *, DENSE_RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM product_sales ORDER BY revenue DESC LIMIT 5;

-- 6. Regional performance
SELECT o.region,COUNT(DISTINCT o.order_id) AS orders,
 ROUND(SUM(i.quantity*i.unit_price),2) AS revenue_inr,
 ROUND(SUM(i.quantity*(i.unit_price-i.unit_cost)),2) AS gross_profit_inr
FROM orders o JOIN order_items i ON i.order_id=o.order_id
WHERE o.order_status='Completed'
GROUP BY o.region ORDER BY revenue_inr DESC;

-- 7. Customer lifetime value proxy and repeat-purchase segment
WITH customer_metrics AS (
 SELECT o.customer_id,COUNT(DISTINCT o.order_id) AS completed_orders,
        SUM(i.quantity*i.unit_price) AS lifetime_revenue,
        SUM(i.quantity*(i.unit_price-i.unit_cost)) AS lifetime_profit,
        MIN(o.order_date) AS first_order_date,MAX(o.order_date) AS latest_order_date
 FROM orders o JOIN order_items i ON i.order_id=o.order_id
 WHERE o.order_status='Completed'
 GROUP BY o.customer_id
)
SELECT c.customer_id,c.customer_name,m.completed_orders,
 ROUND(m.lifetime_revenue,2) AS lifetime_revenue_inr,
 ROUND(m.lifetime_profit,2) AS lifetime_profit_inr,
 CASE WHEN m.completed_orders>=2 THEN 'Repeat' ELSE 'One-time' END AS customer_type,
 m.first_order_date,m.latest_order_date
FROM customer_metrics m JOIN customers c USING(customer_id)
ORDER BY lifetime_revenue DESC;

-- 8. Acquisition channel contribution
SELECT c.acquisition_channel,
 COUNT(DISTINCT o.customer_id) AS purchasing_customers,
 ROUND(SUM(i.quantity*i.unit_price),2) AS revenue_inr
FROM customers c JOIN orders o ON o.customer_id=c.customer_id
JOIN order_items i ON i.order_id=o.order_id
WHERE o.order_status='Completed'
GROUP BY c.acquisition_channel ORDER BY revenue_inr DESC;
