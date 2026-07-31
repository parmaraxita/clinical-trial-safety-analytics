-- Efficacy Analysis: Biomarker % Change from Baseline by Trial Arm
WITH baseline AS (
    SELECT patient_id, log_value AS baseline_val
    FROM biomarker_logs
    WHERE log_type = 'Baseline'
),
latest AS (
    SELECT DISTINCT ON (patient_id) patient_id, log_value AS latest_val
    FROM biomarker_logs
    WHERE log_type != 'Baseline'
    ORDER BY patient_id, log_date DESC
)
SELECT 
    arm.arm_name,
    COUNT(p.patient_id) AS total_patients,
    ROUND(AVG(b.baseline_val)::numeric, 2) AS avg_baseline,
    ROUND(AVG(l.latest_val)::numeric, 2) AS avg_latest,
    ROUND(AVG(((l.latest_val - b.baseline_val) / b.baseline_val) * 100)::numeric, 2) AS avg_pct_change
FROM patients p
JOIN patient_assignments pa ON p.patient_id = pa.patient_id
JOIN trial_arms arm ON pa.arm_id = arm.arm_id
JOIN baseline b ON p.patient_id = b.patient_id
JOIN latest l ON p.patient_id = l.patient_id
GROUP BY arm.arm_name;
