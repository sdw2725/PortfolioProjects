--View database
SELECT *
FROM dbo.sales_data_sample$

--View distinct column values in order to start getting an idea of what we may want to plot
SELECT DISTINCT Status
FROM dbo.sales_data_sample$
SELECT DISTINCT year_id 
FROM dbo.sales_data_sample$
SELECT DISTINCT Productline
FROM dbo.sales_data_sample$
SELECT DISTINCT Country
from dbo.sales_data_sample$
SELECT DISTINCT Dealsize
from dbo.sales_data_sample$
SELECT DISTINCT Territory
FROM dbo.sales_data_sample$

--ANALYSIS
--Finding the highest selling product line
SELECT PRODUCTLINE, SUM(sales) Revenue
FROM dbo.sales_data_sample$
GROUP BY PRODUCTLINE
Order by 2 desc

--Find the year with the most sales
SELECT YEAR_ID, SUM(sales) Revenue
FROM dbo.sales_data_sample$
GROUP BY YEAR_ID
Order by 2 desc

--What was the best sales month? How much was earned in that month?
SELECT Month_ID, sum(sales) Revenue, count(ORDERNUMBER) Frequency
FROM sales_data_sample$
WHERE Year_ID = 2004 -- change year to see the rest
GROUP BY MONTH_ID
ORDER BY 2 DESC

--November appears to be the busiest month, what product do they sell in November?
SELECT Month_ID, PRODUCTLINE, sum(sales) Revenue, count(ORDERNUMBER) Frequency
FROM sales_data_sample$
WHERE Year_ID = 2003 AND MONTH_ID = 11 -- change year to see the rest
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY 3 DESC

--Who is our best customer? (RFM Analysis)
SELECT
	CUSTOMERNAME,
	sum(Sales) MonetaryValue,
	avg(Sales) AvgMonetaryValue,
	count(ORDERNUMBER) Frequency,
	max(ORDERDATE) last_order_date,
	(SELECT max(ORDERDATE) FROM sales_data_sample$) max_order_date
	DATEDIFF(DD, max(ORDERDATE), (SELECT max(ORDERDATE) FROM sales_data_sample$)) Recency
FROM sales_data_sample$
GROUP BY CUSTOMERNAME

