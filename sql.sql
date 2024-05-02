--Retrieve the Patient_id and ages of all patients.
SELECT Patient_id,
       TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) AS Age
FROM diabetes_prediction;
--Calculate the average BMI of patients
SELECT AVG(bmi) AS average_bmi
FROM diabetes_prediction;
--List patients in descending order of blood glucose levels
