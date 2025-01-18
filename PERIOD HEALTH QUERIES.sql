
-- 1. Categorizing Cycles as “Regular” vs. “Irregular.”
SELECT User_ID, 
       Cycle_Length, 
       CASE
         WHEN Cycle_Length BETWEEN 25 AND 35 THEN 'Regular' 
         ELSE 'Irregular' 
       END AS Cycle_Category
FROM dataset;

-- 2. Grouping Ages into Predefined Age Brackets
SELECT User_ID, 
       Age, 
       CASE 
         WHEN Age < 25 THEN '<25' 
         WHEN Age BETWEEN 25 AND 34 THEN '25-34' 
         WHEN Age BETWEEN 35 AND 44 THEN '35-44' 
         ELSE '45+' 
       END AS Age_Bracket
FROM dataset;

-- 3. Identifying the Most Common Symptom
SELECT Symptoms, 
       COUNT(*) AS Symptom_Count
FROM dataset
GROUP BY Symptoms
ORDER BY Symptom_Count DESC
LIMIT 1;

-- 4. Calculating Percentage Distribution of Regular vs. Irregular Cycles
SELECT Cycle_Category, 
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Percentage
FROM (
    SELECT CASE 
             WHEN Cycle_Length BETWEEN 25 AND 35 THEN 'Regular' 
             ELSE 'Irregular' 
           END AS Cycle_Category
    FROM dataset
) AS Cycles
GROUP BY Cycle_Category;

-- 5. Calculating Average Period Duration and Cycle Length by Age Group
SELECT Age_Bracket, 
       AVG(Period_Duration) AS Avg_Period_Duration, 
       AVG(Cycle_Length) AS Avg_Cycle_Length
FROM (
    SELECT User_ID, 
           Age, 
           Cycle_Length, 
           Period_Duration, 
           CASE 
             WHEN Age < 25 THEN '<25' 
             WHEN Age BETWEEN 25 AND 34 THEN '25-34' 
             WHEN Age BETWEEN 35 AND 44 THEN '35-44' 
             ELSE '45+' 
           END AS Age_Bracket
    FROM dataset
) AS GroupedData
GROUP BY Age_Bracket;

-- 6. Filtering Data Dynamically
SELECT * 
FROM dataset
WHERE Age BETWEEN 25 AND 34 
  AND Cycle_Length > 30;

-- 7. Aggregating Data for Visualizations
SELECT CASE 
         WHEN Cycle_Length BETWEEN 25 AND 35 THEN 'Regular' 
         ELSE 'Irregular' 
       END AS Cycle_Category, 
       COUNT(*) AS Total_Count
FROM dataset
GROUP BY Cycle_Category;

-- 8. Extracting KPI Metrics
SELECT 
    AVG(Cycle_Length) AS Avg_Cycle_Length, 
    (SELECT Symptoms 
     FROM dataset 
     GROUP BY Symptoms 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS Most_Common_Symptom
FROM dataset;
