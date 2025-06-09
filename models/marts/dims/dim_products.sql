-- models/marts/dims/dim_products.sql

WITH distinct_products AS (

    SELECT DISTINCT
        PRODUCT_NAME,
        CATEGORY_NAME
    FROM {{ ref('stg_products') }}

)

SELECT
    MD5(PRODUCT_NAME) AS PRODUCT_ID, -- create surrogate key
    PRODUCT_NAME,
    CATEGORY_NAME

FROM distinct_products
