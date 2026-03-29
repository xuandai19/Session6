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
