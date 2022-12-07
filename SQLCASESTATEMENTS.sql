--Case Statements
SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
	WHEN Age BETWEEN 27 AND 30 THEN 'Young'
	ELSE 'Baby'
END
FROM dbo.EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age

--Inner Join Employee Demographics and Employee Salary Tables
SELECT *
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--Calculate different raise amounts for different job titles
SELECT FirstName, LastName, JobTitle, Salary,
	CASE
		WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
		WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
		WHEN JobTitle = 'HR' THEN Salary + (Salary * .03)
		ELSE Salary + (Salary * .03)
	END As SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID



