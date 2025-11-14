# 🗓️ Day 11 – DISTINCT and Handling Duplicates

### 📘 Topics Covered

* Using `DISTINCT` to remove duplicate rows
* Finding unique values and unique combinations
* Counting distinct values
* Difference between `DISTINCT` and `GROUP BY`
* Performance considerations when working with duplicate-heavy datasets

---

### 💡 Key Points

* `DISTINCT` returns **unique** rows from a result set.
* It considers **all columns together**, not individually.
* Use `DISTINCT` when you need unique values; use `GROUP BY` when you also need aggregates.
* `NULL` values are treated as duplicates — only one `NULL` will appear.
* `DISTINCT` may be costly on large tables because SQL must compare many rows.

---

### 💻 Practice Queries

```sql
-- 1. List all unique services in the patients table.
SELECT DISTINCT service AS unique_services
FROM patients;

-- 2. Find all unique staff roles in the hospital.
SELECT DISTINCT role
FROM staff;

-- 3. Get distinct months from the services_weekly table.
SELECT DISTINCT month
FROM services_weekly
ORDER BY month;
```

---

### 🎯 Challenge

#### Question:
Find all **unique combinations** of service and event type from the services_weekly table where events are **not NULL** and **not 'none'**, along with the **count of occurrences** for each combination. Order by **count descending**.

---

### 💡 Thought Process

* We are working with combinations, so we need **DISTINCT-like grouping**.
* Since counts are required, `GROUP BY` is the correct choice.
* First filter out event types that are `NULL` or `'none'`.
* Group by both service and event_type.
* Count how many times each combination occurs.
* Finally, sort by occurrence count in descending order for insight.

---

### 🧠 Query

```sql
-- Unique service + event combinations with counts
SELECT
    service,
    event_type,
    COUNT(*) AS occurrence_count
FROM services_weekly
WHERE event_type IS NOT NULL
  AND event_type <> 'none'
GROUP BY service, event_type
ORDER BY occurrence_count DESC;
```
