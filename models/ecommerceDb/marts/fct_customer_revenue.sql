-- {{ config(materialized='table') }}

-- SELECT
--     customer_id,
--     COUNT(DISTINCT invoice_no) AS total_orders,
--     SUM(unit_price * quantity) AS total_revenue,
--     MIN(invoice_ts) AS first_order_date,
--     MAX(invoice_ts) AS last_order_date
-- FROM {{ ref('stg_orders') }}
-- WHERE customer_id IS NOT NULL
-- GROUP BY customer_id
{{ config(materialized='table') }}

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    SUM(unit_price * quantity) AS total_revenue,
    MIN(invoice_ts) AS first_order_date,
    MAX(invoice_ts) AS last_order_date
FROM {{ ref('stg_orders') }}
WHERE customer_id IS NOT NULL
GROUP BY customer_id
