# 🗓️ Day 20 – Window Functions: Aggregate Window Functions

### 📘 Topics Covered

* `SUM() OVER`, `AVG() OVER`, `COUNT() OVER`
* Running totals
* Moving averages
* Window frames (`ROWS BETWEEN …`)
* Comparing values against group-level aggregates

---

### 💡 Key Points

* Aggregate window functions allow calculations **without collapsing rows**, unlike GROUP BY.
* They operate across a logical "window" of rows defined by:

  * `PARTITION BY`: resets window per group
  * `ORDER BY`: defines sequence
  * `ROWS BETWEEN`: defines frame (sliding, cumulative, centered, etc.)
* Window frames define *how much* of the partition the function sees.
* Default frame (when ORDER BY exists):
  `UNBOUNDED PRECEDING TO CURRENT ROW`
* Without ORDER BY → function sees **entire partition**.
* Perfect for trends, moving averages, running totals, and deviation analysis.

---

### 💻 Practice Queries

```sql
-- 1. Calculate running total of patients admitted by week for each service.
SELECT week, service, patients_admitted, SUM(patients_admitted) OVER(PARTITION BY service ORDER BY WEEK)
FROM services_weekly;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT week, service, patient_satisfaction, 
ROUND(AVG(patient_satisfaction) OVER(ORDER BY week ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2) AS moving_avg
FROM services_weekly;

-- 3. Show cumulative patient refusals by week across all services.
SELECT week, service, patients_refused, SUM(patients_refused) OVER(ORDER BY week) AS cumulative_sum
FROM services_weekly
ORDER BY week, service, patients_refused;
```

---

### 🎯 Challenge

#### Question:

Create a **trend analysis** for each service and week showing:

* week
* patients admitted
* running total (cumulative admissions)
* 3-week moving average of satisfaction (current + 2 previous weeks)
* difference between current admissions and service average

Filter for **weeks 10–20 only**.

---

### 💡 Thought Process

* Use `SUM() OVER (PARTITION BY service ORDER BY week)` for cumulative totals.
* Use `AVG() OVER (… ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)` for the 3-week moving average.
* Compute service-level averages with an unframed window:
  `AVG(patients_admitted) OVER (PARTITION BY service)`
* Subtract average from current week's admissions for deviation.
* Apply a simple `WHERE week BETWEEN 10 AND 20` filter.

---

### 🧠 Challenge Query

```sql
-- Trend analysis for weeks 10–20
SELECT
    service,
    week,
    patients_admitted,
    -- Running total
    SUM(patients_admitted) OVER (
        PARTITION BY service
        ORDER BY week
    ) AS cumulative_admissions,
    -- 3-week moving average
    ROUND(
        AVG(patient_satisfaction) OVER (
            PARTITION BY service
            ORDER BY week
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3week,
    -- Difference from service average
    patients_admitted -
    AVG(patients_admitted) OVER (PARTITION BY service) AS diff_from_avg
FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;
```
