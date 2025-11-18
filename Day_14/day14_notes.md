# Day 14 – LEFT JOIN and RIGHT JOIN

## 📘 Topics Covered
- Using LEFT JOIN to include unmatched rows  
- Understanding RIGHT JOIN (rarely used)  
- Identifying non-matching records  
- Handling NULLs after joins  
- Practical JOIN logic for real data  

---

## 💡 Key Points
- `LEFT JOIN` returns all rows from the left table, plus matching rows from the right table.  
- If no match is found, the right table values appear as `NULL`.  
- `RIGHT JOIN` is the opposite — all rows from the right table are kept.  
- Most SQL developers prefer `LEFT JOIN`, because `RIGHT JOIN` can always be rewritten by swapping table order.  
- Use `COALESCE()` to replace `NULL` values when using outer joins.  
- Use `WHERE table2.column IS NULL` to find unmatched rows.  
- **Order matters** — `LEFT JOIN` preserves the left table’s row count.  

---

## 💻 Practice Queries

```sql
-- 1. Show all staff members and their schedule information (including those with no schedule entries).
SELECT s.*, ss.week, ss.present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
SELECT sw.week, sw.month, sw.service, s.staff_id, s.staff_name
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service;

-- 3. Display all patients and their service's weekly statistics (if available).
SELECT p.*, sw.*
FROM patients p
LEFT JOIN services_weekly sw ON p.service = sw.service;
```

---

## 🎯 Daily Challenge

**Create a staff utilisation report showing:**

* staff_id
* staff_name
* role
* service
* weeks_present (how many weeks they were marked present)

✔ Include **all staff — even those with no schedule entries**
✔ Order results by `weeks_present DESC`

---

## 💡 Thought Process

* Since every staff member must be included, use `LEFT JOIN` from `staff` to `staff_schedule`.
* Use `COALESCE()` to convert `NULLs` to `0` when staff have no schedule records.
* Group by staff to summarize their weekly presence.
* Sort by presence count to highlight the most consistent staff.

---

## 🧠 Query

```sql
-- Staff utilisation report (including staff with no schedule)
SELECT
    s.staff_id,
    s.staff_name,
    s.role,
    s.service,
    COALESCE(SUM(ss.present), 0) AS weeks_present
FROM staff s
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC;
```
