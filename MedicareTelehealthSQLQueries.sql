--Select the data we will be working with
SELECT*
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
ORDER BY 3

--Show the top 5 rows
SELECT Top 5*
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
ORDER BY 3


--Show total telehealth visits and percent of enrollees who had a telehealth visit in 2021 by state
SELECT Year, Quarter, Bene_Geo_Desc, Total_Bene_Telehealth, Pct_Telehealth
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
AND Bene_Mdcd_Mdcr_Enrl_Stus = 'All'
AND Bene_Race_Desc = 'All'
AND Bene_Sex_Desc = 'All'
AND Bene_Mdcr_Entlmt_Stus = 'All'
AND Bene_Age_Desc = 'All'
AND Bene_Ruca_Desc = 'All'
ORDER BY 2

--Create views showing percentage of enrollees using telehealth visits by state for Q1, Q2, Q3, and Q4 2021
CREATE VIEW PercentVisitsByState2021Q1 as
SELECT Year, Quarter, Bene_Geo_Desc, Pct_Telehealth
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
AND Quarter = '1'
AND Bene_Mdcd_Mdcr_Enrl_Stus = 'All'
AND Bene_Race_Desc = 'All'
AND Bene_Sex_Desc = 'All'
AND Bene_Mdcr_Entlmt_Stus = 'All'
AND Bene_Age_Desc = 'All'
AND Bene_Ruca_Desc = 'All'
AND Bene_Geo_Desc <> 'National'

CREATE VIEW PercentVisitsByState2021Q2 as
SELECT Year, Quarter, Bene_Geo_Desc, Pct_Telehealth
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
AND Quarter = '2'
AND Bene_Mdcd_Mdcr_Enrl_Stus = 'All'
AND Bene_Race_Desc = 'All'
AND Bene_Sex_Desc = 'All'
AND Bene_Mdcr_Entlmt_Stus = 'All'
AND Bene_Age_Desc = 'All'
AND Bene_Ruca_Desc = 'All'
AND Bene_Geo_Desc <> 'National'

CREATE VIEW PercentVisitsByState2021Q3 as
SELECT Year, Quarter, Bene_Geo_Desc, Pct_Telehealth
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
AND Quarter = '3'
AND Bene_Mdcd_Mdcr_Enrl_Stus = 'All'
AND Bene_Race_Desc = 'All'
AND Bene_Sex_Desc = 'All'
AND Bene_Mdcr_Entlmt_Stus = 'All'
AND Bene_Age_Desc = 'All'
AND Bene_Ruca_Desc = 'All'
AND Bene_Geo_Desc <> 'National'

CREATE VIEW PercentVisitsByState2021Q4 as
SELECT Year, Quarter, Bene_Geo_Desc, Pct_Telehealth
FROM dbo.MedicareTelehealthTrends
WHERE Total_Bene_Telehealth IS NOT NULL
AND YEAR = '2021'
AND Quarter = '4'
AND Bene_Mdcd_Mdcr_Enrl_Stus = 'All'
AND Bene_Race_Desc = 'All'
AND Bene_Sex_Desc = 'All'
AND Bene_Mdcr_Entlmt_Stus = 'All'
AND Bene_Age_Desc = 'All'
AND Bene_Ruca_Desc = 'All'
AND Bene_Geo_Desc <> 'National'









