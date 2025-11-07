# 🗓️ Day 5 – Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

### 📘 Topics Covered
- Using aggregate functions to summarize data  
- Understanding `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`  
- Handling NULL values in aggregates  
- Combining multiple aggregate functions in one query  
- Rounding and aliasing aggregate outputs for better readability  

---

### 💡 Key Points
- Aggregate functions **perform calculations across multiple rows** and return a **single summarized value**.  
- Commonly used for **data summaries** like totals, averages, minimums, or maximums.  
- `COUNT(*)` counts all rows (including NULLs), while `COUNT(column)` ignores NULLs.  
- `SUM()` and `AVG()` only apply to numeric columns.  
- Aggregates ignore NULLs (except `COUNT(*)`).  
- You can use `ROUND()` to format numeric results.  
- Always alias your outputs for **clarity** and **readability**.  

---

### 💻 Practice Queries
```sql
-- Count all patients in the hospital
SELECT COUNT(*) AS total_patients
FROM patients;

-- Find multiple aggregates at once
SELECT
    COUNT(*) AS total_patients,
    AVG(age) AS avg_age,
    MIN(age) AS youngest_patient,
    MAX(age) AS oldest_patient,
    SUM(satisfaction) AS total_satisfaction
FROM patients;

-- Find average satisfaction score for a specific service
SELECT AVG(satisfaction) AS avg_satisfaction
FROM patients
WHERE service = 'Cardiology';
````

---

### 🎯 Challenge

#### Question:

Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks.
Round the average satisfaction to 2 decimal places.

---

### 💡 Thought Process

* The data about weekly admissions and refusals is stored in the **`services_weekly`** table.
* To get totals, we use the **`SUM()`** function on both `patients_admitted` and `patients_refused`.
* To calculate the overall average satisfaction, we apply **`AVG()`**.
* Since we’re summarizing across all services and weeks, **no GROUP BY** is needed.
* Finally, we wrap the average in **`ROUND()`** to display only two decimal places.

---

### 🧠 Challenge Query

```sql
-- Calculate total admitted, total refused, and average satisfaction (rounded to 2 decimals)
SELECT
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(AVG(satisfaction), 2) AS avg_satisfaction
FROM services_weekly;
```

```
```
