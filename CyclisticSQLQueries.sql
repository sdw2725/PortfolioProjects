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

--Add ride length column, convert to datetime then int in order to calcuate averages
ALTER TABLE ride_data
Add ride_length time

UPDATE ride_data
SET ride_length = (ended_at - started_at)

UPDATE ride_data
SET ride_length = CONVERT(datetime,ride_length)

--add month column
ALTER TABLE ride_data
Add month char 

UPDATE ride_data
SET month = DATENAME(MONTH, started_at)

--add weekday column
ALTER TABLE ride_data
ADD weekday nvarchar

UPDATE ride_data
SET weekday = DATENAME(WEEKDAY, started_at)

--View 0:00 minute rides
Select ride_length
FROM ride_data
WHERE ride_length = '00:00:00.0000000'

--Delete 0:00 minute rides
DELETE 
FROM ride_data
WHERE ride_length = '00:00:00.0000000'

--Find totals for members and casual riders
SELECT Count(ride_id) Member_Rides, member_casual
FROM ride_data
WHERE member_casual = 'member'
GROUP BY member_casual
SELECT Count(ride_id) Casual_Rides, member_casual
FROM ride_data
WHERE member_casual = 'casual'
GROUP BY member_casual

--Find totals by season
SELECT Count(ride_id) Summer, member_casual
FROM ride_data
WHERE member_casual = 'casual' AND month = 'June'
OR member_casual = 'casual' AND month = 'July'
OR member_casual = 'casual' AND month = 'July'
GROUP BY member_casual

SELECT Count(ride_id) Summer, member_casual
FROM ride_data
WHERE member_casual = 'member' AND month = 'June'
OR member_casual = 'member' AND month = 'July'
OR member_casual = 'member' AND month = 'July'
GROUP BY member_casual

SELECT Count(ride_id) Fall, member_casual
FROM ride_data
WHERE member_casual = 'casual' AND month = 'August'
OR member_casual = 'casual' AND month = 'September'
OR member_casual = 'casual' AND month = 'October'
GROUP BY member_casual

SELECT Count(ride_id) Fall, member_casual
FROM ride_data
WHERE member_casual = 'member' AND month = 'August'
OR member_casual = 'member' AND month = 'September'
OR member_casual = 'member' AND month = 'October'
GROUP BY member_casual

SELECT Count(ride_id) Winter, member_casual
FROM ride_data
WHERE member_casual = 'casual' AND month = 'December'
OR member_casual = 'casual' AND month = 'January'
OR member_casual = 'casual' AND month = 'February'
GROUP BY member_casual

SELECT Count(ride_id) Winter, member_casual
FROM ride_data
WHERE member_casual = 'member' AND month = 'December'
OR member_casual = 'member' AND month = 'January'
OR member_casual = 'member' AND month = 'February'
GROUP BY member_casual

SELECT Count(ride_id) Spring, member_casual
FROM ride_data
WHERE member_casual = 'casual' AND month = 'March'
OR member_casual = 'casual' AND month = 'April'
OR member_casual = 'casual' AND month = 'May'
GROUP BY member_casual

SELECT Count(ride_id) Spring, member_casual
FROM ride_data
WHERE member_casual = 'member' AND month = 'March'
OR member_casual = 'member' AND month = 'April'
OR member_casual = 'member' AND month = 'May'
GROUP BY member_casual

select top 5 *
from ride_data

--Find most popular stations for casual riders
SELECT TOP 5 count(start_station_name) NumberofRides, start_station_name
FROM ride_data
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY NumberofRides desc


--Create View for visualization #1
Create View RideLengthWeekday as
SELECT ride_id, member_casual, ride_length, month, weekday
FROM ride_data
ORDER BY member_casual

SELECT *
FROM RideLengthWeekday










