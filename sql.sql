--Retrieve the Patient_id and ages of all patients.
SELECT Patient_id,
       TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) AS Age
FROM diabetes_prediction;
--Calculate the average BMI of patients
SELECT AVG(bmi) AS average_bmi
FROM diabetes_prediction;
--List patients in descending order of blood glucose levels
SELECT EmployeeName ,Patient_id ,blood_glucose_level
FROM diabetes_prediction
ORDER BY blood_glucose_level DESC
--Find patients who have hypertension and diabetes.
SELECT EmployeeName ,Patient_id , hypertension , diabetes
FROM diabetes_prediction
WHERE hypertension = '1' AND diabetes = '1';
--Determine the number of patients with heart disease.
SELECT 
       COUNT(Patient_id) AS num_patients_with_heart_disease
FROM diabetes_prediction
WHERE heart_disease = '1';
--Group patients by smoking history and count how many smokers and nonsmokers there are.
SELECT smoking_history,
       COUNT(smoking_history) AS num_patients
FROM diabetes_prediction
GROUP BY smoking_history;
--Retrieve the Patient_ids of patients who have a BMI greater than the average BMI
SELECT Patient_id
FROM diabetes_prediction
WHERE bmi > (
    SELECT AVG(bmi)
    FROM diabetes_prediction
);
-- Find the patient with the highest HbA1c level and the patient with the lowest HbA1c
SELECT Patient_id, HbA1c_level
FROM diabetes_prediction
ORDER BY HbA1c_level DESC
LIMIT 1;

SELECT Patient_id, HbA1c_level
FROM diabetes_prediction
ORDER BY HbA1c_level ASC
LIMIT 1;
--Calculate the age of patients in years (assuming the current date as of now)
SELECT Patient_id, 
       TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) AS Age_in_years
FROM diabetes_prediction;
--Rank patients by blood glucose level within each gender group.
SELECT 
    Patient_id,
    gender,
    blood_glucose_level,
    DENSE_RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level DESC) AS glucose_level_rank
FROM 
    diabetes_prediction;
--Update the smoking history of patients who are older than 50 to "Ex-smoker.
UPDATE diabetes_prediction
SET smoking_history = 'Ex-smoker'
WHERE TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) > 50;
--Insert a new patient into the database with sample data.
INSERT INTO diabetes_prediction (Patient_id, gender, 
`D.O.B`, hypertension, heart_disease, smoking_history, 
bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES ('PT27488', 'Male', '1975-05-15 00:00:00', '0', '1', 'no info', 28.5, 6.2, 110, '0');
-- Delete all patients with heart disease from the database
DELETE FROM diabetes_prediction
WHERE heart_disease = '1';
-- Find patients who have hypertension but not diabetes using the EXCEPT operator
    -- USING: NOT EXISTS 
SELECT Patient_id, 
hypertension,
diabetes
FROM diabetes_prediction AS d1
WHERE hypertension = '1'
AND NOT EXISTS (
    SELECT 1
    FROM diabetes_prediction AS d2
    WHERE d1.Patient_id = d2.Patient_id
    AND diabetes = '1'
);
     --Using LEFT JOIN and IS NULL:
SELECT d1.*
FROM diabetes_prediction AS d1
LEFT JOIN diabetes_prediction AS d2
    ON d1.Patient_id = d2.Patient_id
    AND d2.diabetes = 'Yes'
WHERE d1.hypertension = 'Yes'
AND d2.Patient_id IS NULL;
--Define a unique constraint on the "patient_id" column to ensure its values are unique
ALTER TABLE diabetes_prediction
MODIFY COLUMN Patient_id VARCHAR(255);

ALTER TABLE diabetes_prediction
ADD CONSTRAINT patient_id_unique UNIQUE (Patient_id);
--Create a view that displays the Patient_ids, ages, and BMI of patients
CREATE VIEW patient_info_view AS
SELECT Patient_id, 
       TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) AS Age,
       bmi
FROM diabetes_prediction;
   --run the code below to check if the view was created 
SELECT * FROM patient_info_view;













