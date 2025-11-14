# 🗓 Day 10 – Mastering CASE Statements

### 📘 Topics Covered

* Adding conditional logic to queries using CASE
* Creating derived columns based on conditions
* Conditional aggregation with SUM/AVG
* Custom sorting using CASE in ORDER BY

---

### 💡 Key Points

* `CASE` allows **if-else style logic** in SQL
* **Always include ELSE** to handle unexpected values; otherwise returns `NULL`
* `CASE` evaluates **top-to-bottom** — first match wins
* Can be **used anywhere** a column is allowed (SELECT, WHERE, ORDER BY, etc.)
* Supports **nesting** for complex logic (readability matters)
* Use CASE with **aggregations** for conditional counts and averages

---

### 💻 Practice Queries

```sql
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT patient_id, name,
CASE WHEN satisfaction >= 80 THEN 'High' 
WHEN satisfaction >= 50 THEN 'Medium' 
Else 'Low' 
END AS satisfaction_score
FROM patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT staff_id, staff_name, service, 
CASE WHEN role='doctor' THEN 'Medical' 
ELSE 'Support' 
END AS staff_roles
FROM staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT patient_id, name, 
CASE WHEN age BETWEEN 0 AND 18 THEN '0-18'
WHEN age BETWEEN 19 AND 40 THEN '19-40' 
WHEN age BETWEEN 41 AND 65 THEN '41-65' 
ELSE '65+'
END AS age_grps
FROM patients;
```

---

### 💡 Tips & Tricks

✅ **CASE is an expression, not a statement** — can be used anywhere a column is allowed
✅ Include **ELSE** for predictable results
✅ Use CASE in **ORDER BY** for custom sorting:

```sql
ORDER BY CASE
    WHEN service = 'Emergency' THEN 1
    WHEN service = 'ICU' THEN 2
    ELSE 3
END;
```

✅ Conditional aggregation:

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)        -- Count matching rows
AVG(CASE WHEN condition THEN value ELSE NULL END) -- Conditional average
```

✅ Nest CASE for complex logic, but keep readability in mind
✅ Order of WHEN clauses matters — **first match wins**

---

📚 *Resources:*

* [CASE Statements Explained - YouTube](https://youtu.be/GHPHZ8XJxeg?si=asEqBjuYzbMjOnDj)
* [SQL CASE Tutorial - YouTube](https://www.youtube.com/watch?v=Twusw__OzA8)

---

### 🎯 Challenge

#### Question:

Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 'Excellent' if avg satisfaction >= 85, 'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.

---

### 💡 Thought Process

* We need to categorize service performance based on **average satisfaction**
* Aggregate patients per service using `COUNT(*)` and `AVG(satisfaction)`
* Use a CASE expression to assign **performance categories**
* ORDER results by **average satisfaction descending** for clarity
* Alias columns clearly for readability

---

### 🧠 Query

```sql
SELECT
    service,
    COUNT(*) AS total_patients,
    AVG(satisfaction) AS avg_satisfaction,
    CASE
        WHEN AVG(satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(satisfaction) >= 75 THEN 'Good'
        WHEN AVG(satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM patients
GROUP BY service
ORDER BY avg_satisfaction DESC;
```

---

### ✨ Takeaway

CASE statements turn SQL queries into **smart, decision-making tools**.
They allow you to categorize, aggregate, and sort data dynamically — transforming raw numbers into meaningful insights.
