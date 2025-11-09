# 🗓️ Day 6 – GROUP BY Clause

### 📘 Topics Covered

* Grouping data into categories using `GROUP BY`
* Applying aggregate functions per group (`COUNT`, `SUM`, `AVG`, etc.)
* Grouping by multiple columns for deeper insights
* Using `WHERE` and `HAVING` to filter before and after grouping
* Ordering grouped results with `ORDER BY`

---

### 💡 Key Points

* `GROUP BY` **divides rows into groups** based on column values.
* Each group returns **one summarized row**.
* Every non-aggregated column in `SELECT` **must appear** in `GROUP BY`.
* `WHERE` filters rows *before* grouping; `HAVING` filters *after* grouping.
* Combine `GROUP BY` with aggregates like `COUNT()`, `SUM()`, `AVG()`, `MAX()`, and `MIN()`.
* You can **group by multiple columns** for finer granularity.
* Always use `ORDER BY` to make grouped results more readable.

---

### 💻 Practice Queries

```sql
-- Count the number of patients by each service.
SELECT service, COUNT(*) AS count
FROM patients
GROUP BY service;

-- Calculate the average age of patients grouped by service.
SELECT service, ROUND(AVG(age), 2) AS age
FROM patients
GROUP BY service;

-- Find the total number of staff members per role.
SELECT role AS staff_role, COUNT(*)
FROM staff
GROUP BY role;
```

---

### 🎯 Challenge

#### Question:

For each hospital service, calculate:

* Total patients **admitted**
* Total patients **refused**
* The **admission rate** (percentage of requests that were admitted)

Order the results by **admission rate (highest first)**.

---

### 💡 Thought Process

* We’re analyzing hospital performance by **service**, so we need to group by the `service` column.
* The data (admitted/refused counts) comes from the **`services_weekly`** table.
* To find totals, we use `SUM()` on both `patients_admitted` and `patients_refused`.
* The admission rate is the ratio of admitted to total requests, multiplied by 100 for a percentage.
* Finally, use `ORDER BY` to sort services with the highest admission rates first.

---

### 🧠 Challenge Query

```sql
SELECT
    service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(
        (SUM(patients_admitted) * 100.0 / 
        SUM(patients_request)), 2
    ) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;
```
