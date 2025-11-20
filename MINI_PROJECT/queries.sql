-- Phase 1: Foundation & Inspection

-- 1. Install IDC_Pizza.dump as IDC_Pizza server
createdb IDC_Pizza
-- create tables(order_details, orders, pizza_types, pizzas).
-- Example
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,   -- e.g., 'bbq_ckn_s'
    pizza_type_id VARCHAR(50) REFERENCES pizza_types(pizza_type_id),
    size VARCHAR(10),                   -- e.g., 'S', 'M', 'L'
    price NUMERIC(5, 2)                 -- e.g., 12.75
);
-- Insert data in tables
-- Example
INSERT INTO pizzas (pizza_id, pizza_type_id, size, price) VALUES ('bbq_ckn_s','bbq_ckn','S',12.75);

-- 2. List all unique pizza categories (`DISTINCT`).
SELECT DISTINCT category FROM pizza_types;

-- 3. Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`.Show first 5 rows.
SELECT pizza_type_id, name, COALESCE(ingredients, 'Missing Data') AS ingredients FROM pizza_types LIMIT 5;

-- 4. Check for pizzas missing a price (`IS NULL`).
SELECT * FROM pizzas WHERE price IS NULL;

-- Phase 2: Filtering & Exploration

-- 1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
SELECT * FROM orders WHERE "date" = '2015-01-01';

-- 2. List pizzas with `price` descending.
SELECT * FROM pizzas ORDER BY price DESC;

-- 3. Pizzas sold in sizes `'L'` or `'XL'`.
SELECT p.* FROM pizzas p JOIN order_details od ON p.pizza_id = od.pizza_id WHERE p.size IN ('L', 'XL');

-- 4. Pizzas priced between $15.00 and $17.00.
SELECT * FROM pizzas WHERE price BETWEEN 15.00 AND 17.00 ORDER BY price;

-- 5. Pizzas with `"Chicken"` in the name.
SELECT * FROM pizza_types WHERE name LIKE '%Chicken%';

-- 6. Orders on `'2015-02-15'` or placed after 8 PM.
SELECT * FROM orders WHERE "date" = '2015-02-15' OR EXTRACT(hour FROM time) > 20 ORDER BY time;

-- **Phase 3: Sales Performance**

-- 1. Total quantity of pizzas sold (`SUM`).
SELECT SUM(quantity) AS total_pizzas_sold FROM order_details;

-- 2. Average pizza price (`AVG`).
SELECT ROUND(AVG(price), 3) AS avg_pizza_price FROM pizzas;

-- 3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
SELECT od.order_id, od.pizza_id, od.quantity, SUM(od.quantity * COALESCE(p.price, 0)) 
FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id 
GROUP BY od.order_id, od.pizza_id, od.quantity
ORDER BY order_id; 

-- 4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity;

-- 5. Categories with more than 5,000 pizzas sold (`HAVING`).
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category HAVING SUM(od.quantity) > 5000
ORDER BY total_quantity;

-- 6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
SELECT p.* FROM pizzas p LEFT JOIN order_details od ON p.pizza_id = od.pizza_id WHERE od.pizza_id IS NULL;

-- 7. Price differences between different sizes of the same pizza (`SELF JOIN`).
SELECT p1.pizza_type_id, pt.name, p1.size AS size1, p1.price AS price1, p2.size AS size2, p2.price AS price2,
ABS(p1.price-p2.price) AS price_difference
FROM pizzas p1 JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id AND p1.size != p2.size
JOIN pizza_types pt ON p1.pizza_type_id = pt.pizza_type_id
WHERE p1.size < p2.size
ORDER BY price_difference;
