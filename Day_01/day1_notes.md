# 🗓️ Day 1 – Introduction to SQL & SELECT Statement

### 📘 Topics Covered
- Introduction to SQL and relational databases
- SELECT statement basics
- Viewing table data using SELECT *
- Selecting specific columns
- Using AS for column aliases
- Best practices: Avoid SELECT *, use comments, and limit rows

### 💻 Queries
```sql
# Practice Queries
SELECT * FROM patients;
SELECT patient_id, name, age FROM patients;
SELECT * FROM service_weekly LIMIT 10;

# Challenge Query
SELECT DISTINCT service FROM services_weekly;
