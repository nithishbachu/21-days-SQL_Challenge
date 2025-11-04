-- Day 2: Filtering Data with WHERE Clause

-- 1. Find all patients who are older than 60 years
SELECT name AS Patient_Name, age AS Patient_Age
FROM patients
WHERE age > 60;

-- 2. Retrieve all staff members who work in the 'Emergency' service
SELECT *
FROM staff
WHERE service = 'Emergency';

-- 3. List all weeks where more than 100 patients requested admission in any service
SELECT DISTINCT week
FROM services_weekly
WHERE patients_request > 100;

-- 4. Daily Challenge: Find all patients admitted to 'Surgery' service with a satisfaction score below 70
SELECT patient_id, name, age, satisfaction_score
FROM patients
WHERE service = 'Surgery' 
  AND satisfaction_score < 70;
