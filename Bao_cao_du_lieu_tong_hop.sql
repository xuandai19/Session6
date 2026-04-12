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


