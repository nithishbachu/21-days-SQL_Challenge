-- Day 21: Common Table Expressions (CTEs)

-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
SELECT service, COUNT(*) AS total_patients,
AVG(satisfaction) AS avg_satisfaction FROM patients GROUP BY service) 
SELECT * FROM service_stats 
WHERE avg_satisfaction > 75 
ORDER BY total_patients DESC;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH step1 AS (
SELECT service, COUNT(*) AS total_patients FROM patients GROUP BY service), 
step2 AS (SELECT service, SUM(patients_admitted) AS total_admissions FROM services_weekly GROUP BY service), 
step3 AS (SELECT s1.service, s1.total_patients, s2.total_admissions FROM step1 s1 
JOIN step2 s2 ON s1.service = s2.service) 
SELECT * FROM step3 
ORDER BY total_admissions DESC;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_utilization AS (
SELECT ss.service, COUNT(DISTINCT s.staff_id) AS total_staff,
AVG(ss.present) * 100 AS avg_weeks_present 
FROM staff s 
JOIN staff_schedule ss ON s.staff_id = ss.staff_id 
GROUP BY ss.service), 
patient_data AS (
SELECT service, COUNT(*) AS total_patients FROM patients GROUP BY service) 
SELECT su.service, su.total_staff, su.avg_weeks_present, pd.total_patients 
FROM staff_utilization su 
LEFT JOIN patient_data pd ON su.service = pd.service 
ORDER BY total_staff DESC;

-- 4. Daily Challenge: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level 
-- metrics (total admissions,refusals,avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 
-- 3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report showing 
-- service name, all calculated metrics, and an overall performance score (weighted average of admission rate and 
-- satisfaction). Order by performance score descending.
WITH service_metrics AS (
SELECT sw.service, SUM(sw.patients_admitted) AS total_admissions, SUM(sw.patients_refused) AS total_refusals, 
AVG(sw.patient_satisfaction) AS avg_satisfaction FROM services_weekly sw GROUP BY sw.service),
staff_metrics AS (
SELECT ss.service, COUNT(DISTINCT s.staff_id) AS total_staff, 
AVG(ss.present) * 100 AS avg_weeks_present 
FROM staff s 
JOIN staff_schedule ss ON s.staff_id = ss.staff_id 
GROUP BY ss.service), 
patient_metrics AS (
SELECT service, AVG(age) AS avg_age, COUNT(*) AS total_patients 
FROM patients GROUP BY service) 
SELECT sm.service, sm.total_admissions, sm.total_refusals, sm.avg_satisfaction, stm.total_staff, stm.avg_weeks_present, 
pm.avg_age, pm.total_patients, 
ROUND(100.0 * sm.total_admissions / NULLIF(sm.total_admissions + sm.total_refusals,0),2) AS admission_rate, 
ROUND(((0.6 * (100.0 * sm.total_admissions / NULLIF(sm.total_admissions + sm.total_refusals,0))) + (0.4 * sm.avg_satisfaction)),2) AS performance_score 
FROM service_metrics sm 
LEFT JOIN staff_metrics stm ON sm.service = stm.service 
LEFT JOIN patient_metrics pm ON sm.service = pm.service 
ORDER BY performance_score DESC;
