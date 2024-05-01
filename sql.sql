--
SELECT Patient_id,
       TIMESTAMPDIFF(YEAR, `D.O.B`, CURDATE()) AS Age
FROM diabetes_prediction;
--
SELECT AVG(bmi) AS average_bmi
FROM diabetes_prediction;
