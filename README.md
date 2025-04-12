Bookstore Database Project

This project is a MySQL-based relational database designed for managing a bookstore's operations. It was developed as a group assignment to practice database design, SQL programming, and data analysis.

---

Project Overview

The goal of this project is to build a structured and secure relational database system that stores and manages:
- Books and their authors
- Customers and their addresses
- Orders and shipping details

---

 Technologies Used

- MySQL: For database creation, data insertion, and querying
- Draw.io: For designing the ERD (Entity Relationship Diagram)

---

 Database Structure

The database consists of the following tables:

| Table Name         | Description |
|--------------------|-------------|
| `book`             | Stores book details |
| `author`           | Stores author details |
| `book_author`      | Many-to-many relationship between books and authors |
| `book_language`    | List of languages books can be written in |
| `publisher`        | Publisher information |
| `customer`         | Customer information |
| `address`          | Physical address details |
| `customer_address` | Connects customers to multiple addresses |
| `address_status`   | Tracks status of addresses (e.g., primary, old) |
| `country`          | List of countries for addresses |
| `cust_order`       | Orders placed by customers |
| `order_line`       | Items within each order |
| `order_status`     | Order status stages (e.g., shipped, delivered) |
| `order_history`    | Tracks changes to order status |
| `shipping_method`  | Different methods used for shipping |

---

Setup Instructions

1. Clone this Repository

```bash
git clone https://github.com/KamungeD/PLPDatabaseGroupAssignment1.git

