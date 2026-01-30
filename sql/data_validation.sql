-- Data validation example
SELECT
  COUNT(*) AS total_records,
  COUNT(DISTINCT patient_id) AS unique_patients
FROM healthcare_data;
