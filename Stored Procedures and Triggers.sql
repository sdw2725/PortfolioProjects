--Create a stored procedure called Test to select all data from the table
CREATE PROCEDURE TEST
AS 
Select *
From EmployeeSalary


--Execute the test to ensure it works
EXEC TEST

--Create a stored procedure called Temp_Employee that will create a temp table
CREATE PROCEDURE Temp_Employee
AS
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
	ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #temp_employee

--Execute the stored procedure to make sure it worked
EXEC Temp_Employee



--Create a test table for triggers

SELECT EmployeeID, FirstName, LastName, Age, Gender INTO EmployeeTest
FROM EmployeeDemographics

CREATE TABLE EmployeeII(
	EmployeeID nchar(5),
	FirstName varchar(30),
	LastName varchar(30),
	Age numeric(2),
	Gender varchar(5)
	);

--Create an insert trigger
CREATE TRIGGER EmployeeTest_INSERT On EmployeeTest
	AFTER INSERT
AS 
BEGIN
	Set NOCOUNT ON
	DECLARE 



