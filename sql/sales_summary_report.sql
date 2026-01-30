/* =====================================================
   Sales Summary Reporting Query
===================================================== */

SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS report_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM sales_fact
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY report_month;
