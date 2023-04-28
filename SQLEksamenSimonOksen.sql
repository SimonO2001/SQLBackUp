USE Master
GO
IF DB_ID('LaundromatDB') IS NOT NULL
	BEGIN
		ALTER DATABASE LaundromatDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE LaundromatDB
	END
GO
CREATE DATABASE LaundromatDB
GO
USE LaundromatDB
GO

DROP TABLE IF EXISTS Laundromat
CREATE TABLE Laundromat (
Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
[Name] NVARCHAR(255) NOT NULL,
OpenTime TIME NOT NULL,
CloseTime TIME NOT NULL
)

DROP TABLE IF EXISTS Costumer
CREATE TABLE Costumer (
Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
[Name] NVARCHAR(255) NOT NULL,
Email NVARCHAR(255) NOT NULL,
[Password] NVARCHAR(255) NOT NULL,
check (LEN([Password]) >= 5),
[Date] DATE NOT NULL,
AccountBal DECIMAL NOT NULL,
LaundromatId INT FOREIGN KEY REFERENCES Laundromat(Id) 

CONSTRAINT CheckEmail UNIQUE (Email)
)

DROP TABLE IF EXISTS Machine
CREATE TABLE Machine (
Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
[Name] NVARCHAR(255) NOT NULL,
PricePerWash DECIMAL NOT NULL,
TimeToWash INT NOT NULL,
LaundromatId INT FOREIGN KEY REFERENCES Laundromat(Id) 
)

DROP TABLE IF EXISTS Booking
CREATE TABLE Booking (
Id INT NOT NULL PRIMARY KEY IDENTITY (1,1),
BookingDateTime DATETIME NOT NULL,
CostumerId INT FOREIGN KEY REFERENCES Costumer(Id),
LaundromatId INT FOREIGN KEY REFERENCES Machine(Id)
)

INSERT INTO Laundromat([Name], OpenTime, CloseTime) VALUES ('WhiteWash inc', '08:00', '20:00')
INSERT INTO Laundromat([Name], OpenTime, CloseTime) VALUES ('Double Bubble', '02:00', '22:00')
INSERT INTO Laundromat([Name], OpenTime, CloseTime) VALUES ('Wash & Coffe', '12:00', '20:00')

INSERT INTO Costumer([Name], Email, [Password], [Date], AccountBal, LaundromatId) VALUES ('John', 'John_doe66@gmail.com' ,'password', '2021-02-15', 100, 2)
INSERT INTO Costumer([Name], Email, [Password], [Date], AccountBal, LaundromatId) VALUES ('Neil Armstrong', 'firstman@nasa.gov' ,'eagleLander69', '2021-02-10', 1000, 1)
INSERT INTO Costumer([Name], Email, [Password], [Date], AccountBal, LaundromatId) VALUES ('Batman', 'noreply@thecave.com' ,'Rob1n', '2020-03-10', 500, 3)
INSERT INTO Costumer([Name], Email, [Password], [Date], AccountBal, LaundromatId) VALUES ('Goldman Sachs', 'moneylaundering@gs.com' ,'NotRecognized', '2021-01-01', 100000, 1)
INSERT INTO Costumer([Name], Email, [Password], [Date], AccountBal, LaundromatId) VALUES ('50 Cent', '50cent@gmail.com' ,'ItsMyBirthday', '2020-07-06', 0.50, 3)

INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('Mielle 911 Turbo', 5, 60, 2)
INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('Siemons IClean', 10000, 30, 1)
INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('Electrolax FX-2', 15, 45, 2)
INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('NASA Spacewasher 8000', 500, 5, 1)
INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('The Lost Sock', 3.50, 90, 3)
INSERT INTO Machine ([Name], PricePerWash, TimeToWash, LaundromatId) VALUES ('Yo Mama', 0.50, 120, 3)

INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 12:00:00', 1, 1)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 16:00:00', 1, 3)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 08:00:00', 2, 4)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 15:00:00', 3, 5)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 20:00:00', 4, 2)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 19:00:00', 4, 2)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 10:00:00', 4, 2)
INSERT INTO Booking (BookingDateTime, CostumerId, LaundromatId) VALUES ('2021-02-26 16:00:00', 5, 6)

GO

--OPGAVE 9
CREATE VIEW ViewBooking AS
	SELECT Booking.BookingDateTime as BookningTime, Costumer.[Name] as CostumerName, Machine.[Name], Machine.PricePerWash
	FROM Booking



	JOIN Costumer ON Costumer.Id = Booking.CostumerId
	JOIN Machine ON Machine.Id =  Booking.LaundromatId

GO

SELECT * FROM ViewBooking

--OPGAVE 10 
SELECT * FROM Costumer WHERE Costumer.Email LIKE '%@gmail.com' 

SELECT * FROM Machine, Laundromat 


SELECT Machine.[Name] as 'Machine Name', COUNT (Booking.LaundromatId) as Booking
FROM Machine
join Booking on booking.LaundromatId = Machine.Id
Group By Machine.[Name]

DELETE FROM Booking WHERE CAST(BookingDateTime as time(0)) BETWEEN '12:00:00' AND '13:00:00'

UPDATE Costumer SET Costumer.[Password] = 'SelinaKyle' WHERE Costumer.Id = 3 

--
