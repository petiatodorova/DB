USE SoftUni

SELECT * FROM Addresses

SELECT * FROM Employees

SELECT FirstName, LastName FROM Employees

CREATE TABLE Emps (
	Id INT NOT NULL,
	FirstName NVARCHAR(50)
)

ALTER TABLE Emps
ADD CONSTRAINT PK_EMPS_ID
PRIMARY KEY (Id)

SELECT * FROM Emps

SELECT * FROM Employees

SELECT * FROM Addresses

SELECT * FROM Towns

SELECT FirstName, LastName FROM Employees WHERE JobTitle = 'Design Engineer'

SELECT FirstName, LastName, Addresses.AddressText FROM Employees
		JOIN Addresses
		ON Employees.AddressID = Addresses.AddressID

SELECT FirstName + ' ' + LastName AS [Full Name], 
	EmployeeID AS [Number]
FROM Employees


SELECT FirstName + ' ' + LastName AS [Full Name],
	Salary AS [Salary],
	JobTitle AS [Job Title]
FROM Employees
ORDER BY Salary DESC

SELECT * FROM Departments

SELECT DISTINCT Name
	FROM Departments

SELECT * FROM Departments

SELECT * FROM Employees

--cross select
SELECT FirstName + ' ' + LastName AS [Full Name]
	   FROM Employees
	  WHERE DepartmentID = (SELECT DepartmentID 
		                        FROM Departments 
							   WHERE Name = 'Engineering')

--'>='
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
	   FROM Employees
	   WHERE Salary >= 20000
	   ORDER BY Salary DESC


--BETWEEN
SELECT FirstName + ' ' + LastName AS [Full Name], Salary
	   FROM Employees
	   WHERE Salary BETWEEN 20000 AND 22000
	   ORDER BY Salary DESC

SELECT FirstName + ' ' + LastName AS [Full Name], ManagerID, Salary
	   FROM Employees
	   WHERE ManagerID IN (3, 9, 14)
	   ORDER BY Salary DESC
	   GO

--View
CREATE VIEW v_NullMiddleName AS
       SELECT FirstName + ' ' + LastName AS [Full Name], ManagerID, Salary
	   FROM Employees
	   WHERE MiddleName IS NULL
	   GO

SELECT * FROM v_NullMiddleName

USE Geography
GO

--SELECT ONLY 1
SELECT TOP(1) * FROM Peaks
ORDER BY Elevation DESC

SELECT * FROM Mountains
GO

--JOIN
SELECT P.PeakName, M.MountainRange
   FROM Peaks AS P
   JOIN Mountains AS M
   ON P.MountainId = M.Id

SELECT DISTINCT P.PeakName, M.MountainRange
   FROM Peaks AS P
   JOIN Mountains AS M
   ON P.MountainId = M.Id

--Create new table
SELECT PeakName, Elevation AS [Peaks and Elevations]
INTO PeakElevation
FROM Peaks

SELECT * FROM PeakElevation

USE SoftUni

SELECT * FROM Employees WHERE DepartmentID = 3

UPDATE Employees
SET Salary = Salary * 1.1,
    JobTitle =  'Senior ' + JobTitle 
	WHERE DepartmentID = 3

SELECT * FROM Projects

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL

--23. Biggest Countries by Population
USE Geography

SELECT TOP(30) CountryName, Population 
       FROM Countries
	   WHERE ContinentCode = 'EU'
	   ORDER BY Population DESC, CountryName
	   GO

SELECT * FROM Countries

SELECT * FROM Currencies

