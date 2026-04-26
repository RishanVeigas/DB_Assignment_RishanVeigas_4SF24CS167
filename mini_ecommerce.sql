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