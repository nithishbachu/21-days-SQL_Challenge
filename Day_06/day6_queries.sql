-- Day 6: GROUP BY Clause

-- 1. Count the number of patients by each service.
SELECT service, COUNT(*) AS count
FROM patients
GROUP BY service;

-- 2. Calculate the average age of patients grouped by service.
SELECT service, ROUND(AVG(age), 2) AS age
FROM patients
GROUP BY service;

-- 3. Find the total number of staff members per role.
SELECT role AS staff_role, COUNT(*)
FROM staff
GROUP BY role;

-- 4. Daily Challenge: For each hospital service, calculate the total number of patients admitted, total patients refused, and the 
-- admission rate(percentage of requests that were admitted). Order by admission rate descending.
SELECT service,
COUNT(patients_admitted) AS total_patients_admitted,
COUNT(patients_refused) AS total_patients_refused,
ROUND((SUM(patients_admitted) * 100/SUM(patients_request)), 2) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;
