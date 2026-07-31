-- Safety Analytics: High Severity Adverse Events & Patient Flags
SELECT 
    p.patient_id,
    p.patient_code,
    arm.arm_name,
    ae.event_name,
    ae.severity,
    ae.onset_date,
    ae.action_taken
FROM adverse_events ae
JOIN patients p ON ae.patient_id = p.patient_id
JOIN patient_assignments pa ON p.patient_id = pa.patient_id
JOIN trial_arms arm ON pa.arm_id = arm.arm_id
WHERE ae.severity IN ('Severe', 'Life-Threatening')
ORDER BY ae.onset_date DESC;
