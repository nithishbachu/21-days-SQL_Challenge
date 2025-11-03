-- Day 1: Introduction to SQL & SELECT Statement

-- 1. Retrieve all columns from patients table
SELECT * FROM patients;

-- 2. Select only patient_id, name, and age
SELECT patient_id, name, age FROM patients;

-- 3. Display the first 10 records from services_weekly table
SELECT * FROM service_weekly LIMIT 10;

-- 4. Daily Challenge: List all unique hospital services available
SELECT DISTINCT service FROM patients;
