CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2024-10-15', 1200000),
       (2, '2024-10-05', 450000),
       (3, '2024-11-20', 800000),
       (4, '2024-10-28', 2500000),
       (5, '2025-01-10', 300000);

INSERT INTO customer (id, name)
VALUES (1, 'Nguyễn Văn A'),
       (2, 'Trần Thị B'),
       (3, 'Lê Văn C'),
       (4, 'Phạm Thị D'),
       (5, 'Hoàng Văn E');

SELECT c.name, SUM(o.total_amount) total_spent
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

SELECT name, total_spent
FROM (
        SELECT c.name, SUM(o.total_amount) total_spent
        FROM customer c JOIN orders o ON c.id = o.customer_id
        GROUP BY c.id, c.name
     ) customer_spending
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM (
        SELECT SUM(total_amount) total_spent
        FROM orders
        GROUP BY customer_id
    ) sub
);

SELECT c.id, c.name
FROM customer c LEFT JOIN orders o ON c.id = o.customer_id
WHERE o.id IS NULL;

SELECT c.name, SUM(o.total_amount) total_spent
FROM customer c JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(total_amount) total_spent
        FROM orders
        GROUP BY customer_id
    ) average_table
);
