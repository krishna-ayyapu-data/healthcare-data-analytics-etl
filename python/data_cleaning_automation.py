"""
Healthcare Data Cleaning Automation
Author: Krishna Vibha Vasu
"""

import pandas as pd
import numpy as np

def clean_healthcare_data(input_file, output_file):
    # Load data
    df = pd.read_csv(input_file)

    # Basic cleaning
    df.drop_duplicates(inplace=True)

    # Handle missing values
    df['age'] = df['age'].fillna(df['age'].median())
    df['department'] = df['department'].fillna('Unknown')

    # Standardize column names
    df.columns = df.columns.str.lower().str.replace(" ", "_")

    # Convert date
    df['visit_date'] = pd.to_datetime(df['visit_date'], errors='coerce')

    # Remove invalid dates
    df = df[df['visit_date'].notnull()]

    # Feature engineering
    df['visit_year'] = df['visit_date'].dt.year
    df['visit_month'] = df['visit_date'].dt.month

    # Save cleaned data
    df.to_csv(output_file, index=False)

    print("Data cleaning completed successfully")

if __name__ == "__main__":
    clean_healthcare_data(
        "data/raw_healthcare_data.csv",
        "data/cleaned_healthcare_data.csv"
    )
