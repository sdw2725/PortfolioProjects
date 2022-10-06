Select *
From CovidDeaths
Where continent is not null
Order by 3, 4

--Select *
--From CovidVaccinations
--Order by 3, 4

--Select the data we will be using

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Order by 1, 2

--Total Cases vs. Total Deaths
--Chance of dying if contracted Covid in the US

Select Location, date, total_cases, total_deaths, (Total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%states%'
Order by 1, 2

--Total Cases vs. Population
--Shows percentage of the population who has been infected with Covid

Select Location, date, total_cases, population, (Total_cases/population)*100 as InfectedPercentage
From CovidDeaths
Where location like '%states%'
Order by 1, 2

--Countries with highest infection rate

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected
From CovidDeaths
Group by Location, Population
Order by PercentPopulationInfected desc

--Countries with highest death count per population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by Location
Order by TotalDeathCount desc

--BREAKDOWN BY CONTINENT
--Continents with highest death count per population
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by continent
Order by TotalDeathCount desc

--GLOBAL NUMBERS
Select date, SUM(new_cases) as "total cases", SUM(cast(new_deaths as int)) as "total_deaths", SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From CovidDeaths
Where continent is not null
Group by date
Order by 1, 2


--Join vaccination and death tables
Select*
From coviddeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

--Total population vs vaccination
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast (vac.new_vaccinations as int)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From coviddeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

--Use CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
From coviddeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
and vac.continent is not null
)
Select*
From PopsvsVac


--TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric, 
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
From coviddeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated

--Creating Views to store data for visualizations

--Percent Population Vaccinated

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location,
	dea.date) as RollingPeopleVaccinated
From coviddeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null

Select *
From PercentPopulationVaccinated

--Total deaths

Create View GlobalDeaths as
Select date, SUM(new_cases) as "total cases", SUM(cast(new_deaths as int)) as "total_deaths", SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From CovidDeaths
Where continent is not null
Group by date

Select*
From GlobalDeaths

--Percent of population infected
Create View PercentInfected as
Select Location, date, total_cases, population, (Total_cases/population)*100 as InfectedPercentage
From CovidDeaths

Select*
From PercentInfected

Create View 



