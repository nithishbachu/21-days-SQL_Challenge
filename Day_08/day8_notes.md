# 🗓️ Day 8 – Working with String Functions

### 📘 Topics Covered
- Transforming text using `UPPER()` and `LOWER()`
- Measuring text length with `LENGTH()`
- Joining strings with `CONCAT()`
- Extracting parts of strings using `SUBSTRING()`
- Cleaning and replacing text with `TRIM()` and `REPLACE()`

---

### 💡 Key Points

- `UPPER(column/string)` → Converts text to uppercase  
- `LOWER(column/string)` → Converts text to lowercase  
- `LENGTH(column/string)` → Returns the number of characters in a string  
- `CONCAT(str1, str2,...)` → Joins two or more strings
- `CONCAT_WS('separator', str1, str2,...)` → Joins two or more strings with specified separator
- `SUBSTRING(str, start, length)` → Extracts part of a string  
- `TRIM('trim_character' FROM string)` → Removes spaces from both ends (trim_character - optional)
- `LTRIM('trim_character' FROM string)` → Removes leading spaces (trim_character - optional)
- `RTRIM('trim_character' FROM string)` → Removes trailing spaces (trim_character - optional)
- `REPLACE(str, old, new)` → Substitutes one text with another  

---

### 💻 Practice Queries

```sql
-- 1. Convert all patient names to uppercase.
SELECT UPPER(name) AS patient_name
FROM patients;

-- 2. Find the length of each staff member's name.
SELECT staff_name, LENGTH(staff_name) AS name_length
FROM staff;

-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT staff_id, staff_name, CONCAT_WS('-', staff_id, staff_name) AS staff_id_name
FROM staff;

-- 4. Daily Challenge: Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category 
-- (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length. Only show patients whose name length is 
-- greater than 10 characters.
SELECT patient_id, UPPER(name) AS name, LOWER(service) AS service,
CASE WHEN age >= 65 THEN 'Senior' WHEN age >= 18 AND age < 65 THEN 'Adult' ELSE 'Minor' END AS age_category, LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;
````

---

### 💡 Tips & Tricks

✅ Use `||` for concatenation in **PostgreSQL/SQLite**, and `CONCAT()` in **MySQL**.
✅ `LTRIM()`, `RTRIM()`, and `TRIM()` help clean unwanted spaces.
✅ Use `LOWER()` in conditions for case-insensitive matches:

```sql
WHERE LOWER(name) = LOWER('john smith');
```

✅ Avoid string functions in `WHERE` when performance matters — they disable index use.
✅ Combine with `CASE` for custom formatting logic.

---

### 🧠 Example: Conditional String Handling

```sql
SELECT
    name,
    CASE
        WHEN LENGTH(name) > 20 THEN SUBSTRING(name, 1, 20) || '...'
        ELSE name
    END AS display_name
FROM patients;
```

---

📚 **Resources:**

* [String Functions in SQL - CodeBasics](https://youtu.be/hcmdxmgBdxk?si=s0BVc-uyg1aLIrOS)
* [SQL String Operations Explained](https://youtu.be/W5YA5B2RQBU?si=Qrr1monOcHTExw4V)
* [Mastering SQL String Functions](https://youtu.be/ztfO3Yz7cx4?si=BIN53vRhk4uEGEVv)

---

### 🎯 Challenge

#### Question:

Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', 
else 'Minor'), and name length. Only show patients whose name length is greater than 10 characters.
Only include patients whose name length is greater than **10** characters.

---

### 💡 Thought Process

* We’re transforming and formatting text data to make it cleaner and more insightful.
* Use `UPPER()` for name, `LOWER()` for service.
* Derive age categories using a `CASE` expression.
* Filter using `WHERE LENGTH(name) > 10`.
* Alias all columns clearly for readability.

---

### 🧠 Query

```sql
SELECT
    patient_id,
    UPPER(name) AS full_name_upper,
    LOWER(service) AS service_lower,
    CASE
        WHEN age >= 65 THEN 'Senior'
        WHEN age >= 18 THEN 'Adult'
        ELSE 'Minor'
    END AS age_category,
    LENGTH(name) AS name_length
FROM patients
WHERE LENGTH(name) > 10;
```

---

### ✨ Takeaway

Mastering string functions helps you turn messy text data into structured insights — making your queries both clean and powerful.
It’s the difference between reading data and *understanding* it.
