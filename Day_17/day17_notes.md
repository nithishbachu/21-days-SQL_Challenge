# 🗓️ Day 17 – Subqueries (SELECT & FROM Clause)

### 📘 Topics Covered

* Subqueries inside `SELECT`
* Derived tables / inline views (`FROM ( … ) AS alias`)
* Multi-level subqueries
* Using subqueries for comparisons, rankings, and calculations

---

### 💡 Key Points

* Subqueries allow you to **compute values dynamically** for each row.
* A subquery in `SELECT` must return **a single scalar value**.
* A subquery in `FROM` becomes a **temporary table** (derived table).
* Derived tables **must** have an alias.
* Subqueries can be nested multiple layers deep.
* Correlated subqueries run once **per row** and may be slower.
* Derived tables help break down complex logic into readable pieces.

---

### 💻 Practice Queries

```sql
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id, p.name, p.service, p.satisfaction,(
SELECT AVG(satisfaction) FROM patients p2
WHERE p2.service = p.service) AS service_avg_satisfaction
FROM patients p
ORDER BY p.service, p.patient_id;

-- 2. Create a derived table of service statistics and query from it.
SELECT stats.service, stats.total_patients, stats.avg_satisfaction  
FROM(SELECT service, COUNT(*) AS total_patients, AVG(patient_satisfaction) AS avg_satisfaction
FROM services_weekly
GROUP BY service) AS stats
ORDER BY stats.total_patients DESC;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT s.staff_id, s.staff_name, s.service,(SELECT COUNT(*) FROM patients p 
WHERE p.service = s.service) AS service_patient_count
FROM staff s
ORDER BY s.service, s.staff_id;
```

---

### 🎯 Challenge

#### Question:

Create a report showing each **service** with:

* service name
* total patients admitted
* the difference between their total admissions and the average admissions across all services
* rank indicator:

  * `'Above Average'`
  * `'Average'`
  * `'Below Average'`

Order the output by **total patients admitted DESC**.

---

### 💡 Thought Process

* Use a derived table to calculate **total admissions per service**.
* Calculate the **overall average** with a subquery.
* Use a `CASE` statement for ranking logic.
* Finally, sort results by total admissions.

---

### 🧠 Challenge Query

```sql
SELECT service, total_admissions, total_admissions - avg_total AS diff_from_avg,
CASE WHEN total_admissions > avg_total THEN 'Above Average'
WHEN total_admissions = avg_total THEN 'Average'
ELSE 'Below Average' END AS rank_status
FROM(SELECT service, COUNT(*) AS total_admissions,
ROUND(AVG(COUNT(*)) OVER (), 2) AS avg_total
FROM patients
GROUP BY service) AS sub
ORDER BY total_admissions DESC;
```
