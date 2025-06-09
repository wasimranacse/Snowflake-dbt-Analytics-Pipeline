-- models/staging/stg_products.sql
WITH raw_products_data AS (
    SELECT
        product_title AS product_name,
        items_sold,
        orders,
        category_name,
        net_revenue AS total_sales
    FROM {{ source('public', 'raw_products') }}
)

SELECT * FROM raw_products_data
