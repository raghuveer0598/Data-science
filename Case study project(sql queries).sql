# VIEW RAW DATA
SELECT * FROM raw_data ;
#Delete columns which are not useful( standard working hours and over 18, Employee count columns)
Select Count(DISTINCT StandardHours) As Cardinality_standardHours, Count(Distinct Over18) as Cardinality_over18, Count(Distinct EmployeeCount) as cardinality_Employeecount FROM raw_data;
ALTER TABLE raw_data 
	DROP StandardHours, 
	DROP  Over18, 
    DROP  EmployeeCount;
# check for null vales 
SELECT SUM(CASE WHEN Age is null then 1 else 0 end),Age from raw_data group by Age;
SELECT SUM(CASE WHEN Attrition is null then 1 else 0 end),Attrition from raw_data group by Attrition;
SELECT SUM(CASE WHEN BusinessTravel is null then 1 else 0 end),BusinessTravel from raw_data group by BusinessTravel;
SELECT SUM(CASE WHEN Dailyrate is null then 1 else 0 end),Dailyrate from raw_data group by Dailyrate;
SELECT SUM(CASE WHEN Department  is null then 1 else 0 end),Department  from raw_data group by Department ;
SELECT SUM(CASE WHEN DistanceFromHome is null then 1 else 0 end),DistanceFromHome from raw_data group by DistanceFromHome;
SELECT SUM(CASE WHEN  Education is null then 1 else 0 end), Education from raw_data group by  Education;
SELECT SUM(CASE WHEN  EducationField  is null then 1 else 0 end), EducationField  from raw_data group by  EducationField;
SELECT SUM(CASE WHEN EmployeeNumber is null then 1 else 0 end),EmployeeNumber from raw_data group by EmployeeNumber;
SELECT SUM(CASE WHEN EnvironmentSatisfaction is null then 1 else 0 end),EnvironmentSatisfaction from raw_data group by EnvironmentSatisfaction;
SELECT SUM(CASE WHEN Gender is null then 1 else 0 end),Gender from raw_data group by Gender;
SELECT SUM(CASE WHEN Hourlyrate is null then 1 else 0 end),Hourlyrate from raw_data group by Hourlyrate;
SELECT SUM(CASE WHEN JobInvolvement is null then 1 else 0 end),JobInvolvement from raw_data group by JobInvolvement ;
SELECT SUM(CASE WHEN JobLevel is null then 1 else 0 end),JobLevel from raw_data group by JobLevel;
SELECT SUM(CASE WHEN JobRole is null then 1 else 0 end),JobRole  from raw_data group by JobRole ;
SELECT SUM(CASE WHEN JobSatisfaction is null then 1 else 0 end),JobSatisfaction  from raw_data group by JobSatisfaction;
SELECT SUM(CASE WHEN MaritalStatus is null then 1 else 0 end),MaritalStatus from raw_data group by MaritalStatus;
SELECT SUM(CASE WHEN MonthlyIncome is null then 1 else 0 end),MonthlyIncome from raw_data group by MonthlyIncome;
SELECT SUM(CASE WHEN MonthlyRate is null then 1 else 0 end),MonthlyRate from raw_data group by MonthlyRate;
SELECT SUM(CASE WHEN NumCompaniesWorked is null then 1 else 0 end),NumCompaniesWorked  from raw_data group by NumCompaniesWorked;
SELECT SUM(CASE WHEN OverTime is null then 1 else 0 end),OverTime from raw_data group by OverTime;
SELECT SUM(CASE WHEN PercentSalaryHike is null then 1 else 0 end),PercentSalaryHike from raw_data group by PercentSalaryHike;
SELECT SUM(CASE WHEN PerformanceRating is null then 1 else 0 end),PerformanceRating from raw_data group by PerformanceRating;
SELECT SUM(CASE WHEN RelationshipSatisfaction is null then 1 else 0 end),RelationshipSatisfaction from raw_data group by RelationshipSatisfaction;
SELECT SUM(CASE WHEN StockOptionLevel is null then 1 else 0 end),StockOptionLevel  from raw_data group by StockOptionLevel ;
SELECT SUM(CASE WHEN TotalWorkingYears is null then 1 else 0 end),TotalWorkingYears from raw_data group by TotalWorkingYears;
SELECT SUM(CASE WHEN TrainingTimesLastYear is null then 1 else 0 end),TrainingTimesLastYear from raw_data group by TrainingTimesLastYear;
SELECT SUM(CASE WHEN WorkLifeBalance is null then 1 else 0 end),WorkLifeBalance from raw_data group by WorkLifeBalance;
SELECT SUM(CASE WHEN YearsAtCompany is null then 1 else 0 end),YearsAtCompany from raw_data group by YearsAtCompany;
SELECT SUM(CASE WHEN YearsInCurrentRole is null then 1 else 0 end),YearsInCurrentRole From  raw_data group by YearsInCurrentRole;
SELECT SUM(CASE WHEN YearsSinceLastPromotion is null then 1 else 0 end),YearsSinceLastPromotion from raw_data group by YearsSinceLastPromotion;
SELECT SUM(CASE WHEN YearsWithCurrManager is null then 1 else 0 end),YearsWithCurrManager from raw_data group by YearsWithCurrManager;

