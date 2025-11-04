# 🗓️ Day 2 – Filtering Data with WHERE Clause

### 📘 Topics Covered
- Filtering data using `WHERE`
- Applying comparison operators
- Using logical operators (`AND`, `OR`, `NOT`)
- Matching patterns with `LIKE`
- Using `IN` and `BETWEEN`
- Handling `NULL` values with `IS NULL` / `IS NOT NULL`

### 💻 Practice Queries
```sql
-- Find all patients who are older than 60 years.
SELECT name AS Patient_Name, age AS Patient_Age
FROM patients
WHERE age > 60;

-- Retrieve all staff members who work in the 'Emergency' service.
SELECT *
FROM staff
WHERE service = 'Emergency';

-- List all weeks where more than 100 patients requested admission in any service.
SELECT DISTINCT week
FROM services_weekly
WHERE patients_request > 100;
```

### 🎯 Challenge

#### Question:
Find all patients admitted to the ‘Surgery’ service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction_score.

### 💡 Thought Process

- We need to filter records where service = 'Surgery'.

- Among those, only patients with satisfaction_score < 70 should appear.

- Finally, select only the required columns to display relevant information.

### 🧠 Challenge Query
```sql
SELECT patient_id, name AS patient_name, age AS patient_age, satisfaction  AS satisfaction_score
FROM patients
WHERE service = 'surgery'
  AND satisfaction < 70;
