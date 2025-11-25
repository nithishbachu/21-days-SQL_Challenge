# 🗓️ Day 19 – Ranking Data with Window Functions (ROW_NUMBER, RANK, DENSE_RANK)

### 📘 Topics Covered
- Introduction to SQL Window Functions  
- Using the `OVER` clause  
- Ranking functions: `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`  
- Partitioning vs non-partitioning  
- Filtering ranked results  
- Applying window functions in real analytics  

---

### 💡 Key Points

- Window functions **do not reduce rows** — unlike GROUP BY.  
- They allow calculations **across related rows** while keeping each row intact.  
- `PARTITION BY` divides data into groups, similar to GROUP BY but without collapsing.  
- `ORDER BY` inside OVER determines ranking/ordering logic.  
- Choose ranking type based on tie-handling:

| Function | Behavior |
|---------|----------|
| **ROW_NUMBER()** | Always unique (1,2,3,4…) |
| **RANK()** | Ties share a rank, gaps appear (1,2,2,4…) |
| **DENSE_RANK()** | Ties share a rank, no gaps (1,2,2,3…) |

---

### 💻 Practice Queries

```sql
-- 1. Rank patients by satisfaction score within each service.
SELECT *, RANK() OVER(PARTITION BY service ORDER BY  satisfaction DESC) AS rank
FROM patients;

-- 2. Assign row numbers to staff ordered by their name.
SELECT ROW_NUMBER() OVER(ORDER BY staff_name DESC) AS row_num, *
FROM staff;

-- 3. Rank services by total patients admitted.
SELECT RANK() OVER(ORDER BY SUM(patients_admitted)) AS rank, service, SUM(patients_admitted) AS total_patients_admitted
FROM services_weekly
GROUP BY service;
````

---

### 💡 Tips & Tricks

✅ **PARTITION BY is optional**
Without it → ranking happens across entire table.
With it → ranking resets for each group.

```sql
RANK() OVER (ORDER BY satisfaction DESC)                 -- global
RANK() OVER (PARTITION BY service ORDER BY satisfaction DESC)   -- per service
```

✅ **Pick the right ranking function**

* Want unique numbering? → `ROW_NUMBER()`
* Want ties with gaps? → `RANK()`
* Want ties with no gaps? → `DENSE_RANK()`

✅ **Filter window results using subqueries**

```sql
SELECT *
FROM (
    SELECT
        *,
        ROW_NUMBER() OVER (ORDER BY age DESC) AS rn
    FROM patients
)
WHERE rn <= 10;   -- top 10 oldest patients
```

✅ **ORDER BY inside OVER != final ORDER BY**

```sql
ROW_NUMBER() OVER (ORDER BY age DESC)   -- ranking logic
ORDER BY name                            -- final display order
```

---

📚 **Resources**

* [https://www.youtube.com/watch?v=xMWEVFC4FOk](https://www.youtube.com/watch?v=xMWEVFC4FOk)
* [https://youtu.be/nHEEyX_yDvo?si=7Qw_T2mWWkhONUWt](https://youtu.be/nHEEyX_yDvo?si=7Qw_T2mWWkhONUWt)

---

### 🎯 Challenge

#### **Question:**

For each service, rank the weeks by patient satisfaction (highest first).
Show:

* service
* week
* patient_satisfaction
* patients_admitted
* rank

Include **only the top 3 weeks per service**.

---

### 💡 Thought Process

* Use `RANK()` with `PARTITION BY service` to rank weeks individually per service.
* Order by `patient_satisfaction` to define ranking logic.
* Wrap the result in a subquery to filter top 3 (since WHERE cannot directly use window functions).
* Select all required fields and filter using `rank <= 3`.

---

### 🧠 Challenge Query

```sql
SELECT * FROM(
	SELECT 
		service, 
		week, 
		patient_satisfaction, 
		patients_admitted, 
		RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction) as rank 
	FROM services_weekly)
WHERE rank <= 3;
```

---

### ✨ Takeaway

Window functions unlock a new dimension in SQL — one where you can rank, compare, and analyze rows side-by-side *without losing detail*.
This is how real analytics dashboards are built.
