CREATE DATABASE IF NOT EXISTS  BreakdownCompany;
USE BreakdownCompany;
--	----------------------------------------------------- Task 1: Create Tables ----------------------------------------------------
CREATE TABLE IF NOT EXISTS Member
	(
	MemberID varchar(10) PRIMARY KEY NOT NULL,
	MemberFName varchar(20),
	MemberLName varchar(20),
	MemberLoc varchar(20)
    );

CREATE TABLE IF NOT EXISTS Vehicle
	(
	VehicleReg varchar(10) PRIMARY KEY NOT NULL,
	VehicleMake varchar(10),
	VehicleModel varchar(10),
    MemberID varchar(10) 
    );
    
CREATE TABLE IF NOT EXISTS Engineer
	(
	EngineerID int PRIMARY KEY AUTO_INCREMENT,
	EngineerFName varchar(20),
	EngineerLName varchar(20)
    );

CREATE TABLE IF NOT EXISTS Breakdown
	(
	BreakdownID int PRIMARY KEY,
	BreakdownDATE date,
	BreakdownTIME time,
	BreakdownLoc varchar(20),
    VehicleReg varchar(10) ,
    EngineerID int	
    );
    
ALTER TABLE Vehicle ADD FOREIGN KEY (MemberID) REFERENCES Member(MemberID);
ALTER TABLE Breakdown ADD FOREIGN KEY (VehicleReg) REFERENCES Vehicle(VehicleReg);
ALTER TABLE Breakdown ADD FOREIGN KEY (EngineerID) REFERENCES Engineer(EngineerID);

-- ------------------------------------------------------------------- TASK 2: Insert Data -----------------------------------

INSERT INTO Member (MemberID, MemberFName, MemberLName, MemberLoc) 
VALUES	('reg001', 'Jane', 'Smith', 'Camden'),
		('reg002', 'Alice', 'Johnson', 'Greenwich'),
		('reg003', 'Bob',  'Brown', 'Hackney'),
		('reg004', 'Carol', 'White', 'Islington'),
		('reg005', 'Pierre', 'Armel', 'Wandsworth');
        
INSERT INTO Vehicle (VehicleReg, VehicleMake, VehicleModel, MemberID)
VALUES ('QR07 PQR', 'Bentley', 'B Cont GT', 'reg001'),
		('MN04 UVW', 'Jaguar', 'J XF', 'reg002'),
        ('BC21 KLM', 'Land Rover', 'L Rover D', 'reg004'),
        ('DE17 NOP', 'Lotus', 'L Elise', 'reg003'),
        ('EF59 XYZ', 'A Martin', 'A Martin D', 'reg001'),
        ('JK02 HFG', 'McLaren', 'McL570S', 'reg005'),
        ('LM68 HJK', 'Mini', 'Mini Cl', 'reg003'),
        ('AB12 CDE', 'Roll-Royce', 'R-Royce C', 'reg005');
	
INSERT INTO Engineer (EngineerFName, EngineerLName)
VALUES	('Oliver', 'Jones'),
		('Jacob', 'Davies'),
		('Charlie', 'Taylor');

INSERT INTO Breakdown 
VALUES	(BreakdownID, BreakdownDATE, BreakdownTIME, BreakdownLoc, VehicleReg, EngineerID),
		(1, '2024-01-01', '08:14:35', 'Hyde Park', 'QR07 PQR', '1'),
        (2,'2024-03-02', '17:42:08', 'Trafalgar Square', 'MN04 UVW', '2'),
        (3,'2024-04-04', '22:19:53', 'Covent Garden', 'BC21 KLM', '3'),
        (4,'2024-04-04', '03:25:14', 'Covent Garden', 'DE17 NOP', '2'),
        (5,'2024-06-04', '14:08:47', 'Camden Market', 'EF59 XYZ', '1'),
        (6,'2024-06-15', '11:57:29', 'Greenwich Park', 'JK02 HFG', '3'),
        (7,'2024-07-12', '06:33:22', 'Borough Market', 'LM68 HJK', '2'),
        (8,'2024-07-26', '19:44:10', 'Kensington Gardens', 'AB12 CDE', '1'),
        (9,'2024-08-13', '12:26:18', 'Soho', 'QR07 PQR', '2'),
        (10,'2024-09-17', '05:38:02', 'The Shard', 'DE17 NOP', '3'),
		(11,'2024-10-20', '10:47:56', 'London Eye', 'QR07 PQR', '1'),
        (12,'2024-12-22', '16:53:41', 'Tower Bridge', 'BC21 KLM', '2');

-- ------------------------------------------------------------------- TASK 3: Perform Queries -----------------------------------
-- 1. Members Living at a specific location
SELECT CONCAT(MemberFName, ' ', MemberLName) AS 'Members', MemberLoc AS 'Location' FROM Member WHERE MemberLoc LIKE 'G%CH';

-- 2. Cars of a specific make
SELECT VehicleModel AS 'Vehicle Model' FROM Vehicle WHERE VehicleMake LIKE 'M_L%';

-- 3. Engineers working for the company
SELECT COUNT(*) AS 'Employees' FROM Engineer;

-- 4. Number of members registrated with the company
SELECT COUNT(*) AS 'Members' FROM Member;

-- 5. Breakdowns after July
SELECT BreakdownID AS 'Breakdowns IDs' FROM Breakdown WHERE YEAR(BreakdownDATE)=2024 AND MONTH(BreakdownDATE)>7;

