CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);

CREATE TABLE OrderDetail (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO Product (name, category, price)
VALUES ('Laptop MSI', 'Electronics', 20000000),
    ('Macbook Pro', 'Electronics', 30000000),
    ('Chuột không dây', 'Accessories', 500000),
    ('Bàn phím cơ', 'Accessories', 1500000),
    ('Tai nghe', 'Accessories', 2000000);

INSERT INTO OrderDetail (order_id, product_id, quantity)
VALUES (1, 1, 2),
    (1, 3, 5),
    (2, 2, 1),
    (2, 4, 3),
    (3, 1, 1),
    (3, 5, 2);

SELECT p.name product_name, SUM(p.price * o.quantity) total_sales
FROM Product p JOIN OrderDetail o ON p.id = o.product_id
GROUP BY p.name;

SELECT p.category, AVG(p.price * o.quantity) avg_total
FROM Product p JOIN OrderDetail o ON p.id = o.product_id
GROUP BY p.category;

SELECT p.category, AVG(p.price * o.quantity) avg_total
FROM Product p JOIN OrderDetail o ON p.id = o.product_id
GROUP BY p.category
HAVING SUM(p.price * o.quantity) > 20000000;

SELECT p.name product_name, SUM(p.price * o.quantity) total_sales
FROM Product p JOIN OrderDetail o ON p.id = o.product_id
GROUP BY p.name
HAVING SUM(p.price * o.quantity) > (
    SELECT AVG(total_sales)
    FROM (
        SELECT SUM(p2.price * o2.quantity) total_sales
        FROM Product p2 JOIN OrderDetail o2 ON p2.id = o2.product_id
        GROUP BY p2.id
    ) sub
);

SELECT p.name product_name, SUM(o.quantity) total_quantity
FROM Product p LEFT JOIN OrderDetail o ON p.id = o.product_id
GROUP BY p.name;
