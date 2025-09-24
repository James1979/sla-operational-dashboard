{{ config(materialized='table') }}
select * from {{ ref('int_sla_daily') }}
