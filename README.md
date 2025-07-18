# total_work_hours
# 🕒 SQL Server Script – Calculate Working Hours Between Dates

This project contains a SQL Server stored procedure that calculates the number of working hours between two given dates. It excludes all **Sundays** and the **1st and 2nd Saturdays** of each month, unless those specific dates are the **start or end date**, in which case they are included in the calculation.

---

## 📌 Features

- Excludes **all Sundays**.
- Excludes the **1st and 2nd Saturdays** of the month.
- **Includes** `Start_Date` and `End_Date` even if they fall on excluded days.
- Calculates working **hours** (`1 day = 24 hours`).
- Stores results in a table for future reference.

---

## 📂 Project Structure

- **Stored Procedure:** `CalculateWorkingHours`
- **Result Table:** `counttotalworkinhours`
- **Inputs:** `@Start_Date`, `@End_Date` (both `DATETIME`)
- **Output:** Total working hours between the two dates

---

## ⚙️ Setup Instructions

1. Open SQL Server Management Studio.
2. Copy and paste the full script into a new query window.
3. Execute the script to:
   - Drop existing procedure/table (if any).
   - Create a result table.
   - Create the stored procedure.
   - Run sample executions.
   - View stored results.

---

## 🧪 Sample Executions

### ✅ Example 1: Simple 2-day Range
```sql
EXEC CalculateWorkingHours '2023-07-12', '2023-07-13';
-- Expected: 2 * 24 = 48 hours
