{{
    config(
    materialized = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres__events') }}
)

select
    user_guid
    , session_guid
    , {{event_types_per_session(event_type)}}
    , min(created_at_utc) as first_session_event_at_utc
    , max(created_at_utc) as last_session_event_at_utc
from events
group by 1,2

