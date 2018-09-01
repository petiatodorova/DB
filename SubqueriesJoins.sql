USE SoftUni

SELECT * 
FROM INFORMATION_SCHEMA.TABLES

SELECT * 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS

SELECT FirstName, LastName 
FROM Employees AS emp
RIGHT OUTER JOIN Departments AS dep
ON dep.DepartmentID = emp.DepartmentID

SELECT FirstName, LastName 
FROM Employees AS emp
CROSS JOIN Departments AS dep

SELECT * FROM Addresses
SELECT * FROM Employees


--Problem 1. Employee Address
SELECT TOP(5) emp.EmployeeID, emp.JobTitle, emp.AddressID, adr.AddressText
FROM Employees AS emp
JOIN Addresses AS adr
ON emp.AddressID = adr.AddressID
ORDER BY emp.AddressID


--Problem 2. Addresses with Towns
  SELECT TOP(50) e.FirstName, e.LastName, t.Name, a.AddressText 
    FROM Employees AS e
    JOIN Addresses AS a
      ON e.AddressID = a.AddressID
    JOIN Towns AS t
      ON a.TownID = t.TownID
ORDER BY e.FirstName ASC, e.LastName ASC
GO

CREATE VIEW v_FullName AS
SELECT FirstName, LastName
FROM Employees
GO

SELECT TOP(20) *
FROM v_FullName
ORDER BY FirstName ASC

USE SoftUni

SELECT * FROM Employees


--Problem 3. Sales Employee

SELECT emp.EmployeeID, emp.FirstName, emp.LastName, dep.Name
FROM Employees AS emp
JOIN Departments AS dep
ON emp.DepartmentID = dep.DepartmentID
AND dep.Name = 'Sales'
ORDER BY emp.EmployeeID ASC


--Problem 4. Employee Departments

  SELECT TOP(5) emp.EmployeeID, emp.FirstName, emp.Salary, dep.Name 
    FROM Employees AS emp
    JOIN Departments AS dep
      ON dep.DepartmentID = emp.DepartmentID
   WHERE emp.Salary > 15000
ORDER BY emp.DepartmentID ASC

--Problem 5. Employees Without Project
SELECT TOP(3) e.EmployeeID, e.FirstName
FROM Employees AS e
LEFT JOIN EmployeesProjects AS p
ON p.EmployeeID = e.EmployeeID
WHERE ProjectID IS NULL
ORDER BY e.EmployeeID ASC


--Problem 6. Employees Hired After
  SELECT e.FirstName, e.LastName, e.HireDate, d.Name
    FROM Employees AS e
    JOIN Departments AS d
      ON e.DepartmentID = d.DepartmentID
   WHERE e.HireDate > '1.1.1999'
     AND d.Name IN ('Sales', 'Finance')
ORDER BY e.HireDate ASC


--Problem 7. Employees with Project
  SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name
    FROM Employees AS e
    JOIN EmployeesProjects AS ep 
      ON ep.EmployeeID = e.EmployeeID
    JOIN Projects AS p 
      ON p.ProjectID = ep.ProjectID
   WHERE p.StartDate > '2002.08.13'
     AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC


--Problem 8. Employee 24
EmployeeID
FirstName
ProjectName
Filter all the projects of employee with Id 24. If the project has 
started during or after 2005 the returned value should be NULL.

SELECT e.EmployeeID, e.FirstName, 
  CASE
    WHEN p.StartDate > '2005/01/01' THEN NULL
    ELSE p.Name
  END
 FROM Employees AS e
 JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
 JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24


--Problem 9. Employee Manager
  SELECT emp.EmployeeID, emp.FirstName, emp.ManagerID, mng.FirstName
    FROM Employees AS emp
    JOIN Employees AS mng
      ON mng.EmployeeID = emp.ManagerID
   WHERE emp.ManagerID IN (3, 7)
ORDER BY emp.EmployeeID ASC


--Problem 10. Employee Summary
  SELECT TOP(50) 
         emp.EmployeeID, 
         emp.FirstName + ' ' + emp.LastName AS [EmployeeName], 
		 mng.FirstName + ' ' + mng.LastName AS [ManagerName], 
		 dep.Name AS [DepartmentName]
    FROM Employees AS emp
    JOIN Employees AS mng
      ON mng.EmployeeID = emp.ManagerID
    JOIN Departments AS dep
      ON dep.DepartmentID = emp.DepartmentID
ORDER BY emp.EmployeeID


--Problem 11. Min Average Salary
  SELECT MIN(sal.AvgSalary) 
    FROM
 (SELECT AVG(Salary) AS AvgSalary
    FROM Employees 
GROUP BY DepartmentID) AS sal

use geography

--Problem 12. Highest Peaks in Bulgaria
  SELECT c.CountryCode, m.MountainRange, p.PeakName, p.Elevation
    FROM Countries AS c
    JOIN MountainsCountries AS mc
      ON mc.CountryCode = c.CountryCode
    JOIN Mountains AS m
      ON m.Id = mc.MountainId
    JOIN Peaks AS p
      ON p.MountainId = m.Id
   WHERE c.CountryCode = 'BG'
     AND p.Elevation > 2835
ORDER BY p.Elevation DESC


--Problem 13. Count Mountain Ranges
  SELECT c.CountryCode, COUNT(m.MountainRange)
    FROM Countries AS c
    JOIN MountainsCountries AS mc
      ON mc.CountryCode = c.CountryCode
    JOIN Mountains AS m
      ON m.Id = mc.MountainId
   WHERE c.CountryCode IN ('BG', 'RU', 'US')
GROUP BY c.CountryCode


--Problem 14. Countries with Rivers
  SELECT TOP(5) c.CountryName, r.RiverName
    FROM Countries AS c
    LEFT JOIN CountriesRivers AS cr
      ON cr.CountryCode = c.CountryCode
    LEFT JOIN Rivers AS r
      ON r.Id = cr.RiverId
   WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName ASC

