--  Project: IBM HR Attrition Analysis
-- Dataset: IBM HR Analytics Employee Attrition & Performance
-- Table: employee_attrition
-- Description: This SQL project analyzes employee attrition using the IBM HR dataset.
-- It explores factors like department, job role, gender, income, and more to understand turnover patterns.

-- Table Schema: employee_attrition
-- Columns:
-- 1. Age (INTEGER): Employee's age
-- 2. Attrition (VARCHAR): Whether the employee left ('Yes' or 'No')
-- 3. BusinessTravel (VARCHAR): Travel frequency ('Non-Travel', 'Travel_Rarely', 'Travel_Frequently')
-- 4. DailyRate (INTEGER): Daily pay rate
-- 5. Department (VARCHAR): Department (e.g., 'Sales', 'Research & Development', 'Human Resources')
-- 6. DistanceFromHome (INTEGER): Distance from home to work (km)
-- 7. Education (INTEGER): Education level (1=Below College, 2=College, 3=Bachelor, 4=Master, 5=Doctor)
-- 8. EducationField (VARCHAR): Field of education (e.g., 'Life Sciences', 'Medical', 'Marketing')
-- 9. EmployeeCount (INTEGER): Always 1 (placeholder)
-- 10. EmployeeNumber (INTEGER): Unique employee ID
-- 11. EnvironmentSatisfaction (INTEGER): Work environment satisfaction (1=Low, 4=Very High)
-- 12. Gender (VARCHAR): Gender ('Male' or 'Female')
-- 13. HourlyRate (INTEGER): Hourly pay rate
-- 14. JobInvolvement (INTEGER): Job involvement level (1=Low, 4=Very High)
-- 15. JobLevel (INTEGER): Job level (1 to 5)
-- 16. JobRole (VARCHAR): Job role (e.g., 'Sales Executive', 'Research Scientist')
-- 17. JobSatisfaction (INTEGER): Job satisfaction (1=Low, 4=Very High)
-- 18. MaritalStatus (VARCHAR): Marital status ('Single', 'Married', 'Divorced')
-- 19. MonthlyIncome (INTEGER): Monthly income
-- 20. MonthlyRate (INTEGER): Monthly rate (pay metric)
-- 21. NumCompaniesWorked (INTEGER): Number of previous companies worked at
-- 22. Over18 (VARCHAR): Always 'Y' (placeholder)
-- 23. OverTime (VARCHAR): Overtime status ('Yes' or 'No')
-- 24. PercentSalaryHike (INTEGER): Percentage salary increase
-- 25. PerformanceRating (INTEGER): Performance rating (3=Excellent, 4=Outstanding)
-- 26. RelationshipSatisfaction (INTEGER): Relationship satisfaction (1=Low, 4=Very High)
-- 27. StandardHours (INTEGER): Always 80 (placeholder)
-- 28. StockOptionLevel (INTEGER): Stock option level (0 to 3)
-- 29. TotalWorkingYears (INTEGER): Total years of work experience
-- 30. TrainingTimesLastYear (INTEGER): Training sessions last year
-- 31. WorkLifeBalance (INTEGER): Work-life balance (1=Bad, 4=Best)
-- 32. YearsAtCompany (INTEGER): Years at the company
-- 33. YearsInCurrentRole (INTEGER): Years in current role
-- 34. YearsSinceLastPromotion (INTEGER): Years since last promotion
-- 35. YearsWithCurrManager (INTEGER): Years with current manager

-- Queries below analyze attrition patterns across various dimensions.

-- How many employees are there in the dataset?

SELECT COUNT(*) AS total_employees
FROM employee_attrition;

-- How many employees have left the company?

SELECT COUNT(*) AS employee_left 
FROM employee_attrition
WHERE Attrition = 'YES';

-- What is the attrition count by department?

SELECT Department, COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY Department;

-- What is the attrition rate (%) in each department?

SELECT 
    Department,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY Department;

-- what is the attrition count by the job role?

SELECT JobRole, COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY employees_left DESC;

-- What is the attrition rate by gender?

SELECT Gender,
    COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS employees_left,
    COUNT(*) AS total_employees,
    ROUND(
        COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) * 100.0 / COUNT(*),
        2
    ) AS attrition_rate_percent
FROM employee_attrition
GROUP BY Gender;

-- What is the average age of employees who left vs stayed?

SELECT 
    Attrition,
    ROUND(AVG(Age), 1) AS average_age
FROM employee_attrition
GROUP BY Attrition;

-- What is the attrition count by education field?

SELECT 
    EducationField,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY EducationField
ORDER BY employees_left DESC;

-- What is the attrition count by distance from home range?
SELECT 
    CASE 
        WHEN DistanceFromHome BETWEEN 0 AND 10 THEN '0-10 km'
        WHEN DistanceFromHome BETWEEN 11 AND 20 THEN '11-20 km'
        WHEN DistanceFromHome BETWEEN 21 AND 30 THEN '21-30 km'
        ELSE '31+ km'
    END AS distance_range,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY distance_range
ORDER BY employees_left DESC;

-- What is the attrition count by monthly income range?
SELECT 
    CASE 
        WHEN MonthlyIncome < 3000 THEN '<3000'
        WHEN MonthlyIncome BETWEEN 3000 AND 6000 THEN '3000-6000'
        WHEN MonthlyIncome BETWEEN 6001 AND 9000 THEN '6001-9000'
        ELSE '9000+'
    END AS income_range,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY income_range
ORDER BY employees_left DESC;

-- Does overtime affect attrition?
SELECT 
    OverTime,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY OverTime;

-- Top 5 highest paid employees in each department
SELECT *
FROM (
    SELECT 
        EmployeeNumber,
        Department,
        MonthlyIncome,
        RANK() OVER (PARTITION BY Department ORDER BY MonthlyIncome DESC) AS income_rank
    FROM employee_attrition
) ranked
WHERE income_rank <= 5;





































































































