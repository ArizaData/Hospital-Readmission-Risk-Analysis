-- highlighted queries below were used to identify high risk patients 

-- Segments patients by prior inpatient visit frequency to evaluate its impact on 30-day readmission rates

SELECT 
    CASE 
        WHEN number_inpatient = 0 THEN '0'
        WHEN number_inpatient = 1 THEN '1'
        WHEN number_inpatient = 2 THEN '2'
        WHEN number_inpatient BETWEEN 3 AND 4 THEN '3-4'
        ELSE '5+'
    END AS inpatient_bucket,
    COUNT(*) AS total_patients,
    SUM(readmit_30) AS readmitted_count,
    ROUND(100.0 * SUM(readmit_30)/COUNT(*), 2) AS readmit_rate
FROM temp_readmit
GROUP BY inpatient_bucket;

-- Segments patients by emergency visit frequency to measure its relationship with 30-day readmission risk
 SELECT 
    CASE 
        WHEN number_emergency = 0 THEN '0'
        WHEN number_emergency = 1 THEN '1'
        WHEN number_emergency = 2 THEN '2'
        ELSE '3+'
    END AS emergency_bucket,
    COUNT(*) AS total_patients,
    SUM(readmit_30) AS readmitted_count,
    ROUND(100.0 * SUM(readmit_30)/COUNT(*), 2) AS readmit_percentage
FROM temp_readmit
GROUP BY emergency_bucket
ORDER BY emergency_bucket;


-- Groups ICD-9 diagnosis codes into high-level disease categories to compare 30-day readmission rates across clinical conditions and identify high-risk disease groups

SELECT 
    CASE 
        WHEN diag_1 BETWEEN '390' AND '459' THEN 'Circulatory'
        WHEN diag_1 BETWEEN '460' AND '519' THEN 'Respiratory'
        WHEN diag_1 BETWEEN '520' AND '579' THEN 'Digestive'
        WHEN diag_1 BETWEEN '580' AND '629' THEN 'Genitourinary'
        WHEN diag_1 BETWEEN '140' AND '239' THEN 'Neoplasms'
        WHEN diag_1 BETWEEN '800' AND '999' THEN 'Injury & Poisoning'
        WHEN diag_1 BETWEEN '710' AND '739' THEN 'Musculoskeletal'
        WHEN diag_1 LIKE '250%' OR diag_1 = '250' THEN 'Diabetes'
        WHEN diag_1 BETWEEN '240' AND '279' THEN 'Endocrine & Metabolic'
        ELSE 'Other'
    END AS disease_category,
    COUNT(*) AS total_patients,
    SUM(readmit_30) AS total_readmissions,
    ROUND(100.0 * SUM(readmit_30) / COUNT(*), 2) AS readmit_rate
FROM temp_readmit
GROUP BY disease_category
ORDER BY readmit_rate DESC;

-- Groups insulin usage patterns into dosage change vs no change to evaluate whether insulin adjustment during admission is associated with 30-day readmission risk
SELECT 
    CASE 
        WHEN insulin IN ('No', 'Steady') THEN 'No Dosage Change'
        WHEN insulin IN ('Up', 'Down') THEN 'Dosage Adjusted'
    END AS insulin_group,
    COUNT(*) AS total_patients,
    SUM(readmit_30) AS total_readmissions,
    ROUND(100.0 * SUM(readmit_30) / COUNT(*), 2) AS readmit_rate
FROM temp_readmit
GROUP BY insulin_group
ORDER BY readmit_rate DESC;
