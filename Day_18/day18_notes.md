# 🗓️ Day 18 – Combining Results with UNION & UNION ALL

### 📘 Topics Covered
- Merging result sets with `UNION`
- Keeping duplicates using `UNION ALL`
- Rules & restrictions for combining queries
- Using UNION with literals, labels, and mixed datasets
- Real-world scenarios for UNION operations

---

### 💡 Key Points

- **UNION** → Combines results & removes duplicates  
- **UNION ALL** → Combines results without removing duplicates (faster)  
- Both queries must have:  
  - Same number of columns  
  - Compatible data types  
  - Columns in the same order  
- Final column names come from the **first SELECT**  
- `ORDER BY` must be applied **after** all UNION blocks

---

### 💻 Practice Queries

```sql
-- 1. Combine patient names and staff names into a single list.
SELECT patient_id AS Id, name AS Name, 'Patient' AS source
FROM patients
UNION ALL
SELECT staff_id, staff_name, 'Staff' AS source
FROM staff
ORDER BY source, name;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT patient_id AS Id, name AS Name, 'High_satisfaction' as Category, satisfaction 
FROM patients WHERE satisfaction > 90
UNION ALL
SELECT patient_id AS Id, name AS Name, 'low_satisfaction' as Category, satisfaction 
FROM patients WHERE satisfaction < 50
ORDER BY satisfaction DESC;

-- 3. List all unique names from both patients and staff tables.
SELECT DISTINCT name, 'Patient' AS source
FROM patients 
UNION
SELECT DISTINCT staff_name, 'Staff' AS source
FROM staff 
ORDER BY source, name;
````

---

### 💡 Tips & Tricks

✅ **Prefer UNION ALL** when duplicates are not a concern — it avoids unnecessary sorting.

```sql
SELECT * FROM patients WHERE age < 30
UNION ALL
SELECT * FROM patients WHERE age > 60;
```

✅ Column names come from the **first SELECT**

```sql
SELECT name AS patient_name FROM patients
UNION
SELECT staff_name FROM staff;   -- still uses 'patient_name'
```

✅ Add identifiers using literals

```sql
SELECT name, 'Patient' AS source FROM patients
UNION ALL
SELECT staff_name, 'Staff' AS source FROM staff;
```

✅ Always place ORDER BY at the end

```sql
SELECT name FROM patients
UNION
SELECT staff_name FROM staff
ORDER BY name;
```

🔍 **Data type mismatch example**

```sql
-- Valid: both text
SELECT patient_id FROM patients
UNION
SELECT staff_id FROM staff;

-- Invalid: INT vs TEXT (may cause error)
SELECT age FROM patients
UNION
SELECT staff_name FROM staff;
```

---

📚 **Resources**

* [https://youtu.be/su-fxrvKTCk?si=IkTlXQWftkPK1ra-](https://youtu.be/su-fxrvKTCk?si=IkTlXQWftkPK1ra-)

---

### 🎯 Challenge

#### **Question:**

Create a combined personnel and patient list showing:

* identifier (patient_id or staff_id)
* full name
* type ('Patient' or 'Staff')
* associated service

Include only **'surgery'** and **'emergency'** services.
Order by **type**, then **service**, then **name**.

---

### 💡 Thought Process

* Use **UNION ALL** since we’re combining two different tables and duplicates aren’t an issue
* Add type labels (`'Patient'`, `'Staff'`) to distinguish datasets
* Filter both tables for targeted services
* Standardize column order to match across both SELECT statements
* Apply final sorting on the combined results

---

### 🧠 Challenge Query

```sql
SELECT patient_id AS identifier, name AS full_name, 'Patient' AS type, service 
FROM patients WHERE service IN ('surgery', 'emergency')
UNION ALL
SELECT staff_id AS identifier, staff_name AS full_name, 'Staff' AS type, service
FROM staff WHERE service IN ('surgery', 'emergency')
ORDER BY type, service, full_name;
```

---

### ✨ Takeaway

`UNION` is more than combining data — it’s integrating perspectives.
It lets you merge insights across datasets, build summaries, and see the bigger picture in a single query.
