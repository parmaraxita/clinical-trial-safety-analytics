# Clinical Trial Efficacy & Patient Safety Analytics Platform

## Executive Summary
This project implements a relational database in PostgreSQL to analyze clinical trial data for an investigational target protein drug. It evaluates dose-dependent treatment efficacy while monitoring real-time patient safety metrics across three treatment arms (Control, Low Dose, High Dose).

## Key Analytical Findings
* **Treatment Efficacy:** The High Dose arm (150mg) demonstrated the greatest reduction in target protein levels compared to baseline, confirming a dose-dependent biological response.
* **Safety & Tolerability:** A trade-off was observed in the High Dose arm, which exhibited an elevated frequency of hypertensive events (systolic BP ≥ 140 mmHg) compared to lower dose levels.

## Database Schema & Architecture
The relational database consists of 5 normalized tables:
* `patients`: Demographic information.
* `trial_arms`: Study cohorts and dosing parameters (Control, Low Dose, High Dose).
* `patient_assignments`: Mapping patients to trial arms.
* `biomarker_logs`: Longitudinal biomarker readings (protein levels, blood pressure).
* `adverse_events`: Reported side effects and severity levels.

## Technical SQL Highlights
* **Window Functions (`FIRST_VALUE`, `PARTITION BY`):** Computed longitudinal baseline shifts for individual patients across clinical visits.
* **Common Table Expressions (CTEs):** Aggregated baseline-to-latest efficacy metrics across study cohorts.
* **Conditional Logic (`CASE`):** Categorized real-time patient safety risk profiles (Normal, Prehypertension, Hypertension Alert).
* **Optimization & Reporting:** Built B-Tree indexes on high-cardinality join and timestamp columns, alongside reusable SQL Views (`vw_patient_longitudinal_summary`) for reporting tools.
*
