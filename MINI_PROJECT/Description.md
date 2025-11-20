# 🧩 MINI PROJECT — The Great Pizza Analytics Challenge

### Welcome to **The Great Pizza Analytics Challenge** 🍕

You are the data analyst for **IDC Pizza**, and your job is to turn raw pizza sales data into meaningful insights using SQL.

This mini-project covers everything you’ve learned up to **Day 15**:

* Database creation & table structure
* Filtering (`WHERE`, `IN`, `BETWEEN`, `LIKE`, operators)
* Aggregation (`SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`)
* Joins (INNER, LEFT, RIGHT, FULL, SELF)
* Data cleaning (`DISTINCT`, `COALESCE`, handling NULLs)

---

## 📁 Database Files Provided

Use any one method:

* **PostgreSQL Dump:** `IDC_Pizza.dump`
* **SQL Files:** `Create_Table.sql`, `pizza_types.sql`, `pizzas.sql`, `orders.sql`, `order_details.sql`

---

## 🔧 Setup Instructions

### **Option A: Restore `.dump` File (PostgreSQL / pgAdmin)**

1. Create a database named **IDC_Pizza**.
2. Right-click → **Restore…**
3. Choose `IDC_Pizza.dump`.
4. Set format: *Custom/Tar*.
5. Click **Restore** → verify tables under schema `public`.

### **Option B: Execute SQL Scripts**

Order:

1. `Create_Table.sql`
2. `pizza_types.sql`
3. `pizzas.sql`
4. `orders.sql`
5. `order_details.sql`


---

## 🧩 Project Questions

### **Phase 1 — Foundation & Inspection**

1. Install or restore the `IDC_Pizza` database.
2. List all **unique pizza categories** using `DISTINCT`.
3. Show `pizza_type_id`, `name`, and `ingredients`, replacing `NULL` ingredients with `"Missing Data"`. Limit to **first 5 rows**.
4. Check for pizzas that **have no price** (`IS NULL`).

---

### **Phase 2 — Filtering & Exploration**

1. Orders placed on `'2015-01-01'`.
2. List pizzas sorted by `price` in descending order.
3. Pizzas sold in sizes `'L'` or `'XL'`.
4. Pizzas priced between `$15.00` and `$17.00`.
5. Pizzas with `"Chicken"` in the name.
6. Orders placed on `'2015-02-15'` **or** placed **after 8 PM**.

---

### **Phase 3 — Sales Performance**

1. Total quantity of pizzas sold.
2. Average pizza price.
3. **Total order value per order** (use JOIN + SUM + GROUP BY).
4. Total quantity sold per pizza **category** (JOIN pizzas → pizza_types).
5. Categories with **more than 5,000 pizzas sold** (`HAVING`).
6. **Pizzas never ordered** (LEFT or RIGHT JOIN logic).
7. **Price differences** between different sizes of the **same pizza** (SELF JOIN).

---

## 📝 Rules & Good Practices

* Write **one SQL query per question**.
* Do not include query output.
* Keep queries formatted cleanly.
* Use aliases (`p`, `pt`, `od`, `o`) for readability.
* Use `COALESCE()` to replace NULLs.
* Test joins incrementally (add one table at a time).
* Prefer ISO dates: `'YYYY-MM-DD'`.

---

## 💡 Helpful Hints

* Use `COUNT(DISTINCT …)` when needed.
* Use `ORDER BY` for inspections and debugging.
* Use `LEFT JOIN` to find missing data (like pizzas never ordered).
* Use `SELF JOIN` to compare pizza sizes/prices.
* If duplicate rows appear, re-check join keys.

---

## 🎯 Final Mission

Solve all **14 SQL tasks** using your learning from Days 1–15.
This project is designed to reinforce joins, aggregation, filtering, and relational thinking — the core of SQL analytics.
