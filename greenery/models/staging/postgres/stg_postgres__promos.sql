with src_promos as (
    select * 
    from {{ source('postgres', 'promos') }}
)

,renamed_recast as (
select
PROMO_ID as promo_type
, DISCOUNT
, STATUS
from src_promos
)

select * from renamed_recast

