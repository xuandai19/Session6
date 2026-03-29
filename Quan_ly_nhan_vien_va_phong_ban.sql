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
