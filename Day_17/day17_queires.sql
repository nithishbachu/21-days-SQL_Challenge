-- Day 17: Subqueries (SELECT and FROM clause)

-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id, p.name, p.service, p.satisfaction,(
SELECT AVG(satisfaction) FROM patients p2
WHERE p2.service = p.service) AS service_avg_satisfaction
FROM patients p
ORDER BY p.service, p.patient_id;

-- 2. Create a derived table of service statistics and query from it.
SELECT stats.service, stats.total_patients, stats.avg_satisfaction  
FROM(SELECT service, COUNT(*) AS total_patients, AVG(patient_satisfaction) AS avg_satisfaction
FROM services_weekly
GROUP BY service) AS stats
ORDER BY stats.total_patients DESC;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT s.staff_id, s.staff_name, s.service,(SELECT COUNT(*) FROM patients p 
WHERE p.service = s.service) AS service_patient_count
FROM staff s
ORDER BY s.service, s.staff_id;

-- 4. Daily Challenge: Create a report showing each service with: service name, total patients admitted, the difference 
-- between their total admissions and the average admissions across all services, and a rank indicator ('Above Average',
-- 'Average', 'Below Average'). Order by total patients admitted descending.
SELECT service, total_admissions, total_admissions - avg_total AS diff_from_avg,
CASE WHEN total_admissions > avg_total THEN 'Above Average'
WHEN total_admissions = avg_total THEN 'Average'
ELSE 'Below Average' END AS rank_status
FROM(SELECT service, COUNT(*) AS total_admissions,
ROUND(AVG(COUNT(*)) OVER (), 2) AS avg_total
FROM patients
GROUP BY service) AS sub
ORDER BY total_admissions DESC;