-- 6. Breakdowns between June and September
SELECT BreakdownID AS 'Breakdowns IDs' FROM Breakdown WHERE YEAR(BreakdownDATE)=2024 AND MONTH(BreakdownDATE) BETWEEN 6 AND 9;

-- 7. Number of time a particular vehicle has broken down
SELECT COUNT(VehicleReg) AS 'Breakdowns count' FROM Breakdown GROUP BY VehicleReg;

-- 8. Number of vehicle that have broken down more than once
SELECT COUNT(VehicleReg) AS 'Breakdowns count' FROM Breakdown  GROUP BY VehicleReg HAVING COUNT(*) > 1;

-- ------------------------------------------------------------------- TASK 4: Perform Advanced Queries -----------------------------------
-- 1. Vehicle own by a specific member
SELECT VehicleModel, CONCAT(MemberFName, ' ', MemberLName) AS 'Members' FROM Vehicle AS v LEFT JOIN Member AS m ON v.MemberID=m.MemberID;

-- 2. Nomber of vehicle own by each member from highest to lowest
SELECT CONCAT(MemberFName, ' ', MemberLName) AS 'Members', COUNT(*) AS 'Number of vehicle' 
FROM Vehicle AS v LEFT JOIN Member AS m 
	ON v.MemberID=m.MemberID 
GROUP BY CONCAT(MemberFName, ' ', MemberLName) 
ORDER BY COUNT(*) DESC;

-- 3. Vehicles that have broken down in a specific location including owner details
SELECT m.MemberID, v.VehicleReg, BreakdownLoc 
FROM Breakdown AS b 
INNER JOIN Vehicle AS v 
	ON b.VehicleReg=v.VehicleReg
INNER JOIN Member AS m
	ON v.memberID=m.memberID
WHERE BreakdownLoc = 'Greenwich Park'; 

-- 4. List of all vreakdowns along with member and engineer details between two dates
SELECT b.BreakdownID, m.MemberID, e.EngineerID
FROM Breakdown AS b
INNER JOIN Engineer AS e 
	ON b.EngineerID=e.EngineerID
INNER JOIN Vehicle AS v
	ON b.VehicleReg=v.VehicleReg
INNER JOIN Member AS m
	ON v.MemberID=m.MemberID
WHERE BreakdownDATE BETWEEN '2024-06-04' AND '2024-09-17';

-- 5. Three additional meaningful queries for the Breakdown Company
-- 5.1 List The member and location where a breakdown occured including the time and Engineer in charge
SELECT CONCAT(MemberFName,' ',MemberLName) AS 'Member', VehicleModel, BreakdownTIME, CONCAT(EngineerFName,' ', EngineerLName) AS 'Engineer'
FROM Breakdown AS b
INNER JOIN Vehicle AS v
	ON b.VehicleReg=v.VehicleReg
INNER JOIN Member AS m
	ON v.MemberID=m.MemberID
INNER JOIN Engineer as e
	ON b.EngineerID=e.EngineerID
WHERE BreakdownLoc LIKE 'G%';

-- 5.2 Select Engineers that worked on the day on more than 2 breakdowns occured
-- ----------------------------- Needs disabling ONLY_FULL_GROUP_BY mode to run the below query ---------------------------------------------------------
-- SELECT e.EngineerID, CONCAT(EngineerFName,' ', EngineerLName) AS 'Engineer in Charge', b.BreakdownID AS 'Breakdown ID', b.BreakdownDATE
-- FROM Breakdown AS b
-- INNER JOIN Engineer AS e
-- 	ON b.EngineerID=e.EngineerID
-- GROUP BY b.BreakdownDATE
-- HAVING COUNT(b.BreakdownDATE) > 1;

-- 5.3 Select Engineers that worked on car broken date and Locations ending with 'ark'
SELECT e.EngineerID AS 'Engineers', BreakdownLoc AS 'Locations', BreakdownDATE
FROM Breakdown AS b
INNER JOIN Engineer AS e
	ON e.EngineerID=b.EngineerID
WHERE b.BreakdownLoc LIKE '%_ark';

-- ------------------------------------------------------------------- TASK 5: Research SQL Functions -----------------------------------

-- ------------------------------------------------------------------- TASK 6: Update and Delete Records -----------------------------------

-- 6.1 Update
UPDATE Member 
SET MemberLName = 'Smith', MemberLoc = 'Lewisham'
WHERE MemberID = 'reg001';

UPDATE Vehicle
SET VehicleMake = 'Toyota'
WHERE VehicleModel = 'Mini' AND MemberID = 'reg003';

UPDATE Breakdown AS b
INNER JOIN Engineer AS e 
	ON b.EngineerID=e.EngineerID
SET BreakdownDATE = CURDATE()
WHERE e.EngineerID = 2;

-- 6.2 Delete
DESCRIBE Member;
DESCRIBE Vehicle;
SHOW CREATE TABLE Vehicle;
ALTER TABLE Vehicle DROP FOREIGN KEY vehicle_ibfk_1;

ALTER TABLE Vehicle 
ADD CONSTRAINT vehicle_ibfk_1
FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
ON DELETE CASCADE;

SHOW CREATE TABLE Breakdown;
ALTER TABLE Breakdown DROP FOREIGN KEY breakdown_ibfk_1;

ALTER TABLE Breakdown
ADD CONSTRAINT breakdown_ibfk_1
FOREIGN KEY (VehicleReg) REFERENCES Vehicle(VehicleReg)
ON DELETE CASCADE;

DELETE FROM Member
WHERE MemberID = 'reg004'



