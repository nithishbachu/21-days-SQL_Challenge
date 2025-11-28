# 🕵️‍♂️ **SQL Murder Mystery – Who Killed the CEO?**

*A Data Investigation Project using Pure SQL*

## 📌 **Project Overview**

This project is a fun yet analytical SQL investigation where the CEO of **TechNova Inc.** is found dead on **October 15, 2025, at 9 PM**.
As a data analyst, your mission is to **identify the killer** using nothing but SQL queries.

All clues are hidden across five tables:

* `employees`
* `keycard_logs`
* `alibis`
* `calls`
* `evidence`

You solve the case by combining **data filtering, joins, subqueries, aggregations, and logical intersections**.

---

# 👤 **My Role in the Project**

As the sole investigator (developer + analyst):

* I **understood and explored** the dataset.
* I designed a **step-by-step investigation process** using SQL.
* I wrote **modular queries** that mimic real detective work.
* I combined findings into a **final logic-based query** that identifies the killer.
* I ensured the approach was **clear, reproducible, and easy to understand**.

This project demonstrates my skills in:

✔ SQL joins

✔ Logical reasoning

✔ Filtering & time-based analysis

✔ Subqueries & CTEs

✔ Data interpretation

✔ Building analytical workflows

---

# 🗂️ **Dataset Description**

### The database contains five core tables:

#### **1. employees**

Basic employee details (ID, name, department, role)

#### **2. keycard_logs**

Tracks room access:

* room entered
* entry_time, exit_time
* used to track movements around the crime scene

#### **3. calls**

Call records:

* caller_id
* receiver_id
* call_time & duration
* used to identify suspicious communication

#### **4. alibis**

Where employees **claimed** to be during the crime time

#### **5. evidence**

Physical evidence found:

* fingerprints
* mismatched keycard logs
* unusual access patterns

---

# 🔍 **Approach & Investigation Steps**

### **🔹 Step 1 — Identify Crime Scene (WHERE)**

Queried the `evidence` table to confirm:

* Crime location → **CEO Office**
* Evidence time → shortly after **9 PM**

### **🔹 Step 2 — Analyze Room Access (JOIN + BETWEEN)**

Joined `keycard_logs` with `employees` to find:

* Who entered the CEO Office during the critical window (20:30–21:30)

### **🔹 Step 3 — Cross-Check Alibis (JOIN + subqueries)**

Compared employee alibis with their actual locations using:

* JOIN between `alibis` and `keycard_logs`, Identified employees with **false alibis**.

### **🔹 Step 4 — Investigate Suspicious Calls (JOIN + filtering)**

Checked for:

* Calls between **20:50–21:05**
* Joined callers + receivers with employees
  This helped identify unusual communication near the crime.

### **🔹 Step 5 — Match Evidence with Movements (JOIN, WHERE)**

Connected:

* Evidence found in CEO Office
* Employees present during the window
* Their claimed vs actual locations

This step tied suspects directly to physical clues.

### **🔹 Step 6 — Final Killer Identification (INTERSECT + multiple JOINs)**

Used a final CTE + INTERSECT approach to ensure the killer satisfies **all 3 conditions**:

1. Present in CEO Office
2. Lied about location (false alibi)
3. Made a call during crime window

This logic produced **one final killer**.

---

# 🔪 **Final Finding**

| killer          |
| --------------- |
| **David Kumar** |

David Kumar’s:

* **presence** in the CEO Office,
* **false alibi**,
* **suspicious calls**, and
* **matching evidence**

all pointed conclusively to him.
