-- HANDLE MISSING VALUES
-- Replace placeholder '?' values with NULL

UPDATE diabetic_data
SET payer_code = null
WHERE payer_code = '?';

UPDATE diabetic_data
SET race = null
where race = '?';

update diabetic_data
set medical_specialty = null
where medical_specialty ='?';

update diabetic_data
set gender = null
where gender not in ('Male', 'Female');

update diabetic_data
set diag_1 = null
where diag_1 = '?';

UPDATE diabetic_data
SET diag_2 = NULL
WHERE diag_2 = '?';

UPDATE diabetic_data
SET diag_3 = NULL
WHERE diag_3 = '?';

-- STANDARDIZE DIAGNOSIS CODES
-- Truncate ICD-9 diagnosis codes to 3-digit base category
-- Diagnosis codes were truncated for higher-level categorical analysis

UPDATE diabetic_data
SET 
    diag_1 = SUBSTRING_INDEX(diag_1, '.', 1),
    diag_2 = SUBSTRING_INDEX(diag_2, '.', 1),
    diag_3 = SUBSTRING_INDEX(diag_3, '.', 1);
    
-- fix spelling errors

UPDATE diabetic_data
SET medical_specialty = 'Internal Medicine'
WHERE medical_specialty = 'InternalMedicine';

UPDATE diabetic_data
SET readmitted = REPLACE(REPLACE(readmitted, CHAR(13), ''), CHAR(10), '');

-- drop columns due to zero variance

ALTER TABLE diabetic_data
DROP COLUMN examide,
DROP COLUMN citoglipton;

-- temp table to create readmisson binary feature

CREATE TEMPORARY TABLE temp_readmit AS
SELECT *,
       CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END AS readmit_30
FROM diabetic_data;
