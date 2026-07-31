-- Longitudinal Biomarker Trends over Time
SELECT 
    arm.arm_name,
    bl.log_date,
    bl.log_type,
    ROUND(AVG(bl.log_value)::numeric, 2) AS avg_biomarker_value,
    COUNT(DISTINCT bl.patient_id) AS patients_evaluated
FROM biomarker_logs bl
JOIN patient_assignments pa ON bl.patient_id = pa.patient_id
JOIN trial_arms arm ON pa.arm_id = arm.arm_id
GROUP BY arm.arm_name, bl.log_date, bl.log_type
ORDER BY arm.arm_name, bl.log_date;
