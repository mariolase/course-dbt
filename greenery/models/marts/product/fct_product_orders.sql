{{
  config(
    materialized='table'
  )
}}

with orders_items as (
    select * from {{ ref('int_orders_items')}}
)
select
      product_guid
    , product_name
    , product_inventory
    , product_price
    , sum(quantity) as product_sales_volume
    , sum(order_cost) as product_sales_revenue
    from orders_items
    group by 1,2,3,4