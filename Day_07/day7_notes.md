# 🗓️ Day 7 – Filtering Aggregated Data with HAVING Clause

### 📘 Topics Covered
- Filtering aggregated results using `HAVING`
- Difference between `WHERE` and `HAVING`
- Combining both for efficient queries
- Using multiple conditions in `HAVING`

---

### 💡 Key Points

- `WHERE` filters **rows before grouping**  
- `HAVING` filters **groups after aggregation**  
- You **can’t use aggregate functions** in `WHERE`, but you **can** in `HAVING`  
- `HAVING` always works **after** `GROUP BY`  
- Both `WHERE` and `HAVING` can be used together for complex conditions  

---

### 💻 Practice Queries

```sql
-- 1️⃣ Services with more than 100 patients
SELECT service, COUNT(*) AS patient_count
FROM patients
GROUP BY service
HAVING COUNT(*) > 100;

-- 2️⃣ Count elderly patients (age ≥ 65) per service, show only if count > 20
SELECT service, COUNT(*) AS elderly_count
FROM patients
WHERE age >= 65
GROUP BY service
HAVING COUNT(*) > 20;

-- 3️⃣ Services with high satisfaction and sufficient volume
SELECT service,
       AVG(satisfaction) AS avg_satisfaction,
       COUNT(*) AS total_patients
FROM patients
GROUP BY service
HAVING AVG(satisfaction) > 80 AND COUNT(*) > 50;
````

---

### 🎯 Challenge

#### Question:

Identify services that refused more than **100 patients in total** and had an **average satisfaction below 80**.
Display the `service name`, `total_refused`, and `average_satisfaction`.

---

### 💡 Thought Process

* We’re analyzing service-level performance, so we’ll use the `services_weekly` dataset.
* We need **aggregated values**, so we’ll use `SUM()` for refused patients and `AVG()` for satisfaction.
* To apply conditions on these aggregated results, we’ll use the **HAVING** clause instead of WHERE.
* Finally, we’ll select only those services where the refusal count is high and satisfaction is low.

---

### 🧠 Challenge Query

```sql
-- Identify services that refused >100 patients and had average satisfaction <80
SELECT 
    service AS service_name,
    SUM(patients_refused) AS total_refused,
    AVG(satisfaction) AS average_satisfaction
FROM services_weekly
GROUP BY service
HAVING SUM(patients_refused) > 100
   AND AVG(satisfaction) < 80;
```

---

### 📚 Resources

🎥 Video Tutorials:

* [SQL HAVING Clause Explained](https://youtu.be/O9hORRFxV-A?si=DAfmPZyjSQQcLgNb)
* [MySQL GROUP BY & HAVING](https://www.youtube.com/watch?v=VQf0V6Wwbf4)
* [HAVING vs WHERE in SQL](https://youtu.be/AvT4aVNIZrU?si=l-I64G22cCC5t_zw)
* [SQL Tutorial For Beginners | Watch from 46:24](https://www.youtube.com/watch?v=Rm0xH2Vpfi0&t=2784s)

---

✅ **Execution Order Reminder:**
`FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT`
