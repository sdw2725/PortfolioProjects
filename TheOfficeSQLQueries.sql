--Show Employee Demographics Table
SELECT *
FROM EmployeeDemographics

--Show First Name only
SELECT FirstName
FROM EmployeeDemographics

--Show First Name and Last Name
SELECT FirstName, LastName
FROM EmployeeDemographics

--Show Top 5 Rows
SELECT Top 5 *
FROM EmployeeDemographics

--Show Genders
SELECT DISTINCT(Gender)
FROM EmployeeDemographics

--Count Non-Null Values in a Column, Name Column LastNameCount
SELECT COUNT(LastName) AS LastNameCount
FROM EmployeeDemographics

--Show the Highest Salary
SELECT MAX(Salary)
FROM EmployeeSalary

--Show the Lowest Salary
SELECT MIN(Salary)
FROM EmployeeSalary

--Show the Average Salary
SELECT AVG(Salary)
FROM EmployeeSalary

--Show First Name of Jim
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim'

--Show All First Names Except Jim
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'

--Show Employees Over the Age of 30
SELECT *
FROM EmployeeDemographics
WHERE Age > 30

--Show Males Age 30 or Over
SELECT *
FROM EmployeeDemographics
WHERE Age >= 30 AND Gender = 'Male'

--Show Employees 30 or Over OR Male
SELECT *
FROM EmployeeDemographics
WHERE Age >= 30 OR Gender = 'Male'

--Show Employees Whose Last Names Start With S
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%'

--Show Employees Who Have an S in Their Name
--Note % is called 'Wildcard'
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%'

--Show Employees Whose Last Names Start with S and end with ott
SELECT *
FROM EmployeeDemographics
WHERE LastName Like 'S%ott%'

--Show NULL First Names
SELECT *
FROM EmployeeDemographics
WHERE LastName is NULL

--Show NOT NULL First Names
SELECT *
FROM EmployeeDemographics
WHERE LastName is NOT NULL

--Show Jim, Michael, and Pam
SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Michael', 'Pam')

--Show Whole Table on Top, Gender and Count of Gender as Gender Count on Bottom
SELECT *
FROM EmployeeDemographics

SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender

--Show Gender, Age, and Count of Gender (ie. How many 29 y/o males etc)
SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender, Age

--Show Employees Over 31, Separated by Gender, Count for Each Gender and Order Ascending by Gender Count
SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY GenderCount 

--Show Employees Over 31, Separated by Gender, Count for Each Gender and Order Descending by Gender Count
SELECT Gender, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY GenderCount DESC 

--Show All Employees from Youngest to Oldest
SELECT *
FROM EmployeeDemographics
ORDER BY Age

--Show All Employees Male then Female, each from Youngest to Oldest
SELECT *
FROM EmployeeDemographics
ORDER BY Gender, Age

