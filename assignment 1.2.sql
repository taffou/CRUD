CREATE DATABASE IF NOT EXISTS Company_UK;
USE Company_UK;

CREATE TABLE IF NOT EXISTS Branches (
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(50), 
    city VARCHAR(50),
    salary int
);

INSERT INTO Branches (name, city, salary)
VALUES ("Albion Innovations Ltd", "London", "40000"),
		("Thames Tech Solutions Ltd", "Manchester", "26000"),
        ("Britannia Ventures Ltd", "Birmingham", "38000"),
        ("Sovereign Services Ltd", "Glasgow", "40000"),
        ("London Legacy Enterprises Ltd", "Edinburgh", "40000"),
        ("Regal Resources Ltd", "Liverpool", "36000"),
        ("Oxfordshire Organics Ltd", "Bristol", "23000"),
        ("Crown Capital Ltd", "Leeds", "34000"),
        ("Celtic Commerce Ltd", "Sheffield", "33000"),
        ("Sterling Strategies Ltd", "Newcastle", "35000"),
        ("Highland Horizons Ltd", "Nottingham", "26000"),
        ("Cambridge Consulting Ltd", "Cardiff", "38000"),
        ("Windsor Wealth Management Ltd", "Belfast", "20000"),
        ("Beacon Bridge Ltd", "Southampton", "21000 "),
        ("Imperial Insights Ltd", "Coventry", "27000");
        
-- AVG function
SELECT AVG(salary) As 'Average salary' FROM Branches;

-- MAX function
SELECT MAX(salary) AS 'Highest salary' FROM Branches WHERE city LIKE '_O%';

-- MIN function
SELECT MIN(salary) AS 'Minimum salary' FROM Branches;

-- SUM function
SELECT SUM(salary) AS 'Total salary' FROM Branches;