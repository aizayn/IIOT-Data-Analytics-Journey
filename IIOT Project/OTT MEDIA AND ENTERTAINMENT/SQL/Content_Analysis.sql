
-- =====================================================
-- PROJECT: OTT MEDIA AND ENTERTAINMENT
-- CONTENT ANALYSIS
-- Database: ott_media_and_entertainment
-- Table: content
-- =====================================================

USE ott_media_and_entertainment;

-- 1. Total content records
SELECT COUNT(*) AS Total_Content
FROM content;

-- 2. View sample records
SELECT *
FROM content
LIMIT 10;

-- 3. Content distribution by platform
SELECT Platform, COUNT(*) AS Total_Content
FROM content
GROUP BY Platform
ORDER BY Total_Content DESC;

-- 4. Movies vs TV Shows
SELECT Type, COUNT(*) AS Total
FROM content
GROUP BY Type
ORDER BY Total DESC;

-- 5. Top 10 genres
SELECT Genre, COUNT(*) AS Total
FROM content
GROUP BY Genre
ORDER BY Total DESC
LIMIT 10;

-- 6. Top 10 countries
SELECT Country, COUNT(*) AS Total
FROM content
GROUP BY Country
ORDER BY Total DESC
LIMIT 10;

-- 7. Content by release year
SELECT Release_Year, COUNT(*) AS Total
FROM content
GROUP BY Release_Year
ORDER BY Release_Year DESC
LIMIT 15;

-- 8. IMDb scores available by platform
SELECT Platform,
       COUNT(*) AS Total_Titles,
       COUNT(IMDb_Score) AS Titles_With_IMDb_Score
FROM content
GROUP BY Platform;

-- 9. Movies and TV Shows by platform
SELECT Platform, Type, COUNT(*) AS Total
FROM content
GROUP BY Platform, Type
ORDER BY Platform, Total DESC;

-- 10. Content distribution by maturity
SELECT Maturity, COUNT(*) AS Total
FROM content
GROUP BY Maturity
ORDER BY Total DESC;

-- 11. Content added by year
SELECT Year_Added, COUNT(*) AS Total
FROM content
GROUP BY Year_Added
ORDER BY Total DESC;

-- 12. Missing value check
SELECT COUNT(*) AS Total_Rows,
       SUM(Platform IS NULL) AS Missing_Platform,
       SUM(Title IS NULL) AS Missing_Title,
       SUM(Genre IS NULL) AS Missing_Genre,
       SUM(Country IS NULL) AS Missing_Country,
       SUM(Year_Added IS NULL) AS Missing_Year_Added
FROM content;

-- 13. Check duplicate platform and title combinations
SELECT Platform, Title, COUNT(*) AS Duplicate_Count
FROM content
GROUP BY Platform, Title
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC
LIMIT 10;

-- =====================================================
-- END OF CONTENT ANALYSIS
-- =====================================================
