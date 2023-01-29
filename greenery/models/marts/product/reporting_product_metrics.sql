{{
    config(
    materialized = 'table'
    )
}}

with products as (
    select * from {{ ref('stg_postgres__products')}}    
)

, events as (
    select * from {{ ref('stg_postgres__events')}}    
)

, order_items as (
    select * from {{ ref('stg_postgres__order_items')}}    
)

, product_views as (
    select 
        product_guid
        , count(distinct(session_guid)) as product_views
    from events
    where product_guid is not null
    group by 1
)

, product_purchases as (
    select 
        order_items.product_guid
        , count(distinct(events.session_guid)) as product_purchase_sessions
from events
inner join order_items using (order_guid)
group by 1
)

select 
    products.product_guid
    , products.name as product_name
    , product_views
    , product_purchase_sessions
from products
inner join product_views using(product_guid)
inner join product_purchases using(product_guid)