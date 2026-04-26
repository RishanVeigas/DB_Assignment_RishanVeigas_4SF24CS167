CREATE database if not exists mini_ecommerce;
use mini_ecommerce;

CREATE TABLE if not exists customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
) ;

CREATE TABLE if not exists  categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
) ;

CREATE TABLE if not exists  products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
        ON DELETE SET NULL
) ;

CREATE TABLE if not exists  orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    status VARCHAR(50),
    coupon_code VARCHAR(50),  -- simplified
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
) ;

CREATE TABLE if not exists  order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price_at_purchase DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE
);

CREATE TABLE if not exists  payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE
) ;

INSERT INTO customers (customer_id, name, email) VALUES
(1, 'Rishan ', 'Rishan@gmail.com'),
(2, 'Shaktidhar', 'Shakti@gmail.com'),
(3, 'rohit mehra', 'rohit@gmail.com'),
(4, 'Sneha Iyer', 'sneha@gmail.com'),
(5, 'Karan Mehta', 'karan@gmail.com'),
(6, 'Ananya Reddy', 'ananya@gmail.com'),
(7, 'Rahul Das', 'rahul@gmail.com'),
(8, 'Neha Patel', 'neha@gmail.com');

INSERT INTO categories (category_id, name) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Books'),
(4, 'Home Appliances');

INSERT INTO products (product_id, name, price, category_id) VALUES
(1, 'Wireless Mouse', 599.00, 1),
(2, 'Bluetooth Headphones', 1999.00, 1),
(3, 'Men T-Shirt', 499.00, 2),
(4, 'Women Kurti', 899.00, 2),
(5, 'Data Structures Book', 699.00, 3),
(6, 'Novel - Fiction', 399.00, 3),
(7, 'Mixer Grinder', 2499.00, 4),
(8, 'Electric Kettle', 1299.00, 4);

INSERT INTO orders (order_id, customer_id, status, coupon_code, created_at) VALUES
(1, 1, 'Placed', 'NEW10', NOW()),
(2, 2, 'Shipped', NULL, NOW()),
(3, 3, 'Delivered', 'SAVE20', NOW()),
(4, 1, 'Delivered', NULL, NOW()),
(5, 4, 'Placed', NULL, NOW()),
(6, 5, 'Shipped', 'FESTIVE', NOW());

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 2, 599.00),
(1, 3, 1, 499.00),
(2, 2, 1, 1999.00),
(3, 5, 2, 699.00),
(3, 6, 1, 399.00),
(4, 4, 1, 899.00),
(4, 3, 2, 499.00),
(5, 7, 1, 2499.00),
(6, 8, 2, 1299.00);        

INSERT INTO payments (payment_id, order_id, amount, method, status) VALUES
(1, 1, 1697.00, 'UPI', 'Completed'),
(2, 2, 1999.00, 'Credit Card', 'Completed'),
(3, 3, 1797.00, 'Debit Card', 'Completed'),
(4, 4, 1897.00, 'UPI', 'Completed'),
(5, 5, 2499.00, 'Cash on Delivery', 'Pending'),
(6, 6, 2598.00, 'Net Banking', 'Completed');


--Query to find the total amount per order
SELECT o.order_id, SUM(oi.quantity * oi.price_at_purchase) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;