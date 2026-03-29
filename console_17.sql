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


CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE
);

INSERT INTO employee (full_name, department, salary, hire_date)
VALUES ('Nguyễn Văn An', 'IT', 2800000, '2023-03-04'),
       ('Lê Thị Bình', 'Marketing', 22000000, '2025-10-01'),
       ('Trần Xuân Chiến', 'HR', 2500000, '2023-12-23'),
       ('Hà Xuân Duy', 'IT', 15000000, '2026-01-10'),
       ('Trịnh Thị Em', 'Marketing', 50000000, '2024-05-01');

UPDATE employee
SET salary = salary * 1.1
WHERE department = 'IT';

DELETE FROM employee
WHERE salary < 6000000;

SELECT * FROM employee
WHERE full_name ILIKE '%An%';

SELECT * FROM employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY hire_date ASC;



CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    points INT
);

INSERT INTO customer (name, email, phone, points)
VALUES ('Nguyễn An', 'an.nguyen@example.com', '0901234567', 1500),
    ('Lê Bình', 'binh.le@example.com', '0912345678', 2500),
    ('Trần Chiến', NULL, '0923456789', 500),
    ('Phạm Duy', 'duy.pham@example.com', '0934567890', 3200),
    ('Nguyễn An', 'an.new@gmail.com', '0945678901', 1200),
    ('Hoàng Em', 'em.hoang@example.com', '0956789012', 4000),
    ('Vũ Anh', 'anh.vu@example.com', '0967890123', 2800);

SELECT DISTINCT name FROM customer;

SELECT * FROM customer
WHERE email IS NULL;

SELECT * FROM customer
ORDER BY points DESC
LIMIT 3 OFFSET 1;

SELECT * FROM customer
ORDER BY name DESC;



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



CREATE TABLE course (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    instructor VARCHAR(50),
    price NUMERIC(10,2),
    duration INT
);

INSERT INTO course (title, instructor, price, duration)
VALUES ('Lập trình SQL cơ bản', 'Nguyễn Văn A', 1200000, 25),
    ('Phân tích dữ liệu với sql', 'Trần Thị B', 2500000, 40),
    ('Khóa học Demo 1', 'Lê Văn C', 0, 2),
    ('Thiết kế đồ họa chuyên sâu', 'Phạm Minh D', 3500000, 60),
    ('Kỹ năng thuyết trình Demo', 'Hoàng An', 500000, 5),
    ('Mastering SQL Server', 'Vũ Anh', 1800000, 35);

UPDATE course
SET price = price * 1.15
WHERE duration > 30;

DELETE FROM course
WHERE title LIKE '%Demo%';

SELECT * FROM course
WHERE title ILIKE '%SQL%';

SELECT * FROM course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;



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




CREATE TABLE department (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    department_id INT,
    salary NUMERIC(10,2)
);

INSERT INTO department (name)
VALUES ('IT'), ('Marketing'), ('HR'), ('Pháp chế');

INSERT INTO employee (full_name, department_id, salary)
VALUES ('Nguyễn Văn An', 1, 15000000),
    ('Lê Thị Bình', 2, 22000000),
    ('Trần Xuân Chiến', 3, 9000000),
    ('Hà Xuân Duy', 1, 18000000),
    ('Trịnh Thị Em', 2, 50000000),
    ('Phạm Minh Tuấn', 1, 12000000);

SELECT e.full_name, d.name department_name
FROM employee e INNER JOIN department d ON e.department_id = d.id;

SELECT d.name department_name, AVG(e.salary) avg_salary
FROM employee e INNER JOIN department d ON e.department_id = d.id
GROUP BY d.name;

SELECT d.name department_name, AVG(e.salary) avg_salary
FROM employee e INNER JOIN department d ON e.department_id = d.id
GROUP BY d.name
HAVING AVG(e.salary) > 10000000;

SELECT d.name department_name
FROM department d LEFT JOIN employee e ON d.id = e.department_id
WHERE e.id IS NULL;