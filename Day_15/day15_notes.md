# 🗓️ Day 15 – Multiple Joins

### 📘 Topics Covered

* Joining 3 or more tables in one query
* Understanding join order and evaluation
* Combining INNER and LEFT JOINs
* Handling complex relational structures
* Avoiding duplicate rows in multi-table joins

---

### 💡 Key Points

* SQL evaluates joins **left to right**.
* Each join builds on the previous result set (cumulative).
* Use **INNER JOIN** to keep only matching rows.
* Use **LEFT JOIN** when you need *all rows* from the left table plus matches from the right.
* Join conditions can reference **any previous table** in the query.
* Multi-table joins may introduce duplicates — use `DISTINCT` or `GROUP BY` if needed.
* Debug by **adding one join at a time** to verify correctness.

---

### 💻 Practice Queries

```sql
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT p.patient_id, p.name AS patient_name, p.service, p.arrival_date,
COUNT(DISTINCT s.staff_id) AS assigned_staff,
ROUND(AVG(ss.present), 4) AS avg_staff_presence
FROM patients p
JOIN staff s ON p.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY p.patient_id, patient_name, p.service, p.arrival_date
ORDER BY assigned_staff;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT sw.week, sw.service, sw.patients_admitted,
COUNT(DISTINCT s.staff_id) AS assigned_staff,
SUM(COALESCE(ss.present, 0)) AS total_staff
FROM services_weekly sw
JOIN staff s ON sw.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY sw.week, sw.service, sw.patients_admitted;

-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT p.*,
s.staff_id, s.staff_name, s.role,
ss.week AS schedule_week, ss.present
FROM patients p
JOIN staff s ON p.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id;
```

---

### 🎯 Challenge

#### Question:

Create a **comprehensive service analysis report for week 20** showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and count of staff present that week. Order by **patients admitted descending**.

---

### 💡 Thought Process

* Start with `services_weekly` since week-level data is grouped by service.
* Filter for week 20 early to reduce unnecessary joins.
* Join `staff` to count staff assigned per service.
* Join `staff_schedule` to track staff presence for week 20.
* Use aggregates to compute totals and averages.
* Group by service to consolidate all metrics in one row.

---

### 🧠 Challenge Query

```sql
-- Week 20 comprehensive service analysis
SELECT
    sw.service,
    SUM(sw.patients_admitted) AS total_admitted,
    SUM(sw.patients_refused) AS total_refused,
    ROUND(AVG(sw.satisfaction), 2) AS avg_satisfaction,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON s.staff_id = ss.staff_id
    AND sw.week = ss.week
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY total_admitted DESC;
```
