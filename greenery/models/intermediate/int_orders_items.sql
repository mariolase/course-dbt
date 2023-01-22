{{
  config(
    materialized='table'
  )
}}

with orders as (
    select * from {{ ref('stg_postgres__orders')}}
)

with order_items as (
    select * from {{ ref('stg_postgres__orders_items')}}
)

with products as (
    select * from {{ ref('stg_postgres__products')}}
)


select 
orders.order_guid
, promo_type
, user_guid
, address_guid
, created_at_utc AS order_created_at_utc
, order_cost
, shipping_cost
, order_total_cost
, tracking_guid
, estimated_delivery_at_utc
, delivered_at_utc
, status as order_status
, order_items.product_guid
, order_items.quantity
, products.name as product_name
, products.price as product_price
, products.inventory as product_inventory
from orders o
left join order_items on order.order_guid = order_items.order_guid
left join products on order_items.product_guid = products.product_guid

