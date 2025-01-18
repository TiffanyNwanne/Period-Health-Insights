# Period Health Insights Report

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Updated%20Period%20Tracking%20Dashboard.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Updated%20Period%20Tracking%20Dashboard.png)

## Objective

This project analyzes menstrual cycle data from Nigerian women aged 18-45 using PostGreSQL queries to extract key menstrual health metrics. The goal is to identify trends in cycle regularity, period duration, common symptoms, sleep patterns, and mood variations

## Key Metrics Extracted:

* **Percentage of regular vs. irregular cycles**

* **Average cycle length**

* **Average period duration**

* **Most common premenstrual symptoms**

## Dataset Overview

The dataset includes menstrual health records of Nigerian women aged 18-45, containing attributes such as:

- Age

- Cycle length

- Period duration

- Premenstrual symptoms

- Contraceptive use

- Mood variations

- Sleep duration

This data was analyzed using PostGreSQL queries and visualized in Excel

## Analysis Breakdown

### 1. Cycle Categorization: Regular vs. Irregular

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Categorizing%20Cycles%20as%20%E2%80%9CRegular%E2%80%9D%20vs.%20%E2%80%9CIrregular.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Categorizing%20Cycles%20as%20%E2%80%9CRegular%E2%80%9D%20vs.%20%E2%80%9CIrregular.png)

**Criteria:**

**Regular:** Cycle length between 25 and 35 days

**Irregular:** Any other value

**Query Logic:**
Classified cycles based on the above range using a CASE statement:

```sql
SELECT User_ID, 
       Cycle_Length, 
       CASE 
         WHEN Cycle_Length BETWEEN 25 AND 35 THEN 'Regular' 
         ELSE 'Irregular' 
       END AS Cycle_Category
FROM period_data;
```

**Findings:**

- **Regular:** Cycle length between 25-35 days

- **Irregular:** Cycle length outside this range

84% of cycles are Regular, 14% are Irregular

### 2. Age Grouping into Predefined Brackets

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Grouping%20Ages%20into%20Predefined%20Age%20Brackets.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Grouping%20Ages%20into%20Predefined%20Age%20Brackets.png)

**Age Brackets:**

<25

25-34

35-44

45+

**Query Logic:**

- Grouped users into predefined age brackets using conditional logic in a CASE statement:

```sql
SELECT User_ID, 
       Age, 
       CASE 
         WHEN Age < 25 THEN '<25' 
         WHEN Age BETWEEN 25 AND 34 THEN '25-34' 
         WHEN Age BETWEEN 35 AND 44 THEN '35-44' 
         ELSE '45+' 
       END AS Age_Bracket
FROM period_data;
```

**Results:**

| User_ID | Age | Age_Bracket |
|---------|-----|------------|
| 1       | 24  | <25        |
| 2       | 37  | 35-44      |
| 3       | 32  | 25-34      |
| 4       | 28  | 25-34      |
| 5       | 25  | 25-34      |

**Findings:**

Women aged 36-45 show greater variation in cycle length compared to younger age groups.

### 3. Identifying the Most Common Premenstrual Symptom

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Grouping%20Ages%20into%20Predefined%20Age%20Brackets.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Grouping%20Ages%20into%20Predefined%20Age%20Brackets.png)

**Query Logic:**

- Counted occurrences of each symptom and returned the most frequent one using ORDER BY and LIMIT:

```sql
SELECT Symptoms, 
       COUNT(*) AS Symptom_Count
FROM period_data
GROUP BY Symptoms
ORDER BY Symptom_Count DESC
LIMIT 1;
```

**Results:**

| Symptoms  | Symptom_Count |
|-----------|--------------|
| Bloating  | 56           |

**Findings:**

Bloating is the most commonly reported symptom, followed by mood swings and cramps.

### 4. Percentage Distribution of Cycle Categories

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Calculating%20Percentage%20Distribution%20of%20Regular%20vs.%20Irregular%20Cycles.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Calculating%20Percentage%20Distribution%20of%20Regular%20vs.%20Irregular%20Cycles.png)

**Metric:** Percentage of regular vs. irregular cycles

**Query Logic:**

- Calculated percentage distribution using SQL window functions (COUNT() and SUM() OVER ()):

```sql
SELECT Cycle_Category, 
       COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Percentage
FROM (
    SELECT CASE 
             WHEN Cycle_Length BETWEEN 25 AND 35 THEN 'Regular' 
             ELSE 'Irregular' 
           END AS Cycle_Category
    FROM period_data
) AS Cycles
GROUP BY Cycle_Category;
```

**Results:**

| Cycle_Category | Percentage |
|---------------|------------|
| Regular       | 84%      |
| Irregular     | 14%      |


**Findings:**

84% of cycles are Regular, 14% are Irregular


### 5. Averages by Age Group

[![Preview Image](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Calculating%20Average%20Period%20Duration%20and%20Cycle%20Length%20by%20Age%20Group.png))](https://github.com/TiffanyNwanne/Period-Health-Insights/blob/main/images/Calculating%20Average%20Period%20Duration%20and%20Cycle%20Length%20by%20Age%20Group.png)

**Metric:**

- Average cycle length

- Average period duration

**Query Logic:**

Computed averages by grouping records into age brackets:

```sql
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
    FROM period_data
) AS GroupedData
GROUP BY Age_Bracket;
```

**Results:**

| Age_Bracket | Avg_Period_Duration | Avg_Cycle_Length |
|-------------|---------------------|------------------|
| 25-34       | 5.10 days           | 27.20 days      |
| 35-44       | 5.11 days           | 27.38 days      |
| 45+         | 4.69 days           | 26.15 days      |
| <25         | 5.08 days           | 27.10 days      |


**Findings:**

Across all age groups, period duration is ~5 days, and cycle length is ~27 days


## Other Dashboard Insights

### 1. Mood and Pre-Menstrual Symptoms

**Mood Distribution:**

- 35% feel neutral

- 33% report sadness

- 32% feel happy during their cycle

**Common Pre-Menstrual Symptoms:**

* 28% experience mood swings

+ 23% report cramps

- 21% experience bloating

### 2. Sleep Patterns and Menstrual Health

- The average sleep duration across all age groups is 7 hours.

- Women aged 36-45 have a slightly higher sleep duration compared to younger groups.


## Conclusion & Recommendations

### 1. Monitor Menstrual Health Regularly

- Since 14% of women have irregular cycles, regular tracking can help detect potential health conditions like PCOS or hormonal imbalances.

### 2. Address PMS Symptoms

- With bloating, mood swings, and cramps being common, lifestyle changes such as diet adjustments, exercise, and stress management may help.

### 3. Improve Sleep Hygiene

- Women with shorter sleep durations tend to have more severe PMS symptoms, suggesting that better sleep habits may improve menstrual health.

### 4. Personalized Healthcare for Different Age Groups

- Women aged 36-45 experience more variability in cycle length and sleep duration, indicating a need for targeted reproductive health education.

Overall, the data highlights key menstrual health trends, emphasizing the importance of cycle tracking, symptom management, and healthy sleep patterns for improved well-being.

