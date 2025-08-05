
# 🧠 Comparison of SQL Server Subqueries: Scalar vs Row

This document explains the **difference between Scalar and Row Subqueries** in SQL Server with examples and best practices.

---

## 📘 What is a Scalar Subquery?

A **Scalar Subquery** returns a **single value** (one cell only). It’s like asking for one specific piece of data from a table.

✅ **Returns:** Exactly **one column and one row**.

### ✅ Example:
```sql
-- Get all products more expensive than the average price
SELECT *
FROM Products
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
);
```
This subquery returns one value (e.g., 25.3), so it’s a scalar subquery.

---

## 📘 What is a Row Subquery?

A **Row Subquery** returns **exactly one row but can contain multiple columns**.

⚠️ SQL Server **does NOT support** comparing tuples like `(col1, col2)` directly, so we use separate scalar subqueries.

### 🔴 Invalid in SQL Server:
```sql
-- NOT supported!
WHERE (FirstName, LastName) = (
    SELECT FirstName, LastName FROM Employees WHERE EmployeeID = 2
)
```

### ✅ Correct version for SQL Server:
```sql
SELECT *
FROM Employees
WHERE FirstName = (
        SELECT FirstName FROM Employees WHERE EmployeeID = 2
    )
  AND LastName = (
        SELECT LastName FROM Employees WHERE EmployeeID = 2
    )
  AND EmployeeID <> 2;
```
Here, two scalar subqueries are combined to simulate a row-based comparison.

---

## 📊 Summary Table

| Feature                | Scalar Subquery              | Row Subquery                                  |
|------------------------|-------------------------------|-----------------------------------------------|
| ✅ Output Rows         | One                          | One                                            |
| ✅ Output Columns      | One                          | More than one                                 |
| 📌 Common Use          | Comparing with a single value| Comparing multiple columns simultaneously     |
| ⚠️ SQL Server Support | Fully supported               | Needs to be rewritten (no tuple comparison)   |

---

## ✍️ Conclusion

- Use **scalar subqueries** for simple value comparisons.
- For **row comparisons**, use multiple scalar subqueries to match columns.
- Avoid tuple-style comparisons like `(col1, col2)` in SQL Server.

Happy querying! 💡
