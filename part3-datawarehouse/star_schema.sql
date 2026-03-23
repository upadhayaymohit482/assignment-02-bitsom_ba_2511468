CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    month_num INT NOT NULL,
    year_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    standard_unit_price DECIMAL(12,2) NOT NULL
);

CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    total_sales DECIMAL(14,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

INSERT INTO dim_date (date_id, full_date, month_num, year_num, month_name) VALUES
(1, '2023-01-15', 1, 2023, 'January'),
(2, '2023-02-05', 2, 2023, 'February'),
(3, '2023-02-20', 2, 2023, 'February'),
(4, '2023-03-31', 3, 2023, 'March'),
(5, '2023-08-09', 8, 2023, 'August'),
(6, '2023-08-15', 8, 2023, 'August'),
(7, '2023-08-29', 8, 2023, 'August'),
(8, '2023-10-26', 10, 2023, 'October'),
(9, '2023-12-08', 12, 2023, 'December'),
(10, '2023-12-12', 12, 2023, 'December');

INSERT INTO dim_store (store_id, store_name, store_city) VALUES
(1, 'Bangalore MG', 'Bangalore'),
(2, 'Chennai Anna', 'Chennai'),
(3, 'Delhi South', 'Delhi'),
(4, 'Pune FC Road', 'Pune');

INSERT INTO dim_product (product_id, product_name, category, standard_unit_price) VALUES
(1, 'Atta 10kg', 'Groceries', 52464.00),
(2, 'Biscuits', 'Groceries', 27469.99),
(3, 'Jeans', 'Clothing', 2317.47),
(4, 'Phone', 'Electronics', 48703.39),
(5, 'Smartwatch', 'Electronics', 58851.01),
(6, 'Speaker', 'Electronics', 49262.78),
(7, 'Tablet', 'Electronics', 23226.12);

INSERT INTO fact_sales (sales_id, transaction_id, date_id, store_id, product_id, units_sold, unit_price, total_sales) VALUES
(1, 'TXN5000', 7, 2, 6, 3, 49262.78, 147788.34),
(2, 'TXN5001', 10, 2, 7, 11, 23226.12, 255487.32),
(3, 'TXN5002', 2, 2, 4, 20, 48703.39, 974067.80),
(4, 'TXN5003', 3, 3, 7, 14, 23226.12, 325165.68),
(5, 'TXN5004', 1, 2, 5, 10, 58851.01, 588510.10),
(6, 'TXN5005', 5, 1, 1, 12, 52464.00, 629568.00),
(7, 'TXN5006', 4, 4, 5, 6, 58851.01, 353106.06),
(8, 'TXN5007', 8, 4, 3, 16, 2317.47, 37079.52),
(9, 'TXN5008', 9, 1, 2, 9, 27469.99, 247229.91),
(10, 'TXN5009', 6, 1, 5, 3, 58851.01, 176553.03);
