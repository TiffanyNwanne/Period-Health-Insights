
# Period Health Analysis Using MySQL

## **Objective**
This project analyzes menstrual cycle data from Nigerian women aged 18-45 using MySQL queries. The goal is to extract key metrics such as:
- **Percentage of regular vs. irregular cycles**  
- **Average cycle length**  
- **Average period duration**  
- **Most common premenstrual symptoms**  

---

## **Dataset Overview**
The dataset includes menstrual health records of Nigerian women aged 18-45, containing attributes such as age, cycle length, period duration, symptoms, contraceptive use, mood, and sleep patterns.

---

## **Analysis Breakdown**

### **1. Cycle Categorization: Regular vs. Irregular**
- **Criteria:**  
  - Regular: Cycle length between 25 and 35 days  
  - Irregular: Any other value  
- **Query Logic:**  
  - Classified cycles based on the above range using a `CASE` statement.  

---

### **2. Age Grouping into Predefined Brackets**
- **Age Brackets:**  
  - `<25`, `25-34`, `35-44`, `45+`  
- **Query Logic:**  
  - Grouped users into predefined age brackets using conditional logic in a `CASE` statement.  

---

### **3. Identifying the Most Common Premenstrual Symptom**
- **Query Logic:**  
  - Counted occurrences of each symptom and returned the most frequent one using `ORDER BY` and `LIMIT`.  

---

### **4. Percentage Distribution of Cycle Categories**
- **Metric:** Percentage of regular vs. irregular cycles  
- **Query Logic:**  
  - Calculated percentage distribution using SQL window functions (`COUNT()` and `SUM() OVER ()`).  

---

### **5. Averages by Age Group**
- **Metrics:**  
  - Average cycle length  
  - Average period duration  
- **Query Logic:**  
  - Grouped records by age brackets and computed averages using `AVG()`.  

---

### **6. Dynamic Data Filtering**
- **Example Query:**  
  - Filtered users aged 25-34 with a cycle length greater than 30 days using a `WHERE` clause for targeted analysis.  

---

### **7. Aggregating Data for Visualizations**
- **Metric:** Total counts by cycle category for visualization  
- **Query Logic:**  
  - Used `GROUP BY` to summarize data for creating pie/doughnut charts.  

---

### **8. Key Performance Indicators (KPIs)**
- **Metrics Extracted:**  
  - Average cycle length  
  - Most common symptom  
- **Query Logic:**  
  - Extracted key metrics using aggregate functions (`AVG()`, `COUNT()`) and subqueries.  

---

## **Outcome**
- Queries were compiled into a comprehensive SQL file: `period_health_ analysis_queries.sql`.  


