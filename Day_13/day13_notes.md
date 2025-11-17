# 🗓️ Day 13 – INNER JOIN

### 📘 Topics Covered

* Understanding `INNER JOIN`
* Combining data from multiple tables
* Matching related rows using keys/columns
* Using aliases and qualified column names
* Joining with multiple conditions

---

### 💡 Key Points

* `INNER JOIN` returns **only the rows that match** in **both tables**.
* Rows without matches are **excluded** from the result.
* Use aliases (`p`, `s`, `sw`, etc.) to keep queries readable.
* Always qualify columns when joining to avoid ambiguity.
* Multiple join conditions can be added using `AND`.
* `JOIN` without specifying type defaults to `INNER JOIN`.

---

### 💻 Practice Queries

```sql
-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT p.patient_id, p.name AS patient_name, p.service,
s.staff_id, s.staff_name, s.role	
FROM patients p
JOIN staff s ON p.service = s.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT sw.*,
s.staff_id, s.staff_name, s.role
FROM services_weekly sw
JOIN staff s ON sw.service = s.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT p.*,
s.staff_id, s.staff_name
FROM patients p
JOIN staff s ON p.service = s.service;
```

---

### 🎯 Challenge

#### Question:

Create a comprehensive report showing:

* `patient_id`
* `patient_name`
* `age`
* `service`
* `total_staff` (number of staff in that service)

Include **only** patients from services that have **more than 5 staff members**.
Order results by **total_staff DESC**, then by **patient_name ASC**.

---

### 💡 Thought Process

* First, we need to join `patients` with `staff` using the `service` column.
* To count staff per service, use `COUNT(staff_id)` with `GROUP BY`.
* But we must apply grouping **after joining**, so staff counts are accurate.
* Use `HAVING` to show only services with **more than 5** staff members.
* Finally, sort by staff count and patient name.

---

### 🧠 Query

```sql
SELECT p.patient_id, p.name AS patient_name, p.age, p.service,
COUNT(s.staff_id) AS staff_count
FROM patients p
JOIN staff s ON p.service = s.service
GROUP BY p.patient_id
HAVING COUNT(s.staff_id) > 5
ORDER BY staff_count DESC, patient_name;
```
