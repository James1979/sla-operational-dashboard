{{ config(materialized='view') }}
with src as (
  select * from read_csv_auto('phase_1_scope/data/cases.csv', header=True)
)
select
  case_id,
  client_id,
  case_type,
  region,
  priority_level,
  cast(created_date as timestamp) as created_date,
  cast(scheduled_date as timestamp) as scheduled_date,
  cast(expected_delivery_date as timestamp) as expected_delivery_date,
  cast(complexity_score as integer) as complexity_score
from src
