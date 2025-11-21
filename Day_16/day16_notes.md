# Day 16: Subqueries in WHERE Clause

## 📘 Topics Covered

* Subqueries inside the WHERE clause
* Types of subqueries: single-value, multi-value, existence
* Nested queries
* Filtering with subqueries
* Correlated subqueries
* Handling NULLs in subqueries

---

## 🧠 What Are Subqueries?

A **subquery** is a query inside another query. In the WHERE clause, subqueries help filter records based on conditions derived from another dataset.

### ✅ Basic Syntax

```sql
SELECT columns
FROM table1
WHERE column IN (
    SELECT column
    FROM table2
    WHERE condition
);
```

---

## 🔍 Types of Subqueries in WHERE Clause

### 1️⃣ **Single-Value Subqueries**

Returns exactly one value.

```sql
WHERE age > (
    SELECT AVG(age)
    FROM patients
);
```

### 2️⃣ **Multi-Value Subqueries**

Returns multiple values (use IN / NOT IN).

```sql
WHERE service IN (
    SELECT service
    FROM services_weekly
);
```

### 3️⃣ **Existence Check Subqueries**

Use `EXISTS()` or `NOT EXISTS()`.

```sql
WHERE EXISTS (
    SELECT 1
    FROM services_weekly sw
    WHERE sw.service = p.service
);
```

---

## 🧪 Examples

### ⭐ Example 1: Patients in services with high satisfaction

```sql
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING AVG(patient_satisfaction) > 80
);
```

### ⭐ Example 2: Patients older than average age

```sql
SELECT name, age
FROM patients
WHERE age > (
    SELECT AVG(age)
    FROM patients
);
```

### ⭐ Example 3: Services with at least one week of refusals

```sql
SELECT DISTINCT service
FROM services_weekly sw1
WHERE EXISTS (
    SELECT 1
    FROM services_weekly sw2
    WHERE sw2.service = sw1.service
      AND sw2.patients_refused > 0
);
```

### ⭐ Example 4: Patients NOT in services with staff shortage

```sql
SELECT *
FROM patients
WHERE service NOT IN (
    SELECT service
    FROM staff
    GROUP BY service
    HAVING COUNT(*) < 5
);
```

---

## 💡 Tips & Tricks

### ✔ IN vs EXISTS

* `IN` → good for small result sets
* `EXISTS` → better for large datasets

### ✔ Correlated Subqueries

Subqueries that reference the outer query.

```sql
SELECT *
FROM patients p1
WHERE satisfaction > (
    SELECT AVG(satisfaction)
    FROM patients p2
    WHERE p2.service = p1.service
);
```

### ✔ Avoid NULL Issues with NOT IN

```sql
WHERE service NOT IN (
    SELECT service
    FROM table
    WHERE service IS NOT NULL
);
```

### ✔ Single-value subqueries must return exactly 1 row.

```sql
WHERE age > (SELECT AVG(age) FROM patients);
```

---

## 📝 Practice Questions

### 1️⃣ Find patients who are in services with above-average staff count.

```sql
SELECT *
FROM patients p
WHERE service IN (
    SELECT service
    FROM staff
    GROUP BY service
    HAVING COUNT(*) > (
        SELECT AVG(staff_count)
        FROM (
          SELECT service, COUNT(*) AS staff_count
          FROM staff
          GROUP BY service
        )
    )
);
```

### 2️⃣ List staff who work in services that had any week with patient satisfaction below 70.

```sql
SELECT *
FROM staff
WHERE service IN (
    SELECT service
    FROM services_weekly
    WHERE patient_satisfaction < 70
);
```

### 3️⃣ Show patients from services where total admitted patients exceed 1000.

```sql
SELECT *
FROM patients
WHERE service IN (
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING SUM(patients_admitted) > 1000
);
```

---

## 🎯 Daily Challenge

### **Find all patients admitted to services that:**

* Had **at least one week with patients refused** (> 0)
* Have **average patient satisfaction** **below the overall hospital average**
* Show: `patient_id`, `name`, `service`, `satisfaction`

### ✅ Solution

```sql
SELECT
    p.patient_id,
    p.name,
    p.service,
    p.satisfaction
FROM patients p
WHERE p.service IN (
    -- Services with at least one week of refusals
    SELECT service
    FROM services_weekly
    WHERE patients_refused > 0
)
AND p.service IN (
    -- Services with below-average satisfaction
    SELECT service
    FROM services_weekly
    GROUP BY service
    HAVING AVG(patient_satisfaction) < (
        SELECT AVG(patient_satisfaction)
        FROM services_weekly
    )
)
ORDER BY p.satisfaction DESC;
```
