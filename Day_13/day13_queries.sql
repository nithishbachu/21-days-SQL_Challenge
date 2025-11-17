-- Day 13: Combining Tables (INNER JOIN)

-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT p.patient_id, p.name AS patient_name, p.service,
s.staff_id, s.staff_name, s.role	
FROM patients p
JOIN staff s ON p.service = s.service;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT sw.*,
s.staff_id, s.staff_name, s.role
FROM services_weekly sw
JOIN staff s ON sw.service = s.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT p.*,
s.staff_id, s.staff_name
FROM patients p
JOIN staff s ON p.service = s.service;

-- 4. Daily Challenge: Create a comprehensive report showing patient_id, patient name, age, service, and the total number of staff members available in their service. Only include patients from services that have more than 5 staff members. Order by number of staff descending, then by patient name.
SELECT p.patient_id, p.name AS patient_name, p.age, p.service,
COUNT(s.staff_id) AS staff_count
FROM patients p
JOIN staff s ON p.service = s.service
GROUP BY p.patient_id
HAVING COUNT(s.staff_id) > 5
ORDER BY staff_count DESC, patient_name;
