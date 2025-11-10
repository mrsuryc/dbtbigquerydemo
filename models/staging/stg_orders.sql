-- models/staging/stg_orders.sql
with source_data as (

    select * from {{ ref('raw_orders') }}

)

select
    -- Key Fields
    cast(order_id as int) as order_key,
    cast(customer_id as int) as customer_key,

    -- Dates
    cast(order_date as date) as order_date,

    -- Metrics & Status
    cast(amount as numeric) as total_amount,
    -- Simple transformation: convert amount to cents for internal consistency (integer math)
    cast(floor(amount * 100) as int) as total_amount_cents,
    upper(trim(status)) as order_status

from source_data