CREATE TABLE orderinfo (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total NUMERIC(10,2),
    status VARCHAR(20)
);

INSERT INTO orderinfo (customer_id, order_date, total, status)
VALUES (1, '2024-10-15', 1200000, 'Completed'),
    (2, '2024-10-05', 450000, 'Pending'),
    (3, '2024-11-20', 800000, 'Shipping'),
    (4, '2024-10-28', 2500000, 'Completed'),
    (5, '2025-01-10', 300000, 'Cancelled');

SELECT * FROM orderinfo
WHERE total > 500000;

SELECT * FROM orderinfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

SELECT * FROM orderinfo
WHERE status <> 'Completed';

SELECT * FROM orderinfo
ORDER BY order_date DESC
LIMIT 2;
