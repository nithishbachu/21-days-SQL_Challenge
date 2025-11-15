-- Day 12: NULL Values and IS NULL/IS NOT NULL

-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT DISTINCT week, event
FROM services_weekly
WHERE event IS NULL OR event = 'none'
ORDER BY week;

-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) AS null_empty_events
FROM services_weekly
WHERE event IS NULL OR event = '';

-- 3. List all services that had at least one week with a special event.
SELECT service,
COUNT(*) AS no_of_weeks
FROM services_weekly
WHERE event IS NOT NULL AND event != '' AND event != 'none'
GROUP BY service;

-- 4. Daily Challenge: Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status 
-- ('With Event' or 'No Event'), count of weeks, average patient satisfaction, and average staff morale. Order by average patient 
-- satisfaction descending.
SELECT CASE WHEN (event IS NOT NULL AND event != '' AND event != 'none') THEN 'With Event'
ELSE 'No Event'
END AS event_status,
COUNT(*) AS no_of_weeks,
ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction,
Round(AVG(staff_morale), 2) AS avg_staff_morale
FROM services_weekly
GROUP BY event_status
ORDER BY AVG(patient_satisfaction) DESC;
