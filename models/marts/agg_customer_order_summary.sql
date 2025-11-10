-- models/marts/agg_customer_order_summary.sql
with customer_orders as (

    select * from {{ ref('stg_orders') }}

)

select
    customer_key,
    count(order_key) as total_orders,
    sum(total_amount_cents) as lifetime_spend_cents,
    min(order_date) as first_order_date,
    max(order_date) as most_recent_order_date

from customer_orders

group by 1