# 🗓️ Day 9 – Mastering Date Functions in SQL

### 📘 Topics Covered
- Working with date and time values  
- Performing date arithmetic (add, subtract, difference)  
- Extracting date parts (year, month, day)  
- Filtering data using date ranges  
- Calculating duration between dates  

---

### 💡 Key Points

- Dates are stored in SQL as `YYYY-MM-DD` (ISO standard).  
- You can **add, subtract, and compare** dates easily using built-in date functions.  
- Date arithmetic helps analyze trends like patient stay duration, weekly admissions, and monthly performance.  
- Use **EXTRACT** or **strftime()** (depending on your SQL dialect) to get parts of a date.

---

### 🧮 Built-in Date Functions

* `CURRENT_DATE` – Returns today’s date
* `CURRENT_TIME` – Returns current time
* `CURRENT_TIMESTAMP` – Returns current date and time
* `EXTRACT(YEAR FROM date)` – Extracts year part
* `AGE(date1, date2)` – Returns time difference
* `NOW()` – Returns the current date and time
* `DATE_PART('month', date)` – Extracts month part
* `DATE_TRUNC('month', date)` – Rounds date to the start of the month
* `TO_CHAR(date, 'DD-Mon-YYYY')` – Formats date in readable form
* `MAKE_DATE(year, month, day)` – Creates a date from given values

---

### 💻 Practice Queries

```sql
-- 1. Extract the year from all patient arrival dates.
SELECT patient_id, name, EXTRACT(YEAR FROM arrival_date) AS year
FROM patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
SELECT patient_id, name, departure_date - arrival_date AS stay_days
FROM patients;

-- 3. Find all patients who arrived in a specific month.
SELECT *
FROM patients
WHERE EXTRACT(MONTH FROM arrival_date) = 06;
````

---

### 💡 Tips & Tricks

✅ **Always use ISO format** (`YYYY-MM-DD`) for compatibility across databases.

✅ **Date difference functions vary** by database:

* SQLite → `JULIANDAY(date2) - JULIANDAY(date1)`
* MySQL → `DATEDIFF(date2, date1)`
* PostgreSQL → `date2 - date1`

✅ **Extract date parts**:

```sql
strftime('%Y', date)  -- Year
strftime('%m', date)  -- Month
strftime('%d', date)  -- Day
strftime('%W', date)  -- Week number
```

✅ Use **WHERE** for filtering by specific periods, like month or year.

✅ **Cast results** to integers when calculating differences for clean output.

✅ Avoid wrapping date columns in functions inside WHERE clauses for performance — filter raw dates when possible.

---

📚 **Resources:**

* [SQL Date and Time Functions Explained](https://youtu.be/RyvksI0iezo?si=bdkEcPcq-LvUNd8R)
* [SQL Date Functions Tutorial](https://www.youtube.com/watch?v=V4STN2DPVc8)

---

### 🎯 Challenge

#### Question:

Calculate the **average length of stay (in days)** for each hospital service.
Show only services where the **average stay exceeds 7 days**.
Also display the **number of patients** per service, ordered by average stay in descending order.

---

### 💡 Thought Process

* To find the average stay, calculate the difference between `departure_date` and `arrival_date`.
* Group data by `service` to get average and total patient counts per service.
* Use `HAVING` to filter groups with an average stay greater than 7 days.
* Sort by the longest average stay first for insight.

---

### 🧠 Challenge Query

```sql
SELECT service, ROUND(AVG(departure_date - arrival_date), 0) AS avg_stay_days, COUNT(*) AS total_patients
FROM patients
GROUP BY service
HAVING AVG(departure_date - arrival_date) > 7
ORDER BY avg_stay_days DESC;
```

---

### ✨ Takeaway

Mastering date functions transforms your SQL from static reports to **time-based insights** — helping you uncover trends, durations, and performance patterns hidden in your data.

