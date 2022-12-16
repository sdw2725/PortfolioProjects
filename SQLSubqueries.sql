Select *
From EmployeeSalary

--Subquery in Select Statement (same result as above)
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) AS AvgSalary
From EmployeeSalary

--Subquery with Partition By
Select EmployeeID, Salary, AVG(Salary) over() as AvgSalary
From EmployeeSalary

--Group By (doesn't work)
Select EmployeeID, Salary, AVG(Salary) as AvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
Order By 1, 2

--Subquery in From Statement
Select EmployeeID, Salary, AVG(Salary) over() as AvgSalary
	From EmployeeSalary

Select a.EmployeeID, AvgSalary
From (Select EmployeeID, Salary, AVG(Salary) over() as AvgSalary
	From EmployeeSalary) a

--Subquery in Where Statement
Select EmployeeID, JobTitle, Salary
From EmployeeSalary
Where EmployeeID in (
	Select EmployeeID
	From EmployeeDemographics
	Where Age>30)