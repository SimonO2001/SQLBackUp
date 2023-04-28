USE Master
GO
IF DB_ID('CarDB') IS NOT NULL
	BEGIN
		ALTER DATABASE CarDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE CarDB
	END
GO
CREATE DATABASE CarDB
GO
USE CarDB
GO

DROP TABLE IF EXISTS Car
CREATE TABLE Car (
Id INT IDENTITY(1,1),
Logo NVARCHAR(255)
)

DROP TABLE IF EXISTS Accessories 
CREATE TABLE Accessories  (
Id INT IDENTITY(1,1),
[Type] NVARCHAR(255)
)

DROP TABLE IF EXISTS CarAccessories
CREATE TABLE CarAccessories  (
CarId INT,
AccessoriesID INT
)

INSERT INTO Car VALUES ('Audi'),('BMW'),('Mercedes')
INSERT INTO Accessories VALUES ('Leather Seats'),('LED Headlights'),('Sunroof')

INSERT INTO CarAccessories VALUES (1,1), (1,2), (1,3), (2,1), (2,2), (2,3), (3,1), (3,2), (3,3)

SELECT Car.Logo, STRING_AGG(Accessories.[Type],', ') AS 'Accessories' FROM Car
FULL JOIN CarAccessories ON Car.Id = CarAccessories.CarId
FULL JOIN Accessories ON Accessories.Id = CarAccessories.AccessoriesID
GROUP BY Car.Logo

