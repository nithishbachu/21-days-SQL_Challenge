-- Check Evidence (Where & When the Crime Happened)
SELECT * FROM evidence;
-- This confirms that the murder happened in the CEO office around 21:00

-- Analyze who accessed critical areas at the time
SELECT kl.employee_id, e.name, kl.entry_time, kl.exit_time
FROM keycard_logs kl
JOIN employees e ON kl.employee_id = e.employee_id
WHERE kl.room = 'CEO Office' 
AND entry_time BETWEEN '2025-10-15 20:30:00' and '2025-10-15 21:30:00';
-- David Kumar is the ONLY person in the CEO Office during the murder.
-- This makes him Suspect A1.

-- Cross-check alibis with actual logs
With 
claimed AS(
SELECT * FROM alibis WHERE claim_time BETWEEN '2025-10-15 20:30:00' and '2025-10-15 21:30:00'
),

actual AS(
SELECT * FROM keycard_logs WHERE room = 'CEO Office' 
AND entry_time BETWEEN '2025-10-15 20:30:00' and '2025-10-15 21:30:00'
)

SELECT c.employee_id, e.name, c.claimed_location, c.claim_time, a.room AS actual_location, 
a.entry_time AS actual_entry_time, a.exit_time AS actual_exit_time
FROM claimed c
Join actual a ON c.employee_id = a.employee_id
JOIN employees e ON a.employee_id = e.employee_id;
-- David Kumar gave false alibi which makes him even more suspicious

-- Investigate suspicious calls made around the time
SELECT caller_id, receiver_id, e.name, call_time, duration_sec AS call_duration 
FROM (SELECT * FROM calls WHERE call_time BETWEEN '2025-10-15 20:30:00' and '2025-10-15 21:30:00') c
JOIN employees e ON c.caller_id = e.employee_id;
-- David Kumar was active and communicating minutes before the murder.
-- This matches the pattern of a person trying to mislead / coordinate / cover up.

-- Match evidence with movements and claims
SELECT ev.room, ev.description, ev.found_time, e.name AS suspect_nmae, 
a.claimed_location, kl.room AS actual_location,
a.claim_time, kl.entry_time AS actual_entry_time, kl.exit_time AS actual_exit_time,
ca.call_time
FROM evidence ev
JOIN keycard_logs kl ON ev.room = kl.room
JOIN alibis a ON kl.employee_id = a.employee_id
JOIN employees e ON a.employee_id = e.employee_id
JOIN calls ca ON e.employee_id = ca.caller_id
WHERE ev.room = 'CEO Office'
AND kl.entry_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:15';
-- David Kumar matches EVERYTHING
-- All evidence, logs, and claims point directly to him.

-- CASE SOLVED (CombinING all findings to identify the killer)
WITH
present AS (
SELECT employee_id FROM keycard_logs
WHERE room = 'CEO Office'
AND ((entry_time BETWEEN '2025-10-15 20:30' AND '2025-10-15 21:30')
OR (exit_time  BETWEEN '2025-10-15 20:30' AND '2025-10-15 21:30'))
),
lied AS (
SELECT employee_id FROM alibis
WHERE claim_time BETWEEN '2025-10-15 20:45' AND '2025-10-15 21:15'
AND claimed_location != 'CEO Office'
),
calls_nearby AS (
SELECT caller_id  AS employee_id FROM calls
WHERE call_time BETWEEN '2025-10-15 20:50' AND '2025-10-15 21:05'
),
suspects AS (
SELECT employee_id FROM present INTERSECT
SELECT employee_id FROM lied INTERSECT
SELECT employee_id FROM calls_nearby
)
SELECT emp.name AS killer
FROM suspects s
JOIN employees emp ON emp.employee_id = s.employee_id;
