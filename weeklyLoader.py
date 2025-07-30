## Sample script for cron job

import pandas as pd
import snowflake.connector

# Load the data
df = pd.read_csv("/Users/sbhome/Downloads/Final_data.csv")

# Rename and clean
df = df.rename(columns={
    'week_of_outbreak': 'week_label',
    'state_ut': 'state',
    'district': 'district',
    'Disease': 'disease',
    'Cases': 'number_of_cases',
    'Deaths': 'deaths',
    'mon': 'months',
    'Latitude': 'latitude',
    'Longitude': 'longitude',
    'preci': 'precip_mm',
    'LAI': 'leaf_area_index',
    'Temp': 'temperature_k'
})

# Coerce numeric fields
df['number_of_cases'] = pd.to_numeric(df['number_of_cases'], errors='coerce')
df['deaths'] = pd.to_numeric(df['deaths'], errors='coerce')

# Filter Week 1 data: years up to 2021
df_week1 = df[df['year'] > 2021]


# Connect to Snowflake
conn = snowflake.connector.connect(
    user='userna,e',
    password='password*',
    account='account number',
    warehouse='COMPUTE_WH',
    database='EPICLIM_DB',
    schema='RAW'
)
cur = conn.cursor()

# Upload data row by row
for _, row in df_week1.iterrows():
    cur.execute("""
        INSERT INTO epiclim_raw (
            week_label, state, district, disease,
            number_of_cases, deaths, day_of_month, months, years,
            latitude, longitude, precip_mm,
            leaf_area_index, temperature_k
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        row['week_label'],
        row['state'],
        row['district'],
        row['disease'],
        int(row['number_of_cases']) if pd.notna(row['number_of_cases']) else None,
        int(row['deaths']) if pd.notna(row['deaths']) else None,
        int(row['day']) if pd.notna(row['day']) else None,
        int(row['months']) if pd.notna(row['months']) else None,
        int(row['year']) if pd.notna(row['year']) else None,
        float(row['latitude']) if pd.notna(row['latitude']) else None,
        float(row['longitude']) if pd.notna(row['longitude']) else None,
        float(row['precip_mm']) if pd.notna(row['precip_mm']) else None,
        float(row['leaf_area_index']) if pd.notna(row['leaf_area_index']) else None,
        float(row['temperature_k']) if pd.notna(row['temperature_k']) else None
    ))
    
conn.commit()
cur.close()
conn.close()
