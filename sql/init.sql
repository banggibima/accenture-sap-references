CREATE DATABASE accenture_sap_references;

USE accenture_sap_references;

CREATE TABLE IF NOT EXISTS m_product
(
    product_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name            VARCHAR(255) NULL,
    stock_qty       INT UNSIGNED NULL,
    sell_unit_price INT UNSIGNED NULL,
    PRIMARY KEY (product_id)
);

ALTER TABLE m_product
    AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS m_customer
(
    customer_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NULL,
    address     TEXT         NULL,
    mobile      VARCHAR(255) NULL,
    PRIMARY KEY (customer_id)
);

ALTER TABLE m_customer
    AUTO_INCREMENT = 100001;

CREATE TABLE IF NOT EXISTS t_order
(
    order_id    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    order_date  DATETIME        NOT NULL,
    customer_id INT UNSIGNED    NOT NULL,
    paid        CHAR(1)         NOT NULL,
    PRIMARY KEY (order_id)
);

ALTER TABLE t_order
    ADD CONSTRAINT fk_customer_id
        FOREIGN KEY (customer_id) REFERENCES m_customer (customer_id);

ALTER TABLE t_order
    AUTO_INCREMENT = 1000000001;

CREATE TABLE IF NOT EXISTS t_order_detail
(
    order_id   BIGINT UNSIGNED NOT NULL,
    product_id INT UNSIGNED    NOT NULL,
    qty        INT             NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

ALTER TABLE t_order_detail
    ADD CONSTRAINT fk_order_id
        FOREIGN KEY (order_id) REFERENCES t_order (order_id);

ALTER TABLE t_order_detail
    ADD CONSTRAINT fk_product_id
        FOREIGN KEY (product_id) REFERENCES m_product (product_id);

INSERT INTO m_product (name, stock_qty, sell_unit_price)
VALUES ('Orange', 100, 20000),
       ('Apple', 80, 35000),
       ('Guava', 45, 24000),
       ('Soursop', 33, 27000),
       ('Mango', 120, 47000);

INSERT INTO m_customer (name, address, mobile)
VALUES ('Randy', 'Jl. Gading Nias 10a', '628189991111'),
       ('Linda', 'Jl. Kramat Raya 88', '6285510101010'),
       ('Keiko', 'Jl. Sekolah Duta Raya 2', '628119929202'),
       ('Maudy', 'Jl. Kemang Timur 99', '52811767878');

INSERT INTO t_order (order_date, customer_id, paid)
VALUES ('2017-10-10', 100002, 'Y'),
       ('2017-10-12', 100003, 'Y'),
       ('2017-10-12', 100001, 'N'),
       ('2017-10-15', 100004, 'N'),
       ('2017-10-16', 100002, 'N');

INSERT INTO t_order_detail (order_id, product_id, qty)
VALUES (1000000001, 1, 7),
       (1000000001, 3, 9),
       (1000000002, 4, 8),
       (1000000002, 2, 10),
       (1000000003, 2, 10),
       (1000000003, 5, 20),
       (1000000004, 3, 6),
       (1000000005, 1, 20);

SELECT *
FROM m_product;

SELECT *
FROM m_customer;

SELECT *
FROM t_order;

SELECT *
FROM t_order_detail;

SELECT m_customer.name                                     AS customer_name,
       t_order.order_date                                  AS order_date,
       SUM(t_order_detail.qty * m_product.sell_unit_price) AS total_unpaid_balance
FROM t_order
         INNER JOIN
     m_customer ON t_order.customer_id = m_customer.customer_id
         INNER JOIN
     t_order_detail ON t_order.order_id = t_order_detail.order_id
         INNER JOIN
     m_product ON t_order_detail.product_id = m_product.product_id
WHERE t_order.paid = 'N'
GROUP BY m_customer.name, t_order.order_date;
