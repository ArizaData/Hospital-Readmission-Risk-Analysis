# Hospital-Readmission-Risk-Analysis


## Executive Summary:

Reducing avoidable 30-day readmissions is one of the most direct levers we have to improve patient outcomes and protect the hospital from CMS financial penalties. Our analysis of over 100,000 patient encounters across our hospital network pinpoints exactly which patients are driving that risk and what we can do about it. Patients with 5 or more prior inpatient visits are nearly 4x more likely to be readmitted, and our diabetic patients carry an elevated readmission rate of 13% compared to our 11% baseline. Patients with heart-related conditions represent our largest patient group at over 30,000 encounters, making them a high priority target by volume alone. The following sections outline the key findings and actionable recommendations on how to identify and intervene on our highest-risk patients.

## Business Problem:

Hospital readmissions are costly and often preventable. Reducing avoidable 30-day readmissions improves patient outcomes and helps the hospital avoid CMS financial penalties. What are the primary factors driving readmissions, and which high-risk patient profiles can be targeted for earlier intervention?

## Dataset Overview & Data Checks:
Tools Used: SQL (MySQL), Excel, Power BI

Our dataset includes over 100,000 hospital encounters for diabetic patients across 130 U.S. hospitals spanning 1999–2008. Each row represents a single hospital visit and includes patient demographics, diagnoses, hospital utilization, and medications.
Initial checks were performed in Excel, where columns like weight (too many missing values) and Encounter ID (identifier only) were removed.
The data was then cleaned in SQL by:

* Replacing '?' values with NULL
* Standardizing key categorical fields (e.g., gender, medical specialty)
* Truncating ICD-9 diagnosis codes to 3-digit categories for easier analysis
* Removing columns with no variation (examide, citoglipton)
* Creating a binary readmission field (readmit_30) using a temporary table

SQL queries can be found [here] 

## Key findings 

### Patient Demographics:

* Readmission rates are relatively consistent across age groups, but patients 50 and older account for 85% of all 30-day readmissions (9,627 of 11,357), making them the highest priority target simply due to volume.
  
* Gender readmission rates are nearly identical across male (11.06%) and female (11.25%) patients, indicating gender is not a meaningful driver of 30-day readmission risk in this dataset.
  
* Race readmission rates show minimal variation across racial groups (9.63%–11.29%), indicating race is not a meaningful driver of readmission risk in this dataset.

<img width="918" height="643" alt="image" src="https://github.com/user-attachments/assets/01964458-effe-4561-9b9d-ca8a4e7cd1a6" />

### Hospital Utilization:

* Emergency visit rates nearly double from 10% to 25% as visit frequency rises, making it one of the strongest drivers of 30-day readmission risk alongside prior inpatient history.
  
* Prior inpatient visits show the steepest risk escalation, climbing from 8.4% to 36.4% as hospitalizations increase. Patients with 5+ prior visits are over 4x more likely to be readmitted within 30 days.
  
* Length of stay shows a clear step-up in readmission risk after 3 days, rising from 9.7% to 13.5%, suggesting longer stays reflect greater clinical complexity rather than better care.
  
* Outpatient visits show a weak and inconsistent signal, with rates ticking up from 10.7% to 13% before plateauing, making it the least reliable predictor of the four utilization variables.

 <img width="1299" height="645" alt="Screenshot 2026-05-06 173603" src="https://github.com/user-attachments/assets/22e5b1c4-6090-45d0-9504-d8a48a874b79" />
   *Dashed line represents the dataset average readmission rate of 11.16%* 

### Clinical Indicators:

* When looking at number of medications across patients, those on 16 or more medications have a readmission rate of 12.48% compared to 7.48% for those on 5 or fewer. Nearly half the dataset falls in the highest bucket suggesting high medication burden is a reliable proxy for clinical complexity and readmission risk.
  
* By primary diagnosis of the patient, diabetes carries the highest readmission rate at 12.98%, while circulatory conditions represent the largest patient volume at 30,389 encounters — making cardiac and diabetic patients the highest priority targets for intervention. Diabetes also appears as a secondary or tertiary diagnosis in nearly 30,000 additional encounters, confirming it as a pervasive comorbidity across the dataset.
  
* Patients with insulin dosage adjustments show elevated readmission rates. Downward adjustments carry the highest rate at 13.90% and upward adjustments at 12.99%, compared to 10.04% for patients on no insulin. Active dose changes during a hospital stay signal clinical instability and higher readmission risk.
  
<img width="1288" height="615" alt="image" src="https://github.com/user-attachments/assets/f9c08634-1608-4131-b7e9-01c9384bd208" />

## Recommendations:
* Establish an automatic care coordination trigger for patients with repeat inpatient history. With patients carrying 5 or more prior inpatient visits being over 4x more likely to be readmitted, assigning a dedicated care coordinator at intake — rather than at discharge — gives clinical teams more time to build a structured transition plan before the patient leaves the building.
  
* Introduce a high-frequency emergency visitor protocol at intake. Readmission rates nearly double from 10% to 25% as emergency visit frequency rises, yet intervention typically happens at discharge when it's too late. Flagging patients with 2 or more prior emergency visits on arrival allows care teams to begin discharge planning from day one.
  
* Target cardiac and diabetic comorbidity patients for coordinated care from day one of admission. Circulatory conditions represent the largest patient group at 30,389 encounters and diabetes carries the highest readmission rate at 12.98% — patients presenting with both face compounding risk. Embedding a care coordinator into rounds for this profile rather than consulting one at discharge would meaningfully reduce avoidable readmissions in the highest volume segment.
  
* Deploy pharmacist-led medication reconciliation for all patients on 16 or more medications before discharge. Nearly half the dataset falls in this high-burden bucket at a 12.48% readmission rate. A structured review identifying conflicting or redundant medications before the patient goes home reduces the risk of post-discharge complications driving avoidable returns.
  
* Require clinical sign-off on glucose stability before discharging any patient whose insulin was adjusted downward. Patients with downward insulin adjustments carry the highest readmission rate in the dataset at 13.90%, suggesting premature discharge before glucose is stabilized. A mandatory endocrinologist review before discharge for this patient group would directly address this gap.

## Caveats & Assumptions: 

* Dataset spans 1999–2008 and may not fully reflect current clinical practices or hospital protocols.

* Each row represents a unique hospital encounter. Patients with multiple visits appear more than once in the dataset.

* Readmission was defined as any return within 30 days regardless of reason.

* ICD-9 codes were truncated to 3-digit categories, grouping related but clinically distinct conditions together.

* Several columns were available but excluded from analysis due to low analytical value, including payer code, medical specialty, and individual medication types beyond insulin.









