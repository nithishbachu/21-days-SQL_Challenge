# 🚀 **Day 21 – Common Table Expressions (CTEs)**

## 🔹 What is a CTE?

A **CTE (Common Table Expression)** is a temporary, named result set defined using the `WITH` clause. Improves readability, query structure, and supports step-wise execution. Exists **only during the current SQL statement execution**.

---

## 🧠 Why Use CTEs?

✔ Makes queries clean & modular
✔ Avoids deeply nested subqueries
✔ Can be referenced multiple times
✔ Easy to test/debug each step
✔ Supports recursive logic (hierarchical data)

---

## 🧩 Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

### Multiple CTEs

```sql
WITH
cte1 AS (...),
cte2 AS (...)
SELECT * FROM cte1 JOIN cte2 ON ...;
```

---

## 🆚 CTEs vs Subquery

| Feature     | CTE     | Subquery               |
| ----------- | ------- | ---------------------- |
| Readability | ⭐⭐⭐⭐    | ⭐                      |
| Reusable    | ✔ Yes   | ❌ No                   |
| Performance | Depends | Better in simple cases |
| Debugging   | Easy    | Difficult              |

---

## 💡 Best Practices

🔹 Use **meaningful CTE names**

🔹 Break complex queries into **logical steps**

🔹 **Test each CTE separately first**

🔹 Use CTEs when subqueries become unreadable

🔹 Avoid overusing CTEs for simple queries

🔹 Use `NULLIF()` to prevent division by zero

🔹 Prefer CTEs over temporary tables unless caching is required

---

## 🛠️ Tips & Tricks

✔ Alias columns with clear names inside CTEs

✔ Use `ROUND()` & `NULLIF()` for safe calculations

✔ For performance-heavy repeated logic → use temp tables

✔ Write CTEs like writing a step-by-step data pipeline

✔ Debug by running only one CTE at a time

✔ Recursive CTEs are great for org hierarchy, referral chains, etc.

---

## 📚 Resources

📺 YouTube: *“SQL CTE Tutorial – Simplify Complex Queries”* → [https://youtu.be/K1WeoKxLZ5o?si=-HtQfJ0eXpC1pBaY](https://youtu.be/K1WeoKxLZ5o?si=-HtQfJ0eXpC1pBaY)

📖 Docs:
* SQL Server: [https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression](https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression)
* PostgreSQL: [https://www.postgresql.org/docs/current/queries-with.html](https://www.postgresql.org/docs/current/queries-with.html)
* MySQL: [https://dev.mysql.com/doc/refman/8.0/en/with.html](https://dev.mysql.com/doc/refman/8.0/en/with.html)
  🧠 Practice Platform: LeetCode SQL, HackerRank SQL

---

# 📝 Practice Questions

```sql
-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
SELECT service, COUNT(*) AS total_patients,
AVG(satisfaction) AS avg_satisfaction FROM patients GROUP BY service) 
SELECT * FROM service_stats 
WHERE avg_satisfaction > 75 
ORDER BY total_patients DESC;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH step1 AS (
SELECT service, COUNT(*) AS total_patients FROM patients GROUP BY service), 
step2 AS (SELECT service, SUM(patients_admitted) AS total_admissions FROM services_weekly GROUP BY service), 
step3 AS (SELECT s1.service, s1.total_patients, s2.total_admissions FROM step1 s1 
JOIN step2 s2 ON s1.service = s2.service) 
SELECT * FROM step3 
ORDER BY total_admissions DESC;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_utilization AS (
SELECT ss.service, COUNT(DISTINCT s.staff_id) AS total_staff,
AVG(ss.present) * 100 AS avg_weeks_present 
FROM staff s 
JOIN staff_schedule ss ON s.staff_id = ss.staff_id 
GROUP BY ss.service), 
patient_data AS (
SELECT service, COUNT(*) AS total_patients FROM patients GROUP BY service) 
SELECT su.service, su.total_staff, su.avg_weeks_present, pd.total_patients 
FROM staff_utilization su 
LEFT JOIN patient_data pd ON su.service = pd.service 
ORDER BY total_staff DESC;
```
---

# 🎯 Daily Challenge – Hospital Performance Dashboard

**Create a comprehensive hospital performance dashboard using CTEs.**
Calculate:

1. **Service-level metrics** (**total admissions**, **refusals**, **avg satisfaction**)
2. **Staff metrics per service** (**total staff**, **avg weeks present**)
3. **Patient demographics per service** (**avg age**, **count**)

Then **combine all three CTEs** to create a **final report** showing:

* **service name**,
* **all calculated metrics**, and
* an **overall performance score** *(weighted average of **admission rate** and **satisfaction**)*.

Finally, **order the results by performance score descending**.

---

### 🔥 Final Solution Query

```sql
WITH
service_metrics AS (
    SELECT sw.service,
           SUM(sw.patients_admitted) AS total_admissions,
           SUM(sw.patients_refused) AS total_refusals,
           AVG(sw.patient_satisfaction) AS avg_satisfaction
    FROM services_weekly sw
    GROUP BY sw.service
),
staff_metrics AS (
    SELECT ss.service,
           COUNT(DISTINCT s.staff_id) AS total_staff,
           AVG(ss.present) * 100 AS avg_weeks_present
    FROM staff s
    JOIN staff_schedule ss ON s.staff_id = ss.staff_id
    GROUP BY ss.service
),
patient_metrics AS (
    SELECT service,
           AVG(age) AS avg_age,
           COUNT(*) AS total_patients
    FROM patients
    GROUP BY service
)
SELECT
    sm.service,
    sm.total_admissions,
    sm.total_refusals,
    sm.avg_satisfaction,
    stm.total_staff,
    stm.avg_weeks_present,
    pm.avg_age,
    pm.total_patients,
    ROUND(100.0 * sm.total_admissions /
        NULLIF(sm.total_admissions + sm.total_refusals, 0), 2) AS admission_rate,
    ROUND(((0.6 * (100.0 * sm.total_admissions /
        NULLIF(sm.total_admissions + sm.total_refusals, 0))) +
        (0.4 * sm.avg_satisfaction)), 2) AS performance_score
FROM service_metrics sm
LEFT JOIN staff_metrics stm ON sm.service = stm.service
LEFT JOIN patient_metrics pm ON sm.service = pm.service
ORDER BY performance_score DESC;
```

---

# 📍 Key Takeaways

✔ CTEs make complex SQL logic **readable and modular**

✔ Ideal for **dashboards, analytics, and multi-step calculations**

✔ Supports **recursive logic for hierarchies & organization chains**

✔ Use CTEs like "functions inside SQL" for reusability & clarity
