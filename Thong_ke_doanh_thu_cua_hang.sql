CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2024-10-15', 1200000),
       (2, '2024-10-05', 450000),
       (3, '2024-11-20', 800000),
       (4, '2024-10-28', 2500000),
       (5, '2025-01-10', 300000);

SELECT SUM(total_amount) total_revenue, COUNT(id) total_orders, AVG(total_amount) average_order_value
FROM orders;

SELECT EXTRACT(YEAR FROM order_date) order_year, SUM(total_amount) yearly_revenue
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year DESC;

SELECT EXTRACT(YEAR FROM order_date) order_year, SUM(total_amount) yearly_revenue
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 50000000;

SELECT * FROM orders
ORDER BY total_amount DESC
LIMIT 5;
