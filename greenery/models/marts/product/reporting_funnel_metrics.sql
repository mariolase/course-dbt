{{
    config(
    materialized = 'table'
    )
}}

with session_events_agg as (
    select * from {{ ref('int_session_events_agg')}}    
)

select
    count(*) as page_view_sessions
    , sum(case when add_to_carts > 0 then 1 else 0 end) as add_to_cart_sessions
    , sum(case when checkouts > 0 then 1 else 0 end) as checkout_sessions
from session_events_agg