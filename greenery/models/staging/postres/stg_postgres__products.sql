with src_products as (
    select * 
    from {{ source('postgres', 'products') }}
)

,renamed_recast as (
select
PRODUCT_ID as product_guid
, NAME
, PRICE
, INVENTORY
from src_products
)

select * from renamed_recast