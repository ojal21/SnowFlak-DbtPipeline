{{ config(materialized='view') }}

SELECT
    invoice_no,
    stock_code,
    description,
    TRY_CAST(quantity AS INT) AS quantity,
    -- TO_TIMESTAMP(invoice_date, 'DD/MM/YY HH24:MI') AS invoice_ts,
    TO_TIMESTAMP(invoice_date, 'MM/DD/YYYY HH24:MI') AS invoice_ts,

    TRY_CAST(unit_price AS FLOAT) AS unit_price,
    TRY_CAST(customer_id AS INT) AS customer_id,
    country
FROM {{ source('raw', 'orders_raw') }}
