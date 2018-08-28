USE Gringotts

--Problem 1. Records’ Count
SELECT MAX(Id) FROM WizzardDeposits


--Problem 2. Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand 
  FROM WizzardDeposits


  --Problem 3. Longest Magic Wand per Deposit Groups
  SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
  FROM WizzardDeposits
  GROUP BY DepositGroup


  --Problem 4. Smallest Deposit Group per Magic Wand Size
  SELECT TOP(2) DepositGroup
  FROM WizzardDeposits
  GROUP BY DepositGroup
  ORDER BY AVG(MagicWandSize)
  
  SELECT * FROM WizzardDeposits
    --Problem 5. Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
  FROM WizzardDeposits
 GROUP BY DepositGroup


 --Problem 6. Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
  FROM WizzardDeposits
 WHERE MagicWandCreator = 'Ollivander family'
 GROUP BY DepositGroup
 HAVING SUM(DepositAmount) < 150000 
 ORDER BY TotalSum DESC

--Problem 7. Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS [TotalSum]
  FROM WizzardDeposits
 WHERE MagicWandCreator = 'Ollivander family'
 GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000 
 ORDER BY TotalSum DESC


--Problem 8. Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS [MinDepositCharge]
  FROM WizzardDeposits
 GROUP BY DepositGroup, MagicWandCreator
 ORDER BY MagicWandCreator, DepositGroup ASC


--Problem 9. Age Groups
SELECT AgeGroup, COUNT(*) AS WizardCount FROM (
SELECT CASE
		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN Age BETWEEN 10 AND 20 THEN '[11-20]'
		WHEN Age BETWEEN 20 AND 30 THEN '[21-30]'
		WHEN Age BETWEEN 30 AND 40 THEN '[31-40]'
		WHEN Age BETWEEN 40 AND 50 THEN '[41-50]'
		WHEN Age BETWEEN 50 AND 60 THEN '[51-60]'
		WHEN Age > 60 THEN '[61+]'
	END AS AgeGroup
FROM WizzardDeposits) AS e
GROUP BY e.AgeGroup


--Problem 10. First Letter
SELECT LEFT(FirstName,1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName, 1)


--Second solution
SELECT e.FirstLetter FROM (
SELECT LEFT(FirstName,1) AS [FirstLetter] 
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest') AS e
GROUP BY e.FirstLetter


--Problem 11. Average Interest 
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest 
  FROM WizzardDeposits
  WHERE DepositStartDate >= '01/01/1985'
  GROUP BY DepositGroup, IsDepositExpired
  ORDER BY DepositGroup DESC, IsDepositExpired ASC

  SELECT * FROM WizzardDeposits


--Problem 12. Rich Wizard, Poor Wizard
SELECT SUM(e.Diff) AS [TotalSum] FROM (
SELECT DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id) AS Diff
  FROM WizzardDeposits 
  ) AS e


  --Problem 13. Departments Total Salaries
  USE SoftUni
  SELECT DepartmentID, SUM(Salary) AS [TotalSalary] 
  FROM Employees
  GROUP BY DepartmentID
  ORDER BY DepartmentID


  --Problem 14. Employees Minimum Salaries
  SELECT * FROM Employees
  SELECT DepartmentID, MIN(Salary) AS [MinimumSalary]
  FROM Employees
  WHERE DepartmentID IN (2, 5, 7)
  AND HireDate >= '01/01/2000'
  GROUP BY DepartmentID


  --Problem 15. Employees Average Salaries
  SELECT * FROM Employees
  SELECT * INTO EmployeesAverageSalary
  FROM Employees
  WHERE Salary > 30000

 DELETE FROM EmployeesAverageSalary
 WHERE ManagerID = 42

UPDATE EmployeesAverageSalary
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS [AverageSalary]
FROM EmployeesAverageSalary
GROUP BY DepartmentID


--Problem 16. Employees Maximum Salaries
--NOT in the range 30000 – 70000
SELECT DepartmentID, MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) < 30000 OR MAX(Salary) > 70000


--Problem 17. Employees Count Salaries
SELECT COUNT(Salary)
FROM Employees
WHERE ManagerID IS NULL


--Problem 18. 3rd Highest Salary
SELECT DISTINCT e.DepartmentID, e.Salary AS [ThirdHighestRank] FROM (
SELECT DepartmentID, Salary, DENSE_RANK() OVER (PARTITION BY DepartmentID 
ORDER BY Salary DESC) AS [SalaryRank]
FROM Employees) AS e
WHERE SalaryRank = 3


--Problem 19. Salary Challenge
SELECT TOP(10) FirstName, LastName, DepartmentID 
FROM Employees AS emp
WHERE Salary > (SELECT AVG(Salary) FROM Employees WHERE DepartmentID = emp.DepartmentID)
ORDER BY DepartmentID ASC



