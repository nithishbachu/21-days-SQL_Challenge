# 🗓️ Day 4 – Mastering LIMIT and OFFSET

### 📘 Topics Covered
- Understanding `LIMIT` and `OFFSET`
- Controlling how many rows a query returns
- Pagination logic using `LIMIT` and `OFFSET`
- Combining with `ORDER BY` for better data control

### 💡 Key Points

- `LIMIT` restricts **how many rows** are returned.  
- `OFFSET` skips a specific number of rows **before starting to return results**.  
- Commonly used together for **pagination** — showing results page by page.  
- Always pair with `ORDER BY` for **predictable and consistent results**.  
- `OFFSET` starts counting from **0** (so `OFFSET 10` skips the first 10 rows).  

### 💻 Practice Queries

```sql
-- Display the first 5 patients from the patients table.
SELECT *
FROM patients
LIMIT 5;

-- Show patients 11–20 using OFFSET.
SELECT *
FROM patients
LIMIT 10 OFFSET 10;

-- Get the 10 most recent patient admissions based on arrival_date.
SELECT *
FROM patients
ORDER BY arrival_date DESC
LIMIT 10;
````

### 🎯 Challenge

#### Question:

Find the 3rd to 7th highest patient satisfaction scores from the patients table, showing patient_id, name, service, and satisfaction. Display only these 5 records.

### 💡 Thought Process

* We’re focusing on **satisfaction scores**, so we sort by the `satisfaction` column in **descending** order to get the highest first.
* Since we need the **3rd to 7th** highest scores, the **first two** should be skipped — hence `OFFSET 2`.
* We want only **five records** — so we apply `LIMIT 5`.
* Selecting only relevant columns makes the result concise and clear.

### 🧠 Query

```sql
SELECT patient_id, name AS patient_name, service, satisfaction AS satisfaction_score
FROM patients
ORDER BY satisfaction DESC
LIMIT 5 OFFSET 2;
```

### 🚀 Takeaway

Pagination isn’t just for web apps — it’s a *data control superpower*.
With `LIMIT` and `OFFSET`, you decide what’s visible and what stays hidden — just like a pro filtering results with precision.

```
```
