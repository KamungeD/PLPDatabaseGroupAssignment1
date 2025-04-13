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

-- Create users
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

-- Finalize changes
FLUSH PRIVILEGES;