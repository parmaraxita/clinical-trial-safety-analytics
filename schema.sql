-- Patients Table
CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    enrollment_date DATE
);

-- Trial Arms Table
CREATE TABLE trial_arms (
    arm_id SERIAL PRIMARY KEY,
    arm_name VARCHAR(50),
    dosage_mg INT
);

-- Patient Assignments Table
CREATE TABLE patient_assignments (
    assignment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    arm_id INT REFERENCES trial_arms(arm_id),
    assignment_date DATE
);

-- Biomarker Logs Table
CREATE TABLE biomarker_logs (
    log_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    log_date DATE,
    target_protein_level NUMERIC(5,2),
    systolic_bp INT,
    diastolic_bp INT
);

-- Adverse Events Table
CREATE TABLE adverse_events (
    event_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    event_name VARCHAR(100),
    severity VARCHAR(20),
    onset_date DATE
);

-- Performance Indexes
CREATE INDEX idx_biomarker_patient_date ON biomarker_logs(patient_id, log_date);
CREATE INDEX idx_assignments_arm ON patient_assignments(arm_id);
