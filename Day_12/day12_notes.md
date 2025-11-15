# 🗓️ Day 12 – Handling NULL Values in SQL

### 📘 Topics Covered
- Understanding `NULL` in SQL  
- Checking for missing values using `IS NULL` and `IS NOT NULL`  
- Replacing NULL values using `COALESCE`  
- Counting NULL vs non-NULL values  
- NULL-safe comparisons  

---

### 💡 Key Points

- `NULL` means **missing / unknown data**, not zero or empty string.  
- `=` and `!=` **do NOT work** with NULL — always use `IS NULL` / `IS NOT NULL`.  
- `COALESCE()` helps replace NULLs with meaningful default values.  
- `COUNT(column)` ignores NULLs, while `COUNT(*)` counts everything.  
- Operations involving NULL (addition, multiplication, concatenation) result in NULL.  

---

### 💻 Practice Queries

```sql
-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT DISTINCT week, event
FROM services_weekly
WHERE event IS NULL OR event = 'none'
ORDER BY week;

-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) AS null_empty_events
FROM services_weekly
WHERE event IS NULL OR event = '';

-- 3. List all services that had at least one week with a special event.
SELECT service,
COUNT(*) AS no_of_weeks
FROM services_weekly
WHERE event IS NOT NULL AND event != '' AND event != 'none'
GROUP BY service;
````

---

### 💡 Tips & Tricks

✅ **Correct way to check for NULL:**

```sql
event IS NULL
event IS NOT NULL
```

❌ Incorrect (will always return false):

```sql
event = NULL
event != NULL
```

---

✅ **NULL in calculations results in NULL**

```sql
SELECT 5 + NULL;   -- NULL
SELECT NULL * 10;  -- NULL
```

---

✅ **COALESCE returns the first non-NULL value**

```sql
COALESCE(column1, column2, 'default')
```

---

✅ **Sorting NULLs last using COALESCE**

```sql
ORDER BY COALESCE(event, 'ZZZZ')
```

---

📚 **Resources**

* [https://youtu.be/6Twnw3sQChk?si=CNxkKq3stG_qvSz2](https://youtu.be/6Twnw3sQChk?si=CNxkKq3stG_qvSz2)
* [https://youtu.be/X_cPXHV2NQ4?si=QWl5kOkmvKISZ7wA](https://youtu.be/X_cPXHV2NQ4?si=QWl5kOkmvKISZ7wA)

---

### 🎯 Challenge

#### Question:

Analyze the event impact by comparing weeks **weeks with events** vs **weeks without events**. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by **average patient satisfaction (DESC)**.

---

### 💡 Thought Process

* Use `COALESCE(event, ...)` to identify whether an event exists.
* Group results based on event presence.
* Use aggregated values to compute averages and counts.
* Sort final results based on highest patient satisfaction.

---

### 🧠 Challenge Query

```sql
SELECT
    CASE
        WHEN event IS NULL OR event = '' THEN 'No Event'
        ELSE 'With Event'
    END AS event_status,
    COUNT(*) AS week_count,
    AVG(patient_satisfaction) AS avg_satisfaction,
    AVG(staff_morale) AS avg_staff_morale
FROM services_weekly
GROUP BY event_status
ORDER BY avg_satisfaction DESC;
```

---

### ✨ Takeaway

Handling NULLs correctly is a **must-have skill** in SQL — it ensures clean analysis, accurate aggregates, and reliable dashboards. Mastering this makes you far more effective at interpreting real-world, imperfect data.
