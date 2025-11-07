-- Day 5: Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)

-- 1. Count the total number of patients in the hospital.
SELECT COUNT(*)
FROM patients;

-- 2. Calculate the average satisfaction score of all patients.
SELECT AVG(satisfaction)
FROM patients;

-- 3. Find the minimum and maximum age of patients.
SELECT MIN(age) AS younger,
MAX(age) AS older
FROM patients;

-- 4. Daily Challenge: Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction
-- across all services and weeks. Round the average satisfaction to 2 decimal places.
SELECT COUNT(patients_admitted) AS total_patients_admitted,
COUNT(patients_refused) AS total_patients_refused,
ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction
FROM services_weekly;
