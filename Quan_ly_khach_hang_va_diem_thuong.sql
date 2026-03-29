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
