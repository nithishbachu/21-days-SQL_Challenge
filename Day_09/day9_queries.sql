-- Day 9: Data Manipulation (Date Functions)

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

-- 4. Daily Challenge: Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
-- Also show the count of patients and order by average stay descending.
SELECT service, ROUND(AVG(departure_date - arrival_date), 0) AS avg_stay_days, COUNT(*) AS total_patients
FROM patients
GROUP BY service
HAVING AVG(departure_date - arrival_date) > 7
ORDER BY avg_stay_days DESC;
