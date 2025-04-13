CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publisher_id INT,
    published_year YEAR,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100),
    city VARCHAR(100),
    country_id INT,
    postal_code VARCHAR(20),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50)
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    shipping_address_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (shipping_address_id) REFERENCES address(address_id)
);

CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);
CREATE TABLE order_history (
    order_id INT,
    status_id INT,
    change_date DATETIME,
    PRIMARY KEY (order_id, status_id, change_date),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);


INSERT INTO book_language (name) VALUES 
('English'), ('French'), ('Spanish');

INSERT INTO publisher (name) VALUES 
('The Boy who cried Wolf'), 
('Harry Porter'), 
('House of Maridom');

INSERT INTO author (first_name, last_name) VALUES 
('Pelumi', 'Orwell'), 
('Jane', 'Timothy'), 
('Shane', 'Twain');

INSERT INTO book (title, publisher_id, published_year, language_id) VALUES 
('1984', 1, 1949, 1), 
('Pride and Prejudice', 2, 1913, 1), 
('Adventures of Huckleberry Finn', 3, 1941, 1);

INSERT INTO country (name) VALUES 
('Nigeria'), 
('USA'), 
('UK');

INSERT INTO address_status (status_name) VALUES 
('Primary'), 
('Secondary');

INSERT INTO address (street, city, country_id, postal_code) VALUES 
('123 Book Street', 'Lagos', 1, '100001'), 
('456 Novel Avenue', 'New York', 2, '10001');

INSERT INTO customer (first_name, last_name, email) VALUES 
('Pelumi', 'Johnson', 'pelumi@gmail.com'), 
('Ada', 'Williams', 'ada@gmail.com');

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(1, 1, 1), 
(2, 2, 1);

INSERT INTO shipping_method (name) VALUES 
('Standard Delivery'), 
('Express Shipping');

INSERT INTO order_status (status) VALUES 
('Processing'), 
('Shipped'), 
('Delivered');

INSERT INTO cust_order (customer_id, order_date, shipping_method_id, shipping_address_id) VALUES 
(1, '2025-04-09', 1, 1), 
(2, '2025-04-10', 2, 2);


INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3);

INSERT INTO order_line (order_id, book_id, quantity) VALUES 
(1, 1, 2), 
(2, 2, 1), 
(2, 3, 1);


INSERT INTO order_history (order_id, status_id, change_date) VALUES 
(1, 1, '2025-04-09 10:00:00'), 
(1, 2, '2025-04-10 12:30:00'),
(2, 1, '2025-04-10 08:45:00');



-- ROLES AND PERMISSIONS
-- Create roles for database access
CREATE ROLE 'Admin';
CREATE ROLE 'Manager';
CREATE ROLE 'Viewer';

-- Grant privileges to roles
-- Admin: Full control over all tables
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'Admin';

-- Manager: Can manage orders, customers, and inventory
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.cust_order TO 'Manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_db.order_line TO 'Manager';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.customer TO 'Manager';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.address TO 'Manager';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.book TO 'Manager';
GRANT SELECT ON bookstore_db.author TO 'Manager';

-- Viewer: Read-only access to most tables
GRANT SELECT ON bookstore_db.book TO 'Viewer';
GRANT SELECT ON bookstore_db.author TO 'Viewer';
GRANT SELECT ON bookstore_db.publisher TO 'Viewer';
GRANT SELECT ON bookstore_db.book_language TO 'Viewer';
GRANT SELECT ON bookstore_db.customer TO 'Viewer';
GRANT SELECT ON bookstore_db.cust_order TO 'Viewer';
GRANT SELECT ON bookstore_db.order_line TO 'Viewer';

-- Create users for database access
CREATE USER 'pelumi'@'localhost' IDENTIFIED BY 'password1';
CREATE USER 'duncan'@'localhost' IDENTIFIED BY 'password2';
CREATE USER 'john'@'localhost' IDENTIFIED BY 'password3';

-- Assign roles to users
GRANT 'Admin' TO 'pelumi'@'localhost';
GRANT 'Manager' TO 'duncan'@'localhost';
GRANT 'Viewer' TO 'john'@'localhost';

-- Apply role privileges
SET DEFAULT ROLE 'Admin' FOR 'pelumi'@'localhost';
SET DEFAULT ROLE 'Manager' FOR 'duncan'@'localhost';
SET DEFAULT ROLE 'Viewer' FOR 'john'@'localhost';

-- Reload privileges
FLUSH PRIVILEGES;