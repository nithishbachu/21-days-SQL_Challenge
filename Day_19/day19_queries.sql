-- Day 19: Window Functions - ROW_NUMBER, RANK, DENSE_RANK

-- 1. Rank patients by satisfaction score within each service.
SELECT *, RANK() OVER(PARTITION BY service ORDER BY  satisfaction DESC) AS rank
FROM patients;

-- 2. Assign row numbers to staff ordered by their name.
SELECT ROW_NUMBER() OVER(ORDER BY staff_name DESC) AS row_num, *
FROM staff;

-- 3. Rank services by total patients admitted.
SELECT RANK() OVER(ORDER BY SUM(patients_admitted)) AS rank, service, SUM(patients_admitted) AS total_patients_admitted
FROM services_weekly
GROUP BY service;

-- 4. Daily Challenge: For each service, rank the weeks by patient satisfaction score (highest first). Show service, 
-- week, patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
SELECT * FROM(
	SELECT 
		service, 
		week, 
		patient_satisfaction, 
		patients_admitted, 
		RANK() OVER(PARTITION BY service ORDER BY patient_satisfaction) as rank 
	FROM services_weekly)
WHERE rank <= 3;
