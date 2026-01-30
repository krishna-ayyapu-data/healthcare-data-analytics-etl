/* =====================================================
   Healthcare Analytics – Advanced SQL
===================================================== */

-- Total patients and visits
SELECT
    COUNT(DISTINCT patient_id) AS total_patients,
    COUNT(visit_id) AS total_visits
FROM healthcare_visits;

-- Patient distribution by age group
SELECT
    CASE
        WHEN age < 18 THEN 'Below 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 55 THEN '36-55'
        ELSE 'Above 55'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY
    CASE
        WHEN age < 18 THEN 'Below 18'
        WHEN age BETWEEN 18 AND 35 THEN '18-35'
        WHEN age BETWEEN 36 AND 55 THEN '36-55'
        ELSE 'Above 55'
    END;

-- Department-wise readmission rate
SELECT
    department,
    COUNT(*) AS total_admissions,
    SUM(CASE WHEN readmitted = 'Y' THEN 1 ELSE 0 END) AS readmissions,
    ROUND(
        SUM(CASE WHEN readmitted = 'Y' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2
    ) AS readmission_rate
FROM healthcare_visits
GROUP BY department;

-- High frequency patients
SELECT
    patient_id,
    COUNT(visit_id) AS visit_count
FROM healthcare_visits
GROUP BY patient_id
HAVING COUNT(visit_id) > 3;

-- Monthly visit trend
SELECT
    TO_CHAR(visit_date, 'YYYY-MM') AS visit_month,
    COUNT(*) AS total_visits
FROM healthcare_visits
GROUP BY TO_CHAR(visit_date, 'YYYY-MM')
ORDER BY visit_month;
