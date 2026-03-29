CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2),
    stock INT
);

INSERT INTO product (name, category, price, stock)
VALUES ('iPhone 15 Pro', 'Điện tử', 28000000, 15),
    ('Samsung Galaxy S24', 'Điện tử', 22000000, 10),
    ('Loa Bluetooth Sony', 'Điện tử', 2500000, 50),
    ('Bàn làm việc gỗ', 'Nội thất', 1500000, 5),
    ('Chuột không dây Logitech', 'Điện tử', 500000, 100);

SELECT * FROM product;

SELECT * FROM product
ORDER BY price DESC
LIMIT 3;

SELECT * FROM product
WHERE category = 'Điện tử' AND price < 10000000;

SELECT * FROM product
ORDER BY stock ASC;
