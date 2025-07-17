--  {{ config(materialized='view') }}

-- SELECT
--     week_label,
--     state,
--     district,
--     disease,
--     TRY_CAST(cases AS INT) AS cases,
--     TRY_CAST(deaths AS INT) AS deaths,
--     TO_DATE(DATE_FROM_PARTS(year, month, day)) AS outbreak_date,
--     latitude,
--     longitude,
--     precip_mm,
--     leaf_area_index,
--     temperature_k
-- FROM {{ source('raw_epiclim', 'epiclim_raw') }}
{{ config(materialized='view') }}

SELECT
    week_label,
    state,
    district,
    disease,
    number_of_cases AS cases,
    deaths,
    TO_DATE(DATE_FROM_PARTS(years, months, day_of_month)) AS outbreak_date,
    latitude,
    longitude,
    precip_mm,
    leaf_area_index,
    temperature_k
FROM {{ source('raw_epiclim', 'epiclim_raw') }}
