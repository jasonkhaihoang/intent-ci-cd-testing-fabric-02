-- Model: stg_products
-- Grain: one row per product.
-- Source: {{ ref('products') }} seed

SELECT
    product_id,
    product_name,
    category,
    unit_cost,
    is_active
FROM {{ ref('products') }}
