{{ config(materialized='view') }}
with src as (
  select * from read_csv_auto('phase_1_scope/data/deliveries.csv', header=True)
)
select
  delivery_id,
  case_id,
  cast(delivery_date as timestamp) as delivery_date,
  delivery_method,
  cast(pages_count as integer) as pages_count,
  cast(quality_score as double) as quality_score,
  cast(is_on_time as boolean) as is_on_time
from src
