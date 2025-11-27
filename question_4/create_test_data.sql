-- SQLite
-- DROP
DROP TABLE IF EXISTS "ORDER";
DROP TABLE IF EXISTS ORDER_DELIVERY;

-- CREATE TABLE ORDER
CREATE TABLE "ORDER" (
    order_id INTEGER PRIMARY KEY,
    date_order DATE,
    good_type TEXT,
    good_amount INTEGER,
    client_id INTEGER
);

-- CREATE TABLE ORDER_DELIVERY
CREATE TABLE ORDER_DELIVERY (
    order_id INTEGER,
    date_delivery DATE,
    delivery_employee_code TEXT
    -- FOREIGN KEY(order_id) REFERENCES "ORDER"(order_id)
);

-- INSERT ORDER DATA
INSERT INTO "ORDER" VALUES
(10, '2019-05-01', 'Computer', 10000000, 88),
(24, '2020-06-06', 'Laptop', 8000000, 123),
(35, '2020-10-07', 'Monitor', 3000000, 10),
(15, '2025-07-05', 'Keyboard', 500000, 88),
(2,  '2025-07-20', 'Mouse',  200000, 88),
(3,  '2025-07-21', 'Mouse',  200000, 123),
(4,  '2025-07-22', 'Mouse',  200000, 123),
(5,  '2025-07-23', 'Mouse',  200000, 123),
(6,  '2025-07-24', 'Mouse',  200000, 123),
(7,  '2025-07-25', 'Mouse',  200000, 123),
(8,  '2025-07-26', 'Mouse',  200000, 123),
(9,  '2025-07-27', 'Mouse',  200000, 123),
(91,  '2025-07-28', 'Mouse',  200000, 123),
(92,  '2025-07-29', 'Mouse',  200000, 123),
(93,  '2025-07-30', 'Mouse',  200000, 123),
(95,  '2025-11-27', 'Mouse',  200000, 123),
(11, '2019-09-15', 'Computer', 2811, 10)
;

-- INSERT DELIVERY DATA
INSERT INTO ORDER_DELIVERY (order_id, date_delivery, delivery_employee_code) VALUES
(15, '06.Jul.2020', '1a'),
(2, '22.Apr.2017', '5c'),
(3, '09.Nov.2018', '6e'),
(10, '15.Sep.2019', '2b'),
(11, '30.Sep.2019', '3d')
;
