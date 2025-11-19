-- Day 15: Combining Tables (MULTIPLE JOINS)

-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT p.patient_id, p.name AS patient_name, p.service, p.arrival_date,
COUNT(DISTINCT s.staff_id) AS assigned_staff,
ROUND(AVG(ss.present), 4) AS avg_staff_presence
FROM patients p
JOIN staff s ON p.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY p.patient_id, patient_name, p.service, p.arrival_date
ORDER BY assigned_staff;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT sw.week, sw.service, sw.patients_admitted,
COUNT(DISTINCT s.staff_id) AS assigned_staff,
SUM(COALESCE(ss.present, 0)) AS total_staff
FROM services_weekly sw
JOIN staff s ON sw.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id
GROUP BY sw.week, sw.service, sw.patients_admitted;

-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT p.*,
s.staff_id, s.staff_name, s.role,
ss.week AS schedule_week, ss.present
FROM patients p
JOIN staff s ON p.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id;

-- 4. Daily Challenge: Create a comprehensive service analysis report for week 20 showing: service name, total patients 
-- admitted that week, total patients refused, average patient satisfaction, count of staff assigned to service, and 
-- count of staff present that week. Order by patients admitted descending.
SELECT sw.week, sw.service, SUM(sw.patients_admitted) AS total_patients, SUM(sw.patients_refused) AS total_patients_refused,
ROUND(AVG(patient_satisfaction)) AS average_patient_satisfaction,
COUNT(DISTINCT s.staff_id) AS staff_assigned,
SUM(COALESCE(ss.present, 0)) AS staff_present
FROM services_weekly sw 
JOIN staff s ON sw.service = s.service
JOIN staff_schedule ss ON s.staff_id = ss.staff_id AND ss.week = sw.week
WHERE sw.week = 20
GROUP BY sw.week, sw.service
ORDER BY total_patients DESC;
