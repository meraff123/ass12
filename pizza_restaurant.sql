USE pizza_restaurant;

-- Create customers table

CREATE TABLE customers (
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(200)  NOT NULL,
    customer_phone_number VARCHAR(100) NOT NULL,
    PRIMARY KEY (customer_id)
);

-- Create orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT NOT NULL AUTO_INCREMENT,
    date_time DATETIME,
    order_customer_id INT,
    
    
    
    PRIMARY KEY (order_id),
    FOREIGN KEY (order_customer_id) REFERENCES customers (customer_id)
);

-- Create pizzas table
DROP TABLE IF EXISTS pizzas;
CREATE TABLE pizzas (
    pizza_id INT NOT NULL AUTO_INCREMENT,
    pizza_type VARCHAR(255) NOT NULL,
    pizza_price DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (pizza_id)
);

-- Create join table for orders and pizzas
DROP TABLE IF EXISTS order_pizza;
CREATE TABLE order_pizza (
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas (pizza_id)
);

-- Populate customers
INSERT INTO customers (customer_name, customer_phone_number)
VALUES ('Trevor Page', '226-555-4982'),
       ('John Doe', '555-555-9498');

-- Populate pizzas
INSERT INTO pizzas (pizza_type, pizza_price)
VALUES ('Pepperoni & Cheese', 7.99),
       ('Vegetarian', 9.99),
       ('Meat Lovers', 14.99),
       ('Hawaiian', 12.99);

-- Populate orders
-- Order #1
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-09-10 09:47:00', 1);

-- Insert order-pizza relationship
INSERT INTO order_pizza (order_id, pizza_id)
VALUES (1, 1), -- Pepperoni & Cheese
       (1, 3); -- Meat Lovers

-- Order #2
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-09-10 13:20:00', 2);

-- Insert order-pizza relationship
INSERT INTO order_pizza (order_id, pizza_id)
VALUES (2, 2), -- Vegetarian
       (2, 3), -- Meat Lovers
       (2, 3); -- Meat Lovers

-- Order #3
INSERT INTO orders (date_time, order_customer_id)
VALUES ('2014-09-10 09:47:00', 1);

-- Insert order-pizza relationship
INSERT INTO order_pizza (order_id, pizza_id)
VALUES (3, 3), -- Meat Lovers
       (3, 4); -- Hawaiian

-- Query to get how much each customer spent
SELECT c.customer_name AS 'Customer Name', SUM(p.pizza_price) AS 'Total Amount Spent'
FROM customers c
JOIN orders o ON c.customer_id = o.order_customer_id
JOIN order_pizza op ON o.order_id = op.order_id
JOIN pizzas p ON op.pizza_id = p.pizza_id
GROUP BY c.customer_id;

-- Query to number 5
SELECT c.Name AS CustomerName, DATE(o.OrderDateTime) AS OrderDate, SUM(p.Price * oi.Quantity) AS TotalAmountSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Pizzas p ON oi.PizzaID = p.PizzaID
GROUP BY c.CustomerID, c.Name, DATE(o.OrderDateTime);


