CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE customer_log (
    log_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    action_time TIMESTAMP
);

CREATE OR REPLACE FUNCTION check_log()
    RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO customer_log (customer_name, action_time)
    VALUES (NEW.name, NOW());

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_log
    AFTER INSERT ON customers
    FOR EACH ROW
EXECUTE FUNCTION check_log();

INSERT INTO customers (name, email)
VALUES ('An', 'an@gmail.com'),
    ('Binh', 'binh@gmail.com');

SELECT * FROM customer_log;



CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    stock INT
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT
);

INSERT INTO products(name, stock)
VALUES ('Laptop MSI', 10),
       ('Chuột không dây', 4);

CREATE OR REPLACE FUNCTION check_stock()
RETURNS TRIGGER AS $$
    DECLARE
        current_stock INT;
    BEGIN
        SELECT stock INTO current_stock
        FROM products
        WHERE product_id = NEW.product_id;

        IF current_stock < NEW.quantity THEN
            RAISE EXCEPTION 'Không đủ hàng trong kho';
        END IF;

        UPDATE products
        SET stock = stock - NEW.quantity
        WHERE product_id = NEW.product_id;

        RETURN NEW;
    end;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_stock();

INSERT INTO sales(product_id, quantity)
VALUES ('1','3');

INSERT INTO sales(product_id, quantity)
VALUES ('2','5');

SELECT * FROM sales;




CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    stock INT
);

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT
);

INSERT INTO products(name, stock)
VALUES ('Laptop MSI', 10),
       ('Chuột không dây', 4);

CREATE OR REPLACE FUNCTION check_stock()
    RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF current_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Không đủ hàng trong kho';
    END IF;

    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
end;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION check_stock();

INSERT INTO sales(product_id, quantity)
VALUES (1,3);

SELECT * FROM products;



CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    stock INT,
    price NUMERIC(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_amount NUMERIC
);

INSERT INTO products(name, stock, price)
VALUES ('Laptop MSI', 10, 20000),
       ('Chuột không dây', 4, 500);

CREATE OR REPLACE FUNCTION check_orders()
RETURNS TRIGGER AS $$
    DECLARE
        v_price NUMERIC;
    BEGIN
        SELECT price INTO v_price
        FROM products
        WHERE product_id = NEW.product_id;

        NEW.total_amount = v_price * NEW.quantity;

        RETURN NEW;
    end;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_orders
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_orders();

INSERT INTO orders(product_id, quantity)
VALUES (1, 3),
       (2, 2);

SELECT * FROM orders;


CREATE SCHEMA bt5;

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50)
);

CREATE TABLE employee_log (
    log_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    action_time TIMESTAMP
);

INSERT INTO employees (name, position)
VALUES ('Ha Xuan Dai', 'Truong phong'),
       ('Ha Xuan Thien', 'HR');

CREATE OR REPLACE FUNCTION check_employee()
RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO employee_log (emp_name, action_time)
        VALUES (NEW.name, NOW());

        RETURN NEW;
    end;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_employee
AFTER UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION check_employee();

UPDATE employees
SET name = 'Ha Xuan Dai ABC'
WHERE emp_id = 1;

SELECT * FROM employees;
SELECT * FROM employee_log;




CREATE SCHEMA bt6;

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    account_name VARCHAR(50),
    balance NUMERIC
);

INSERT INTO accounts (account_name, balance)
VALUES ('Ha Xuan Dai', 1000000),
       ('Ha Xuan Thien', 5000000);

CREATE OR REPLACE PROCEDURE transac (
    sender_id INT,
    receiver_id INT,
    balance_in NUMERIC
) LANGUAGE plpgsql AS $$
    BEGIN
        BEGIN
            IF (SELECT balance FROM accounts WHERE account_id = sender_id) < balance_in THEN
                RAISE EXCEPTION 'Số dư không đủ';
            end if;

            UPDATE accounts
            SET balance = balance - balance_in
            WHERE account_id = sender_id;

            UPDATE accounts
            SET balance = balance + balance_in
            WHERE account_id = receiver_id;

        EXCEPTION
            WHEN OTHERS THEN
            RAISE;
        end;
    end;
    $$;

CALL transac(1,2,1000000);

SELECT * FROM accounts;



CREATE SCHEMA bt7;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    stock INT NOT NULL,
    price NUMERIC(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_log (
    log_id SERIAL PRIMARY KEY,
    order_id INT,
    action_time TIMESTAMP
);

INSERT INTO products(name, stock, price)
VALUES ('Laptop MSI', 10, 20000),
       ('Chuột không dây', 4, 5000);

CREATE OR REPLACE PROCEDURE trans(
    v_proid INT,
    v_orderid INT,
    v_quantity INT
) LANGUAGE plpgsql AS $$
    DECLARE
        p_price NUMERIC;
    BEGIN
        BEGIN
            SELECT price INTO p_price
            FROM products
            WHERE product_id = v_proid;

            INSERT INTO orders (product_id, quantity, total_amount)
            VALUES (v_proid, v_quantity, p_price * v_quantity);

            IF (SELECT stock FROM products WHERE product_id = v_proid) < v_quantity THEN
                RAISE EXCEPTION 'Số lượng không đủ';
            end if;

            UPDATE products
            SET stock = stock - v_quantity
            WHERE product_id = v_proid;

            INSERT INTO order_log (order_id, action_time)
            VALUES (v_orderid, NOW());

        EXCEPTION
            WHEN OTHERS THEN
            RAISE;
        end;
    end;
    $$;

CALL trans(1,1, 3);
CALL trans(1,1, 13);

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_log;




CREATE SCHEMA lamlai;

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



CREATE SCHEMA lamlai1;

CREATE TABLE OldCustomers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE NewCustomers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO OldCustomers (name, city)
VALUES ('Nguyen Van A', 'Ha Noi'),
    ('Tran Thi B', 'Ho Chi Minh'),
    ('Le Van C', 'Da Nang'),
    ('Pham Thi D', 'Hai Phong'),
    ('Hoang Van E', 'Can Tho');

INSERT INTO NewCustomers (name, city)
VALUES ('Nguyen Van A', 'Ha Noi'),
    ('Tran Thi B', 'Ho Chi Minh'),
    ('Vo Van F', 'Da Nang'),
    ('Nguyen Thi G', 'Hue'),
    ('Hoang Van E', 'Can Tho');

SELECT name, city FROM OldCustomers
UNION
SELECT name, city FROM NewCustomers;

SELECT name, city FROM OldCustomers
INTERSECT
SELECT name, city FROM NewCustomers;

SELECT city, COUNT(name) total_customers
FROM (
         SELECT name, city FROM OldCustomers
         UNION
         SELECT name, city FROM NewCustomers
     ) sub
GROUP BY city;

SELECT city, total_customers
FROM (
         SELECT city, COUNT(name) total_customers
         FROM (
                  SELECT name, city FROM OldCustomers
                  UNION
                  SELECT name, city FROM NewCustomers
              ) sub
         GROUP BY city
     ) t
WHERE total_customers = (
    SELECT MAX(total_customers)
    FROM (
             SELECT city, COUNT(name) total_customers
             FROM (
                      SELECT name, city FROM OldCustomers
                      UNION
                      SELECT name, city FROM NewCustomers
                  ) sub
             GROUP BY city
         ) t2
);


