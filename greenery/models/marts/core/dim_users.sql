{{
  config(
    materialized='table'
  )
}}

with users as (
    select *
    from {{ ref('stg_postgres__users') }}
)

, addresses as (
    select * 
    from {{ ref('stg_postgres__addresses') }}
)


select
    users.first_name
    , users.last_name
    , users.email
    , users.created_at_utc::DATE AS created_date_utc
    , addresses.address
    , addresses.country
    , addresses.state
    , addresses.zipcode
from  users
left join addresses
on users.address_guid = addresses.address_guid

