# 🗓️ Day 3 – Sorting Data with ORDER BY

### 📘 Topics Covered
- Sorting data using `ORDER BY`
- Sorting in ascending (`ASC`) and descending (`DESC`) order
- Sorting by multiple columns
- Understanding NULL value sorting
- Using `ORDER BY` with `LIMIT`

### 💡 Key Points

- `ASC` = Ascending (default: A–Z, 0–9, oldest → newest)  
- `DESC` = Descending (Z–A, 9–0, newest → oldest)  
- You can sort by **multiple columns**  
- NULL values typically appear **first (ASC)** or **last (DESC)**  
- Sorting is usually the **last clause** in a query (except `LIMIT`)  

### 💻 Practice Queries

```sql
-- List all patients sorted by age in descending order.
SELECT *
FROM patients
ORDER BY age DESC;

-- Show all services_weekly data sorted by week number ascending and patients_request descending.
SELECT *
FROM services_weekly
ORDER BY week, patients_request DESC;

-- Display staff members sorted alphabetically by their names.
SELECT staff_name
FROM staff
ORDER BY staff_name;
```

### 🎯 Challenge
#### Question:
Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused, and patients_request. Sort by patients_refused in descending order.

### 💡 Thought process
- We need to analyze weekly service data, focusing on patient refusals — so we’ll use the services_weekly table.

- To display meaningful information, we select the key columns: week, service, patients_refused, and patients_request.

- Since we want the weeks with the highest refusals, we sort the data by patients_refused in descending order (DESC).

- Finally, we use LIMIT 5 to show only the top 5 weeks with the maximum number of patient refusals.

### 🧠 Challenge Query
```sql
-- Retrieve the top 5 weeks with the highest patient refusals across all services, showing week, service, patients_refused and patients_request.
-- Sort by patients_refused in descending order.
SELECT week, service AS service_name, patients_refused, patients_request
FROM services_weekly
ORDER BY patients_refused DESC LIMIT 5;

