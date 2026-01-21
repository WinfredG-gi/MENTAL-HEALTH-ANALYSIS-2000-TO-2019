CREATE DATABASE
Mental_health_analysis

'Depression prevalence over time globally 1990 to 2019'
SELECT year, AVG(Depressivedisorders_prevalence) AS depression_avg 
FROM mental_illnesses_prevalence
GROUP BY year

'Eating disorders prevalence globally 1990 to 2019'
SELECT year, AVG(Eatingdisorders_prevalence) AS eating_avg
FROM mental_illnesses_prevalence
GROUP BY year

'Anxiety disorders prevalence globally 1990 to 2019'
SELECT year, AVG(Anxietydisorders_prevalence) AS anxiety_avg
FROM mental_illnesses_prevalence
GROUP BY year;

'Bipolar disorder prevalence globally 1990 to 2019'
SELECT year, AVG(Bipolardisorders_prevalence)   AS bipolar_avg
FROM mental_illnesses_prevalence
GROUP BY year;

'Schizophrenia disorders prevalence globally 1990 to 2019'
SELECT year, AVG(Schizophreniadisorders_prevalence)  AS schizophrenia_avg
FROM mental_illnesses_prevalence
GROUP BY year;

'Countries with consistenly high anxiety disorders'
SELECT Entity, AVG(Anxietydisorders_prevalence) AS Highest_Anxiety_Prevalence
FROM mental_illnesses_prevalence
GROUP BY Entity
ORDER BY Highest_Anxiety_Prevalence DESC;

'countirs with consistently high eating disorders'
SELECT Entity, AVG(Eatingdisorders_prevalence) AS Highest_Eating_Disorders
FROM mental_illnesses_prevalence
GROUP BY Entity
ORDER BY Highest_Eating_Disorders DESC;

'countires with consistently high bipolar disorders'
SELECT Entity, AVG(Bipolardisorders_prevalence) AS Highest_Bipolar_Disorders
FROM mental_illnesses_prevalence
GROUP BY Entity
ORDER BY Highest_Bipolar_Disorders DESC;

'countries with consistently high schizopheria disorders'
SELECT Entity, AVG(Schizophreniadisorders_prevalence) AS Highest_Schizophrenia_Disorders
FROM mental_illnesses_prevalence
GROUP BY Entity
ORDER BY Highest_Schizophrenia_Disorders DESC;

'countries with consistently high schizopheria disorders'
SELECT Entity, AVG(Depressivedisorders_prevalence) AS Highest_Depressive_Disorders
FROM mental_illnesses_prevalence
GROUP BY Entity
ORDER BY Highest_Depressive_Disorders DESC;

'mental illness prevalence increase since 1990 for bipolar'
SELECT MIN(year) AS start_year, 
MAX(year) AS end_year,
AVG(Bipolardisorders_prevalence) AS avg_bipolar
FROM mental_illnesses_prevalence;

'longterm prevalence trends by disorder'
SELECT
    Year,
    AVG(Depressivedisorders_prevalence) AS avg_depression,
    AVG(Anxietydisorders_prevalence) AS avg_anxiety,
    AVG(Schizophreniadisorders_prevalence) AS avg_schizophrenia,
    AVG(Bipolardisorders_prevalence) AS avg_bipolar,
    AVG(Eatingdisorders_prevalence) AS avg_eating
FROM mental_illnesses_prevalence
GROUP BY Year;

'Long-term DALYs trends by mental illness'
SELECT
    Year,
    AVG(DALYs_Depressive) AS avg_dalys_depression,
    AVG(DALYs_Anxiety) AS avg_dalys_anxiety,
    AVG(DALYs_Schizophrenia) AS avg_dalys_schizophrenia,
    AVG(DALYs_Bipolar) AS avg_dalys_bipolar,
    AVG(DALYs_Eating) AS avg_dalys_eating
FROM disease_burden
GROUP BY Year;

'Prevalence vs DALYs trends (1990–2019)'
WITH prevalence_cte AS (     
SELECT         
Year,         
AVG(Depressivedisorders_prevalence) AS avg_depression,         
AVG(Anxietydisorders_prevalence) AS avg_anxiety,         
AVG(Schizophreniadisorders_prevalence) AS avg_schizophrenia,         
AVG(Bipolardisorders_prevalence) AS avg_bipolar,         
AVG(Eatingdisorders_prevalence) AS avg_eating     
FROM mental_illnesses_prevalence     
GROUP BY Year 
), 
dalys_cte AS (     
SELECT         
Year,         
AVG(DALYs_Depressive) AS avg_dalys_depression,         
AVG(DALYs_Anxiety) AS avg_dalys_anxiety,         
AVG(DALYs_Schizophrenia) AS avg_dalys_schizophrenia,         
AVG(DALYs_Bipolar) AS avg_dalys_bipolar,         
AVG(DALYs_Eating) AS avg_dalys_eating     
FROM disease_burden     
GROUP BY Year 
) 
SELECT     
p.Year,     
p.avg_depression,     
d.avg_dalys_depression,     
p.avg_anxiety,     
d.avg_dalys_anxiety,     
p.avg_schizophrenia,     
d.avg_dalys_schizophrenia,     
p.avg_bipolar,     
d.avg_dalys_bipolar,     
p.avg_eating,     
d.avg_dalys_eating 
FROM prevalence_cte p 
JOIN dalys_cte d     
ON p.Year = d.Year 
ORDER BY p.Year

