USE Master
GO
IF DB_ID('CSGODB') IS NOT NULL
	BEGIN
		ALTER DATABASE CSGODB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE CSGODB
	END
GO
CREATE DATABASE CSGODB
GO
USE CSGODB
GO

DROP TABLE IF EXISTS Player
CREATE TABLE Player (
Id INT PRIMARY KEY IDENTITY(1,1),
PlayerName NVARCHAR(20),
)

DROP TABLE IF EXISTS Weapon
CREATE TABLE Weapon(
Id INT PRIMARY KEY IDENTITY(1,1),
WeaponName NVARCHAR(100)
)

DROP TABLE IF EXISTS Skin
CREATE TABLE Skin (
Id INT PRIMARY KEY IDENTITY(1,1),
SkinName NVARCHAR(100),
WeaponId INT FOREIGN KEY REFERENCES Weapon(Id)
)

INSERT INTO Player VALUES ('Kjærbye'), ('Dev1ce'), ('KennyS')
INSERT INTO Weapon Values ('Ak-47'),('AWP'),('USP-S')
INSERT INTO Skin VALUES ('Ice Coaled', 1),('Asiimov', 1),('Neo-Noir', 2),('Printstream', 3)


DROP TABLE IF EXISTS PlayerSkin
CREATE TABLE PlayerSkin (
PlayerId INT,
SkinId Int
CONSTRAINT FK_PlayerId FOREIGN KEY (PlayerId) REFERENCES Player(Id)
)

ALTER TABLE PlayerSkin ADD CONSTRAINT FK_SkinId FOREIGN KEY (SkinId) 
REFERENCES Skin(Id)

INSERT INTO PlayerSkin VALUES (1,1),(1,3),(2,1),(2,4),(2,3),(3,3),(3,4)

SELECT CONCAT(WeaponName, ' ', SkinName) AS 'WeaponSkin' FROM Skin 
JOIN Weapon ON Skin.WeaponId = Weapon.Id

GO
CREATE VIEW PlayerSkinView AS
	SELECT PlayerName AS 'Player', STRING_AGG(SkinName, ', ') AS Skins FROM Player
	JOIN PlayerSkin ON Player.Id = PlayerSkin.PlayerId
	JOIN Skin ON Skin.Id = PlayerSkin.SkinId
	GROUP BY PlayerName
GO

SELECT * FROM PlayerSkinView --WHERE Player like 'Dev%'

SELECT SkinName, STRING_AGG(PlayerName, ' - ') FROM Skin
JOIN PlayerSkin ON Skin.Id = PlayerSkin.PlayerId
JOIN Player ON Player.Id = PlayerSkin.PlayerId
GROUP BY SkinName