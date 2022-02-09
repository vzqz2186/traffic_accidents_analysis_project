/*
Nashville Metro car accidents project

     Author: Daniel Vazquez
Description: This project's purpose is to do some data cleaning and data
             exploration of public records regarding car accidents. The data 
             set used for this project is the Traffic Accidents data set obtained 
             from the Nashville Open Data Portal. A public data set containing 
			 accident reports ny the Nashville Metro Police Department across the
			 Nashville metropolitan area.
			 
             The process is as follows:
			   1. Data Cleaning
			      a. Separate 'date_and_time' into two separate fields
				  b. Drop unnecessary data
					 - RPA field
					 - mapped_location field
				  c. Fix entries in 'precinct' column
				  d. Populate 'property_damage' column
			   2. Data Exploration
			      a. Accidents reported per city
				  b. Accidents reported per police precinct
				  c. Breakdown of accidents per month
				  d. Frequency of different accident types
				  e. Injuries and fatalities per year breakdown
                  f. Officers with more responses to traffic accidents
                  g. Under what weather conditions where accidents become
				     more common?

	 Source: https://data.nashville.gov/Police/Traffic-Accidents/6v6w-hpcw/data

*/
----------------------------------------------------------------------------- 80
-- USE car_accidents_project;

-- Good ol' "view all"
SELECT * FROM traffic_accidents
ORDER BY accident_date, accident_time ASC;

-- 1. Data Cleaning
----------------------------------------------------------------------------- 80

-- a. Separate 'date_and_time' into two separate fields.

-- Separate date_and_time column into a date and a time columns
ALTER TABLE traffic_accidents
ADD accident_date date, accident_time time(0);

-- Populate new date and time fields
UPDATE traffic_accidents
SET accident_date = date_and_time;
UPDATE traffic_accidents
SET accident_time = date_and_time;

-- b. Drop unnecessary data

-- Drop RPA and mapped_location field, as well as original 'date_and_time' field
ALTER TABLE traffic_accidents
DROP COLUMN mapped_location, RPA, date_and_time;

-- c. Fix entries in 'precinct' column

-- List all different precincts
SELECT DISTINCT(precinct) FROM traffic_accidents;
-- Update precinct names that got cut out.
UPDATE traffic_accidents
 SET precinct = CASE WHEN precinct = 'CENTRA' THEN 'CENTRAL'
                     WHEN precinct = 'HERMIT' THEN 'HERMITAGE'
                     WHEN precinct = 'MIDTOW' THEN 'MIDTOWN HILLS'
                     WHEN precinct = 'MADISO' THEN 'MADISON'
                     ELSE precinct
					END
WHERE precinct IN ('CENTRA', 'HERMIT', 'MIDTOW', 'MADISO');

-- d. Populate 'property_damage' column

-- Data set only signals when there was property damage involved in the 
-- accident, so all the null values in the column represent no property damage. 
-- The null values will be replaced by a zero to represent FALSE.
UPDATE traffic_accidents
SET property_damage = ISNULL(property_damage, 0);

-- 2. Data Exploration
----------------------------------------------------------------------------- 80

-- a. Accidents per city breakdown

-- Number of accidents per city during 2021
SELECT city, COUNT(city) AS crash_qty
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
GROUP BY city
ORDER BY crash_qty DESC;

-- Time and location of traffic accidents in 2021
SELECT accident_number, accident_date, accident_time, precinct, latitude, longitude
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
ORDER BY accident_date, accident_time ASC;

-- b. Accidents per precinct

SELECT precinct, COUNT(precinct) AS crash_qty
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
      AND precinct IS NOT NULL
GROUP BY precinct
ORDER BY crash_qty DESC;


-- c. Monthly distribution of car accidents for the year of 2021, ordered by
--    number of accidents.

SELECT DATENAME(month, accident_date) AS month, COUNT(*) AS number_of_accidents
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
GROUP BY DATENAME(month, accident_date)
ORDER BY number_of_accidents DESC;


-- d. Accident type distribution

SELECT collision_type_description, COUNT(collision_type_description) AS qty
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
      AND collision_type_description IS NOT NULL
GROUP BY collision_type_description
ORDER BY qty DESC;

-- e. Injuries and fatalities per year

-- Breakdown per year
SELECT YEAR(accident_date) AS calendar_year,
       COUNT(accident_number) AS number_of_accidents,
       SUM(number_of_injuries) AS number_of_injuries,
       SUM(number_of_fatalities) AS number_of_fatalities
FROM traffic_accidents
GROUP BY YEAR(accident_date)
ORDER BY calendar_year;

-- Breakdown per month for 2021
SELECT DATENAME(month, accident_date) AS calendar_month,
       COUNT(accident_number) AS number_of_accidents,
       SUM(number_of_injuries) AS number_of_injuries,
       SUM(number_of_fatalities) AS number_of_fatalities
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
GROUP BY DATENAME(month, accident_date)
ORDER BY calendar_month;

-- f. Officers with more responses to traffic accidents

SELECT TOP 10 CAST(reporting_officer AS nvarchar(6)) AS reporting_officer,
       COUNT(reporting_officer) AS qty
FROM traffic_accidents
WHERE accident_date >= '2021-01-01' AND accident_date < '2022-01-01'
GROUP BY reporting_officer
ORDER BY qty DESC;


-- g. Under what weather and lighting conditions were accidents more common?

-- Probability of accident under various weather conditions
DROP TABLE IF EXISTS #weather -- Drop temp if it already exists
-- CReate a temp table to make the calculations
SELECT DISTINCT(weather_description) AS weather, COUNT(*) AS qty
INTO #weather
FROM traffic_accidents
GROUP BY weather_description;

SELECT weather, qty,
      (qty*1.0/(SELECT SUM(qty) FROM #weather)) AS probability_percent
FROM #weather
ORDER BY probability_percent DESC;

-- Probability of accident under various lighting conditions
DROP TABLE IF EXISTS #illumination -- Drop temp if it already exists
-- Create a temp table to make the calculations
SELECT DISTINCT(illumination_description) AS illumination, COUNT(*) AS qty
INTO #illumination
FROM traffic_accidents
GROUP BY illumination_description;

SELECT illumination, qty,
      (qty*1.0/(SELECT SUM(qty) FROM #illumination)) AS probability_percent
FROM #illumination
ORDER BY probability_percent DESC;


SELECT property_damage, COUNT(property_damage) AS qty
FROM traffic_accidents
GROUP BY property_damage;

SELECT hit_and_run, COUNT(hit_and_run) AS qty
FROM traffic_accidents
WHERE hit_and_run IS NOT NULL
GROUP BY hit_and_run;