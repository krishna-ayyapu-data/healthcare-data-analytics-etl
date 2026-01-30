"""
Automated Healthcare Reporting Pipeline
"""

import pandas as pd

def generate_reports(file_path):
    df = pd.read_csv(file_path)

    # Department-wise summary
    dept_summary = df.groupby('department').agg(
        total_visits=('visit_id', 'count'),
        avg_age=('age', 'mean')
    ).reset_index()

    # Monthly trend
    monthly_trend = df.groupby(['visit_year', 'visit_month']).size().reset_index(name='visits')

    # Save reports
    dept_summary.to_csv("data/department_summary.csv", index=False)
    monthly_trend.to_csv("data/monthly_trend.csv", index=False)

    print("Reports generated successfully")

if __name__ == "__main__":
    generate_reports("data/cleaned_healthcare_data.csv")
