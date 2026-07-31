-- Seed Trial Arms
INSERT INTO trial_arms (arm_name, dosage_mg) VALUES
('Control', 0),
('Low Dose', 50),
('High Dose', 150);
-- Seed Patients
INSERT INTO patients (first_name, last_name, age, gender, enrollment_date) VALUES
('Axita', 'Parmar', 24, 'Female', '2025-01-10'),
('John', 'Smith', 58, 'Male', '2025-01-12'),
('Chang', 'Rostova', 45, 'Female', '2025-01-15'),
('Marcus', 'Vance', 62, 'Male', '2025-01-20'),
('David', 'Kim', 41, 'Male', '2025-02-01'),
('Emily', 'Watson', 29, 'Female', '2025-02-02'),
('Nachos', 'Chaz', 53, 'Male', '2025-02-03'),
('Aysa', 'Patel', 38, 'Female', '2025-02-05'),
('Taylor', 'Dejavu', 67, 'Male', '2025-02-07');
-- Seed Patient Assignments
INSERT INTO patient_assignments (patient_id, arm_id, assignment_date) VALUES                                               (1, 1, '2025-01-10'),
(2, 2, '2025-01-12'),
(3, 3, '2025-01-15'),
(4, 3, '2025-01-20'),
(5, 1, '2025-02-01'),
(6, 2, '2025-02-02'),
(7, 2, '2025-02-03'),
(8, 3, '2025-02-05'),
(9, 3, '2025-02-07');
-- Seed Biomarker Logs (Sample Baseline & Follow-ups)
INSERT INTO biomarker_logs (patient_id, log_date, target_protein_level, systolic_bp, diastolic_bp) VALUES
-- Patient 1 (Control- Baseline:2025-01-12)                                                                                                                          
(1, '2025-01-12', 8.5, 120, 80),
(1, '2025-02-12', 8.4, 122, 82),

-- Patient 2 (Control - Baseline: 2025-01-15)
(2, '2025-01-15', 9.1, 118, 78),
(2, '2025-02-15', 9.0, 119, 79),

-- Patient 3 (Control - Baseline: 2025-01-20)
(3, '2025-01-20', 8.9, 121, 81),
(3, '2025-02-20', 8.8, 123, 82),

-- Patient 4 (Low Dose - Baseline: 2025-02-01)
(4, '2025-02-01', 8.8, 125, 83),
(4, '2025-03-01', 6.2, 128, 85),

-- Patient 5 (Low Dose - Baseline: 2025-02-02)
(5, '2025-02-02', 9.5, 130, 85),
(5, '2025-03-02', 7.1, 132, 86),                                                                                                                                                            -- Patient 6 (Low Dose - Baseline: 2025-02-03)
(6, '2025-02-03', 9.0, 124, 82),
(6, '2025-03-03', 6.5, 126, 84),

-- Patient 7 (High Dose - Baseline: 2025-02-05)
(7, '2025-02-05', 9.2, 128, 84),
(7, '2025-03-05', 4.1, 142, 92),

-- Patient 8 (High Dose - Baseline: 2025-02-07)
(8, '2025-02-07', 8.9, 122, 80),
(8, '2025-03-07', 3.8, 145, 95);
-- Seed Adverse Events
INSERT INTO adverse_events (patient_id, event_name, severity, onset_date) VALUES
(7, 'Hypertension', 'Moderate', '2025-02-20'),
(8, 'Hypertension', 'Severe', '2025-02-25'),
(5, 'Headache', 'Mild', '2025-02-15');
