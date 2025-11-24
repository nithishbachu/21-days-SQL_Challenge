-- Day 18: UNION and UNION ALL

-- 1. Combine patient names and staff names into a single list.
SELECT patient_id AS Id, name AS Name, 'Patient' AS source FROM patients
UNION ALL
SELECT staff_id, staff_name, 'Staff' AS source FROM staff
ORDER BY source, name;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT patient_id AS Id, name AS Name, 'High_satisfaction' as Category, satisfaction 
FROM patients WHERE satisfaction > 90
UNION ALL
SELECT patient_id AS Id, name AS Name, 'low_satisfaction' as Category, satisfaction 
FROM patients WHERE satisfaction < 50
ORDER BY satisfaction DESC;

-- 3. List all unique names from both patients and staff tables.
SELECT DISTINCT name, 'Patient' AS source FROM patients 
UNION
SELECT DISTINCT staff_name, 'Staff' AS source FROM staff 
ORDER BY source, name;

-- 4. Daily Challenge: Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), 
-- full name, type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' 
-- services. Order by type, then service, then name.
SELECT patient_id AS identifier, name AS full_name, 'Patient' AS type, service 
FROM patients WHERE service IN ('surgery', 'emergency')
UNION ALL
SELECT staff_id AS identifier, staff_name AS full_name, 'Staff' AS type, service
FROM staff WHERE service IN ('surgery', 'emergency')
ORDER BY type, service, full_name;
