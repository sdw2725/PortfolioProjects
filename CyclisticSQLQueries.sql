--Merge all 12 months of bike data into one new table using UNION
SELECT *
	INTO ride_data
FROM 
(
SELECT *
FROM Sept2021
UNION 
SELECT *
FROM Oct2021
UNION
SELECT *
FROM Nov2021
UNION 
SELECT *
FROM Dec2021
UNION
SELECT *
FROM Jan2022
UNION 
SELECT *
FROM Feb2022
UNION
SELECT *
FROM Mar2022
UNION 
SELECT *
FROM Apr2022
UNION
SELECT *
FROM May2022
UNION 
SELECT *
FROM Jun2022
UNION
SELECT *
FROM Jul2022
UNION 
SELECT *
FROM Aug2022
) a

--View newly created table
SELECT *
FROM ride_data

--Add ride length column
ALTER TABLE ride_data
Add ride_length time

UPDATE ride_data
SET ride_length = (ended_at - started_at)

--add month column
ALTER TABLE ride_data
Add month char 

UPDATE ride_data
SET month = MONTH(started_at)

--add weekday column
ALTER TABLE ride_data
ADD weekday nvarchar

UPDATE ride_data
SET weekday = DATENAME(WEEKDAY, started_at)

--Create View for visualization
Create View RideDurationByWeekday as
SELECT member_casual, ride_length, month, weekday
FROM ride_data

SELECT *
FROM RideDurationByWeekday






