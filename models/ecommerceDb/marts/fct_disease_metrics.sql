{{ config(materialized='table') }}

SELECT
    week_label,
    state,
    district,
    disease,
    SUM(cases) AS total_cases,
    SUM(deaths) AS total_deaths,
    ROUND(AVG(temperature_k), 2) AS avg_temperature_k,
    ROUND(AVG(precip_mm), 2) AS avg_precip_mm,
    COUNT(*) AS outbreak_count
FROM {{ ref('stg_epiclim') }}
WHERE outbreak_date IS NOT NULL
GROUP BY
    week_label, state, district, disease
