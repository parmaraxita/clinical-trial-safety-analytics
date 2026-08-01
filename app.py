import streamlit as st
import pandas as pd
import psycopg2
import plotly.express as px

# Page Setup
st.set_page_config(page_title="Clinical Trial Analytics", layout="wide")

st.title("🔬 Clinical Trial Efficacy & Patient Safety Platform")
st.markdown("Interactive analytics dashboard tracking biomarker responses and high-risk adverse events across treatment arms.")

# DB Connection Function
def get_connection():
    return psycopg2.connect(
        dbname="clinical_trials",
        user="postgres",
        host="127.0.0.1",
        port="5432"
    )

# Sidebar Navigation
st.sidebar.header("Navigation")
view_mode = st.sidebar.radio("Select Analytics View", ["Biomarker Efficacy Trends", "Patient Safety Alerts"])

# View 1: Biomarker Trajectories
if view_mode == "Biomarker Efficacy Trends":
    st.header("📈 Longitudinal Biomarker Trends")
    
    query = """
    SELECT 
        arm.arm_name,
        bl.log_date,
        bl.log_type,
        ROUND(AVG(bl.log_value)::numeric, 2) AS avg_biomarker_value
    FROM biomarker_logs bl
    JOIN patient_assignments pa ON bl.patient_id = pa.patient_id
    JOIN trial_arms arm ON pa.arm_id = arm.arm_id
    GROUP BY arm.arm_name, bl.log_date, bl.log_type
    ORDER BY bl.log_date;
    """
    
    try:
        conn = get_connection()
        df = pd.read_sql_query(query, conn)
        conn.close()

        fig = px.line(
            df, 
            x="log_date", 
            y="avg_biomarker_value", 
            color="arm_name",
            markers=True,
            title="Biomarker Mean Trajectory Over Time by Study Arm",
            labels={"log_date": "Date", "avg_biomarker_value": "Avg Value", "arm_name": "Trial Arm"}
        )
        st.plotly_chart(fig, use_container_width=True)
        
        st.subheader("Summary Table")
        st.dataframe(df, use_container_width=True)

    except Exception as e:
        st.error(f"Error connecting to database or fetching data: {e}")

# View 2: High-Severity Safety Alerts
elif view_mode == "Patient Safety Alerts":
    st.header("🚨 Safety Analytics & Adverse Event Monitoring")
    
    query = """
    SELECT 
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
    """
    
    try:
        conn = get_connection()
        df_safety = pd.read_sql_query(query, conn)
        conn.close()

        col1, col2 = st.columns(2)
        col1.metric("Severe Events", len(df_safety[df_safety['severity'] == 'Severe']))
        col2.metric("Life-Threatening Events", len(df_safety[df_safety['severity'] == 'Life-Threatening']))

        st.subheader("High-Risk Adverse Event Log")
        st.dataframe(df_safety, use_container_width=True)

    except Exception as e:
        st.error(f"Error connecting to database or fetching data: {e}")
