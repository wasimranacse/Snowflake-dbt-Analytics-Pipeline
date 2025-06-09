-- models/marts/dims/dim_customers.sql

WITH distinct_customers AS (

    SELECT DISTINCT
        CUSTOMER_NAME,
        CUSTOMER_TYPE
    FROM {{ ref('stg_orders') }}
    WHERE CUSTOMER_NAME IS NOT NULL  -- Best practice: avoid null customers

)

SELECT
    MD5(UPPER(TRIM(CUSTOMER_NAME))) AS CUSTOMER_ID,  -- More stable surrogate key
    CUSTOMER_NAME,
    CUSTOMER_TYPE

FROM distinct_customers
