
--PHYSICAL THERAPY PROVIDERS PER CITY IN FL--

--Select all data from the FL table
SELECT *
FROM dbo.fl$

--Show all distinct cities in the FL table
SELECT DISTINCT([_Provider Business Practice Location Address City Name_])
FROM dbo.fl$
ORDER BY ([_Provider Business Practice Location Address City Name_])
--Several spelling errors revealed

--Show only Physical Therapist data in FL table (PT taxonomy codes previously determined)
SELECT _NPI_, [_Provider Organization Name (Legal Business Name)_], [_Provider Last Name (Legal Name)_], [_Provider First Name_], 
[_Provider First Line Business Practice Location Address_], [_Provider Second Line Business Practice Location Address_], 
[_Provider Business Practice Location Address City Name_], [_Provider Business Practice Location Address State Name_]
FROM dbo.fl$
WHERE [_Healthcare Provider Taxonomy Code_1_] = '213E00000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '226300000X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '225100000X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251C2600X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251E1300X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251E1200X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251G0304X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251H1200X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251H1300X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251N0400X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251X0800X'
OR [_Healthcare Provider Taxonomy Code_1_] = '2251P0200X'
OR [_Healthcare Provider Taxonomy Code_1_] = '2251S0007X'
OR [_Healthcare Provider Taxonomy Code_1_] = '225200000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '251E00000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '261QP2000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '273Y00000X'
ORDER BY [_Provider Business Practice Location Address City Name_]

--Create a temp table with the data we will be working with
DROP TABLE IF EXISTS FL_PT
SELECT _NPI_, [_Provider Organization Name (Legal Business Name)_], [_Provider Last Name (Legal Name)_], [_Provider First Name_], 
[_Provider First Line Business Practice Location Address_], [_Provider Second Line Business Practice Location Address_], 
[_Provider Business Practice Location Address City Name_], [_Provider Business Practice Location Address State Name_]
INTO FL_PT
FROM dbo.fl$
WHERE [_Healthcare Provider Taxonomy Code_1_] = '213E00000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '226300000X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '225100000X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251C2600X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251E1300X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251E1200X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251G0304X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251H1200X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251H1300X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251N0400X' 
OR [_Healthcare Provider Taxonomy Code_1_] = '2251X0800X'
OR [_Healthcare Provider Taxonomy Code_1_] = '2251P0200X'
OR [_Healthcare Provider Taxonomy Code_1_] = '2251S0007X'
OR [_Healthcare Provider Taxonomy Code_1_] = '225200000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '251E00000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '261QP2000X'
OR [_Healthcare Provider Taxonomy Code_1_] = '273Y00000X'
ORDER BY [_Provider Business Practice Location Address City Name_]

--Show temp table
SELECT *
FROM FL_PT

--Show all distinct cities in temp table to see which need to be corrected
SELECT DISTINCT([_Provider Business Practice Location Address City Name_])
FROM FL_PT
ORDER BY ([_Provider Business Practice Location Address City Name_])

--Remove periods and commas in city names
UPDATE fl$
SET [_Provider Business Practice Location Address City Name_] = ' '
WHERE [_Provider Business Practice Location Address City Name_] = '.'
SET [_Provider Business Practice Location Address City Name_] = ' '
WHERE [_Provider Business Practice Location Address City Name_] = ','

--Correct misspellings
UPDATE fl$
SET [_Provider Business Practice Location Address City Name_] = 'SAINT PETERSBURG'
WHERE [_Provider Business Practice Location Address City Name_] = 'STPETERSBURG'  
UPDATE fl$
SET [_Provider Business Practice Location Address City Name_] = 'SAINT PETERSBURG'
WHERE [_Provider Business Practice Location Address City Name_] = 'ST PETERBURG'
UPDATE fl$
SET [_Provider Business Practice Location Address City Name_] = 'SAINT PETERSBURG'
WHERE [_Provider Business Practice Location Address City Name_] = 'STPETERSBURG'
--...repeated for all misspellings

--Show a count of physical therapy providers per city
SELECT [_Provider Business Practice Location Address City Name_] as [City],
COUNT ([_NPI_]) as [Total Providers]
FROM FL_PT
GROUP BY [_Provider Business Practice Location Address City Name_]
ORDER BY 2 desc

--Show number of providers at each clinic
SELECT [_Provider First Line Business Practice Location Address_] as [Address],
COUNT ([_NPI_]) as [Total Providers]
FROM FL_PT
GROUP BY [_Provider First Line Business Practice Location Address_]
ORDER BY 2 desc

--Do some PT's work at multiple locations?
SELECT [_NPI_] as [NPI],
COUNT ([_Provider First Line Business Practice Location Address_]) as Locations
FROM FL_PT
GROUP BY _NPI_
HAVING COUNT ([_Provider First Line Business Practice Location Address_]) > '1'
--Yes, 539 work at 2

--Select all data from FL Population table
SELECT *
FROM dbo.FL_Population

--Select data we will need from Population table
SELECT [County and City], [April 2020 Census Population]
FROM dbo.FL_Population

--Join Population table with physical therapy provider per city count
SELECT *
FROM FL_PT
JOIN dbo.FL_Population
on FL_PT.[_Provider Business Practice Location Address City Name_] = dbo.FL_Population.[County and City]

--Create temp table to isolate data needed for provider to population ratio
DROP TABLE IF EXISTS FL_Pop_Ratio
SELECT FL_PT.[_Provider Business Practice Location Address City Name_] as [City], FL_Population.[April 2020 Census Population],
COUNT ([_NPI_]) as [Total Providers]
INTO FL_Pop_Ratio
FROM FL_PT
JOIN dbo.FL_Population
on FL_PT.[_Provider Business Practice Location Address City Name_] = dbo.FL_Population.[County and City]
GROUP BY [_Provider Business Practice Location Address City Name_], FL_Population.[April 2020 Census Population]
ORDER BY 2 desc

--Create view with provider to population ratio
CREATE VIEW Provider_Population_Ratio as
SELECT City, [Total Providers] / [April 2020 Census Population] as [Provider:Population Ratio]
FROM FL_Pop_Ratio

--Check newly created view
SELECT *
FROM Provider_Population_Ratio
ORDER BY 2









