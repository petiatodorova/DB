CREATE DATABASE Demo
USE Demo

CREATE TABLE Countries (
	CountryId INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50),

	CONSTRAINT PK_Countries
	PRIMARY KEY(CountryId)
)

CREATE TABLE Towns (
	TownId INT NOT NULL IDENTITY,
	[Name] NVARCHAR(50) NOT NULL,
	CountryId INT NOT NULL,

	CONSTRAINT PK_Towns
	PRIMARY KEY(TownId),

	CONSTRAINT FK_Towns_Countries
	FOREIGN KEY(CountryId)
	REFERENCES Countries(CountryId)
)

INSERT INTO Countries
VALUES
('Bulgaria'),
('Germany'),
('Afganistan')

SELECT * FROM Countries

INSERT INTO Towns
VALUES
('Haskovo', 1),
('Munchen', 2),
('Cabul', 2)

SELECT * 
FROM Countries AS c
JOIN Towns AS t
ON c.CountryId = t.CountryId


USE Geography

SELECT * FROM PeakElevation
SELECT * FROM Peaks

SELECT MountainRange, PeakName, Elevation
FROM Mountains AS m
JOIN Peaks AS p
ON p.MountainId = m.Id