'alternative'
SELECT p.year, AVG(p.Depressivedisorders_prevalence) AS avg_depression, 
       AVG(b.DALYs_Depressive) AS avg_dalys_depression,
       AVG(p.Anxietydisorders_prevalence) AS avg_anxiety, 
       AVG(b.DALYs_Anxiety) AS avg_dalys_anxiety,
       AVG(p.Schizophreniadisorders_prevalence) AS avg_schizophrenia,
       AVG(b.DALYs_Schizophrenia) AS avg_dalys_schizophrenia, 
       AVG(p.Bipolardisorders_prevalence) AS avg_bipolar, 
       AVG(b.DALYs_Bipolar) AS avg_dalys_bipolar,  
       AVG(p.Eatingdisorders_prevalence) AS avg_eating,
       AVG(b.DALYs_Eating) AS avg_dalys_eating 
FROM mental_illnesses_prevalence p
JOIN disease_burden b
ON p.year = b.year
GROUP BY P.year;

'Income-group trend over time'
SELECT year, Entity, AVG(adequate_treatment) AS avg_adequate,
       AVG(other_treatment) AS avg_other,
       AVG(untreated) AS avg_untreated
FROM anxiety_disorders_treatment_gap
WHERE Entity IN (
                'High-income countries', 
                'Lower-middle-income countries', 
                'Upper-middle-income countries'
                )
GROUP BY year, Entity
ORDER BY year, Entity;

'Mental illness prevalence by disorder (2019 snapshot)'
SELECT
    Year,
    AVG(Depressivedisorders_prevalence) AS avg_depression2019,
    AVG(Anxietydisorders_prevalence) AS avg_anxiety2019,
    AVG(Schizophreniadisorders_prevalence) AS avg_schizophrenia2019,
    AVG(Bipolardisorders_prevalence) AS avg_bipolar2019,
    AVG(Eatingdisorders_prevalence) AS avg_eating2019
FROM mental_illnesses_prevalence
WHERE Year = 2019;

'Mental illness DALYs by disorder (2019 snapshot)'
SELECT
    Year,
    AVG(DALYs_Depressive) AS avg_dalys_depression2019,
    AVG(DALYs_Anxiety) AS avg_dalys_anxiety2019,
    AVG(DALYs_Schizophrenia) AS avg_dalys_schizophrenia2019,
    AVG(DALYs_Bipolar) AS avg_dalys_bipolar2019,
    AVG(DALYs_Eating) AS avg_dalys_eating2019
FROM disease_burden
WHERE year = 2019;

'Countries with the highest mental illness burden per capita (2019)'
SELECT Entity,
	   ROUND(
        DALYs_Depressive + 
        DALYs_Anxiety +
        DALYs_Schizophrenia +
        DALYs_Bipolar +
        DALYs_Eating,
       2
 ) AS total_mental_healthDALYs2019
FROM disease_burden
WHERE Year = 2019
  AND Code IS NOT NULL
ORDER BY total_mental_healthDALYs2019 DESC
LIMIT 15;

'Countries with the highest untreated anxiety rates (2019)'
SELECT
    Entity,
    ROUND(untreated, 2) AS untreated_anxiety_rate_percent
FROM anxiety_disorders_treatment_gap
WHERE Year = 2019
  AND Code IS NOT NULL
   AND untreated IS NOT NULL
ORDER BY Entity, untreated_anxiety_rate_percent DESC
LIMIT 5;

SELECT
    Entity,
    ROUND(untreated, 2) AS untreated_anxiety_rate_percent
FROM anxiety_disorders_treatment_gap
WHERE Year = (
    SELECT MAX(Year)
    FROM anxiety_disorders_treatment_gap
)
AND Entity NOT LIKE '%income%'
AND untreated IS NOT NULL
ORDER BY untreated_anxiety_rate_percent DESC
LIMIT 5;

'Adult population coverage in primary data year 2008'

SELECT Entity,
    `Majordepression`,
    `Bipolardisorder`,
    `Eatingdisorder`,
    `Dysthymia`,
    `Schizophrenia`,
    `Anxietydisorder`
FROM population_in_primary_data
ORDER BY Entity;

'Depressive symptoms across US population 2014'
SELECT Symptoms,
    `Nearly_everyday`,
    `More_half_days`,
    `Several_days`,
    `Not_at_all`
FROM depressive_symptoms_us
ORDER BY Symptoms;

'Number of countries with primary prevalence data in 2019'
SELECT Disorders, Country_Datacount
FROM countries_with_primary_data
ORDER BY Disorders;

SELECT @@hostname;