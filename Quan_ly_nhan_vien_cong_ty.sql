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
