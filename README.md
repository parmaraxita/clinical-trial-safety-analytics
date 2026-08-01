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
* # Clinical Trial Efficacy & Patient Safety Analytics Platform

## Overview
A PostgreSQL-based clinical trial analytics platform designed to aggregate, analyze, and track patient safety outcomes and biomarker efficacy across treatment arms.

## Project Structure
* `schema.sql` - Relational database schema defining patients, study arms, assignments, biomarkers, and adverse events.
* `seeds.sql` - Synthetic trial dataset containing longitudinal patient measurements and safety events.
* `queries/`
  - `01_efficacy_cte.sql` - CTE-based analysis of baseline vs. latest endpoint biomarker response.
  - `02_longitudinal.sql` - Longitudinal tracking of biomarker trends over study visits.
  - `03_safety_flags.sql` - Safety monitoring query filtering high-severity adverse drug events.

## Key Findings & Sample Query Output

### Primary Efficacy Endpoint (% Change from Baseline)
| Trial Arm | Total Patients | Avg Baseline | Avg Latest | Avg % Change |
| :--- | :--- | :--- | :--- | :--- |
| **Drug A (High Dose)** | 25 | 120.50 | 65.20 | **-45.89%** |
| **Drug B (Low Dose)**  | 25 | 118.80 | 88.40 | **-25.59%** |
| **Placebo**            | 25 | 121.10 | 119.80 | **-1.07%** |

### High-Severity Safety Flags
| Severity Level | Events Detected | Action Taken |
| :--- | :--- | :--- |
| **Severe** | 4 | Dose Reduction / Temporary Hold |
| **Life-Threatening** | 1 | Permanent Study Drug Withdrawal |
* **Common Table Expressions (CTEs):** Aggregated baseline-to-latest efficacy metrics across study cohorts.
* **Conditional Logic (`CASE`):** Categorized real-time patient safety risk profiles (Normal, Prehypertension, Hypertension Alert).
* **Optimization & Reporting:** Built B-Tree indexes on high-cardinality join and timestamp columns, alongside reusable SQL Views (`vw_patient_longitudinal_summary`) for reporting tools.
*
