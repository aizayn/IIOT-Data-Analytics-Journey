
-- =====================================================
-- PROJECT: OTT MEDIA AND ENTERTAINMENT
-- BOX OFFICE SQL ANALYSIS
-- Database: ott_media_and_entertainment
-- Table: boxoffice
-- =====================================================

USE ott_media_and_entertainment;

-- 1. Total records
SELECT COUNT(*) AS Total_Records
FROM boxoffice;

-- 2. Top 10 highest revenue titles
SELECT Title, Industry, Revenue_USD, Budget_USD, Profit_USD
FROM boxoffice
ORDER BY Revenue_USD DESC
LIMIT 10;

-- 3. Repeated title names
SELECT Title, COUNT(*) AS Total
FROM boxoffice
GROUP BY Title
HAVING COUNT(*) > 1
ORDER BY Total DESC
LIMIT 10;

-- 4. Titanic records
SELECT Title, Industry, Year, Revenue_USD, COUNT(*) AS Total
FROM boxoffice
WHERE Title = 'Titanic'
GROUP BY Title, Industry, Year, Revenue_USD;

-- 5. Revenue by industry
SELECT Industry,
       COUNT(*) AS Total_Titles,
       ROUND(SUM(Revenue_USD), 2) AS Total_Revenue_USD
FROM boxoffice
GROUP BY Industry
ORDER BY Total_Revenue_USD DESC;

-- 6. Average score by industry
SELECT Industry,
       COUNT(Score) AS Scored_Titles,
       ROUND(AVG(Score), 2) AS Average_Score
FROM boxoffice
GROUP BY Industry;

-- 7. Average ROI by industry
SELECT Industry,
       ROUND(AVG(ROI_x), 2) AS Average_ROI
FROM boxoffice
GROUP BY Industry;

-- 8. Adjusted average ROI (excluding extreme values)
SELECT Industry,
       ROUND(AVG(ROI_x), 2) AS Adjusted_Average_ROI,
       COUNT(*) AS Records_Used
FROM boxoffice
WHERE ROI_x <= 1000
GROUP BY Industry;

-- 9. Suspicious ROI records
SELECT Title, Industry, Budget_USD, Revenue_USD, ROI_x
FROM boxoffice
WHERE ROI_x > 1000
ORDER BY ROI_x DESC
LIMIT 10;

-- 10. Count suspicious ROI records
SELECT Industry, COUNT(*) AS Suspicious_Records
FROM boxoffice
WHERE ROI_x > 1000
GROUP BY Industry;

-- 11. Top 10 most profitable titles
SELECT Title, Industry, Revenue_USD, Budget_USD, Profit_USD
FROM boxoffice
ORDER BY Profit_USD DESC
LIMIT 10;

-- 12. Total and average profit by industry
SELECT Industry,
       COUNT(*) AS Total_Titles,
       ROUND(SUM(Profit_USD), 2) AS Total_Profit_USD,
       ROUND(AVG(Profit_USD), 2) AS Average_Profit_USD
FROM boxoffice
GROUP BY Industry;

-- 13. Profitable vs loss-making titles
SELECT Industry,
       CASE
           WHEN Profit_USD > 0 THEN 'Profitable'
           WHEN Profit_USD < 0 THEN 'Loss'
           ELSE 'Break Even'
       END AS Profit_Status,
       COUNT(*) AS Total_Titles
FROM boxoffice
GROUP BY Industry, Profit_Status
ORDER BY Industry, Profit_Status;

-- 14. Top 10 highest ROI titles (filtered)
SELECT Title, Industry, Budget_USD, Revenue_USD, ROI_x
FROM boxoffice
WHERE ROI_x <= 1000
ORDER BY ROI_x DESC
LIMIT 10;

-- 15. Average profit by genre
SELECT Genre,
       COUNT(*) AS Total_Titles,
       ROUND(AVG(Profit_USD), 2) AS Average_Profit_USD
FROM boxoffice
GROUP BY Genre
ORDER BY Average_Profit_USD DESC
LIMIT 10;

-- 16. Total revenue by genre
SELECT Genre,
       COUNT(*) AS Total_Titles,
       ROUND(SUM(Revenue_USD), 2) AS Total_Revenue_USD
FROM boxoffice
GROUP BY Genre
ORDER BY Total_Revenue_USD DESC
LIMIT 10;

-- 17. Revenue by release year
SELECT Year,
       COUNT(*) AS Total_Titles,
       ROUND(SUM(Revenue_USD), 2) AS Total_Revenue_USD
FROM boxoffice
GROUP BY Year
ORDER BY Total_Revenue_USD DESC
LIMIT 10;

-- 18. Average score and highest score by industry
SELECT Industry,
       COUNT(Score) AS Scored_Titles,
       ROUND(AVG(Score), 2) AS Average_Score,
       MAX(Score) AS Highest_Score
FROM boxoffice
GROUP BY Industry
ORDER BY Average_Score DESC;

-- 19. Top 10 highest-scored titles
SELECT Title, Industry, Year, Genre, Score
FROM boxoffice
ORDER BY Score DESC
LIMIT 10;

-- 20. Genre distribution by industry
SELECT Industry, Genre, COUNT(*) AS Total_Titles
FROM boxoffice
GROUP BY Industry, Genre
ORDER BY Industry, Total_Titles DESC;

-- 21. Missing value check
SELECT COUNT(*) AS Total_Rows,
       SUM(Title IS NULL) AS Missing_Title,
       SUM(Industry IS NULL) AS Missing_Industry,
       SUM(Genre IS NULL) AS Missing_Genre,
       SUM(Year IS NULL) AS Missing_Year,
       SUM(Revenue_USD IS NULL) AS Missing_Revenue,
       SUM(Budget_USD IS NULL) AS Missing_Budget,
       SUM(Profit_USD IS NULL) AS Missing_Profit,
       SUM(Score IS NULL) AS Missing_Score
FROM boxoffice;

-- 22. Check repeated title, industry and year combinations
SELECT Title, Industry, Year,
       COUNT(*) AS Duplicate_Count
FROM boxoffice
GROUP BY Title, Industry, Year
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC
LIMIT 10;

-- 23. Inspect King Kong (1933)
SELECT *
FROM boxoffice
WHERE Title = 'King Kong'
  AND Industry = 'Hollywood'
  AND Year = 1933;

-- 24. Count repeated groups and their records
SELECT COUNT(*) AS Repeated_Groups,
       SUM(Duplicate_Count) AS Total_Records_In_Groups
FROM (
    SELECT COUNT(*) AS Duplicate_Count
    FROM boxoffice
    GROUP BY Title, Industry, Year
    HAVING COUNT(*) > 1
) AS duplicates;

-- 25. Dataset overview
SELECT COUNT(DISTINCT Title) AS Unique_Titles,
       COUNT(DISTINCT Industry) AS Total_Industries,
       COUNT(DISTINCT Genre) AS Total_Genres,
       MIN(Year) AS Earliest_Year,
       MAX(Year) AS Latest_Year
FROM boxoffice;

-- 26. Revenue by country
SELECT Country_Code,
       COUNT(*) AS Total_Titles,
       ROUND(SUM(Revenue_USD), 2) AS Total_Revenue_USD
FROM boxoffice
GROUP BY Country_Code
ORDER BY Total_Revenue_USD DESC
LIMIT 10;

-- =====================================================
-- END OF BOX OFFICE ANALYSIS
-- =====================================================
