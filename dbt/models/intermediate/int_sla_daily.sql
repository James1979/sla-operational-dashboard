{{ config(materialized='view') }}
with joined as (
  select
    d.delivery_id,
    d.case_id,
    d.delivery_date,
    d.is_on_time,
    c.region,
    c.expected_delivery_date
  from {{ ref('stg_deliveries') }} d
  join {{ ref('stg_cases') }} c using (case_id)
),
daily as (
  select
    date_trunc('day', delivery_date) as delivery_day,
    region,
    count(*) as total_deliveries,
    sum(case when is_on_time then 1 else 0 end) as on_time_deliveries
  from joined
  group by 1,2
)
select
  delivery_day,
  region,
  total_deliveries,
  on_time_deliveries,
  round(on_time_deliveries * 100.0 / nullif(total_deliveries,0), 2) as sla_pct
from daily
