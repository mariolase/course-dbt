{{
    config(
    materialized = 'table'
    )
}}

with session_products_agg as (
    select * from {{ ref ('int_session_products_agg') }}
)

, products as (
select * from {{ ref ('stg_postgres__products') }}
)

select
    session_products_agg.product_guid
    , session_products_agg.session_guid
    , products.name
    , session_products_agg.page_views
    , session_products_agg.add_to_carts
    , session_products_agg.checkouts
    , session_products_agg.package_shippeds
    , session_products_agg.first_session_event_at_utc as first_session_event
    , session_products_agg.last_session_event_at_utc as last_session_event
    , datediff ('minute', first_session_event, last_session_event) as session_length_minutes

from session_products_agg
left join products using (product_guid)