# Find duplicate values in employeenumber column
SELECT COUNT(distinct(EmployeeNumber)) ,COUNT(EmployeeNumber) FROM raw_data ;

#Find Invalid data in table
SELECT Education from raw_data where Education <0 or Education >5 ;
SELECT EnvironmentSatisfaction from raw_data where EnvironmentSatisfaction <0 or EnvironmentSatisfaction >4 ;
SELECT JobInvolvement from raw_data where JobInvolvement <0 or JobInvolvement >4 ;
SELECT JobSatisfaction FROM raw_data where JobSatisfaction <0 or JobSatisfaction >4 ;
Select PerformanceRating from raw_data where PerformanceRating <0 or PerformanceRating >4 ;
SELECT RelationshipSatisfaction from raw_data where RelationshipSatisfaction <0 or RelationshipSatisfaction >4 ;
SELECT worklifebalance from raw_data where worklifebalance <0 or  worklifebalance>4 ;
SELECT StockOptionLevel FROM raw_data where StockOptionLevel <0 or StockOptionLevel >3;
SELECT Joblevel from raw_data where Joblevel <0 or JobLevel >5;

#Find outliers in age column

SELECT Age,zscoreage,mu,sigma
FROM 
	(select Age,
    (Age-Avg(AGE)over())/stddev(AGE) over() AS zscoreage, 
	Avg(AGE) over() as mu, 
    stddev(Age) over() as sigma
    FROM raw_data) AS zscore
WHERE zscoreage< -3 or  zscoreage >3;


#Find outliers in DistanceFrom Home column
SELECT DistanceFromHome,zscoreDFH,mu,sigma
FROM 
	(select DistanceFromHome ,
    (DistanceFromHome-Avg(DistanceFromHome)over())/stddev(DistanceFromHome) over() AS zscoreDFH, 
    Avg(DistanceFromHome) over() as mu, 
    stddev(DistanceFromHome) over() as sigma 
    FROM raw_data) AS zscore
    WHERE zscoreDFH <-3 OR zscoreDFH >3;   
    
#Find Total no of employees leaving and staying in a company
SELECT Attrition,count(*) FROM raw_data GROUP BY Attrition;
#Find average age of employees who told yes to attrition

SELECT AVG(Age) FROM raw_data where Attrition='yes';
#Average Age is 33.6076

#Find average age of employees who told No to attrition
SELECT AVG(Age) FROM raw_data where Attrition='NO';
#Average Age is 37.5612

#Find Average Distance travelled by employees who said yes
SELECT AVG(DistanceFromHome) FROM raw_data where Attrition= 'YES';
#Average DistanceFromHome is 10.6329
 
##Find Average Distance travelled by employees who said No
SELECT AVG(DistanceFromHome) FROM raw_data where Attrition= 'NO';
#Average DistanceFromHome is 8.9157

#Attrition in entire dataset
SELECT (select COUNT(EmployeeNumber)from raw_data WHERE Attrition='Yes')/count(EmployeeNumber)*100 FROM raw_data;












    
 
 
 
 
 
 
 
 