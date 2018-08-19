USE SoftUni

--Problem 1. Find Names of All Employees by First Name
SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%'


--Problem 2. Find Names of All employees by Last Name
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'


--Problem 3. Find First Names of All Employees
SELECT FirstName
  FROM Employees
 WHERE (DepartmentID = 3 OR DepartmentID = 10)
   AND DATEPART(YEAR, HireDate) BETWEEN 1995 AND 2005

--Problem 3. Find First Names of All Employees (second solution)
SELECT FirstName
  FROM Employees
 WHERE (DepartmentID = 3 OR DepartmentID = 10)
   AND (HireDate >= 01/01/1995 OR HireDate <= 31/12/2005)


--Problem 4. Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'


--Problem 5. Find Towns with Name Length
SELECT [Name] FROM Towns
 WHERE LEN([Name]) = 5 OR LEN([Name]) = 6
 ORDER BY [Name] ASC


--Problem 6. Find Towns Starting With
SELECT * FROM Towns
WHERE [Name] LIKE 'M%' OR [Name] LIKE 'K%' OR [Name] LIKE 'B%' OR [Name] LIKE 'E%'
 ORDER BY [Name] ASC


--Problem 7. Find Towns Not Starting With
SELECT * FROM Towns
WHERE [Name] NOT LIKE 'R%' AND [Name] NOT LIKE 'B%' AND [Name] NOT LIKE 'D%'
 ORDER BY [Name] ASC
 GO


--Problem 8. Create View Employees Hired After 2000 Year
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE DATEPART(YEAR, HireDate)> 2000
GO

SELECT * FROM [dbo].[V_EmployeesHiredAfter2000]


--Problem 9. Length of Last Name
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5


--Problem 10. Countries Holding ‘A’ 3 or More Times
USE Geography
SELECT CountryName, IsoCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode ASC
GO


--Problem 11. Mix of Peak and River Names
SELECT PeakName, RiverName, LOWER(CONCAT(LEFT(PeakName, LEN(PeakName) - 1), RiverName)) AS [Mix] FROM Peaks, Rivers
WHERE RIGHT(PeakName, 1) = LEFT(RiverName, 1)
ORDER BY Mix ASC


--Problem 12. Games from 2011 and 2012 year
USE Diablo
SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start] FROM Games
WHERE DATEPART(YEAR, [Start]) BETWEEN 2011 AND 2012
ORDER BY [Start] ASC, [Name] ASC


--Problem 13. User Email Providers
SELECT UserName, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS [Email Provider] FROM Users
ORDER BY [Email Provider] ASC, Username ASC


--Problem 14. Get Users with IPAdress Like Pattern
SELECT UserName, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username ASC


--Problem 16. Orders Table
USE Orders

SELECT ProductName, OrderDate, 
  DATEADD(DAY, 3, OrderDate) AS [Pay Due],
  DATEADD(MONTH, 1, OrderDate) AS [Deliver Due]
  FROM Orders
  GO


--Problem 17. People Table
-- People(Id, Name, Birthdate)
CREATE TABLE People (
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50),
	Birthdate DATE NOT NULL
)

INSERT INTO People VALUES
(1, 'Victor', '2000-12-07 00:00:00.000'),
(2, 'Steven', '1992-09-10 00:00:00.000'),
(3, 'Stephen', '1910-09-19 00:00:00.000'),
(4, 'John', '2010-01-06 00:00:00.000')

SELECT [Name], 
  DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
  DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
  DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
  DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutes]
  FROM People


