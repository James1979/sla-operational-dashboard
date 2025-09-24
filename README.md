# Steno SLA & Operational Performance Dashboard (Starter Repo)

 
- A ready-to-run **file tree** split into phases
- SQL for schema, seeds, and KPIs
- Looker LookML views/explore/dashboard
- What-if modeling (SQL + notebook scaffold)
- Automation & tests
- Executive storytelling docs and interview notes
-



## Quickstart (DuckDB or Postgres)
1. Create DB & load `/phase_1_scope/sql/ddl.sql` then `/phase_1_scope/sql/seed.sql`.
2. Run KPIs in `/phase_2_kpis/sql/kpis.sql`.
3. Point Looker/Tableau to your DB and import the models in `/phase_3_dashboard/`.
4. Configure Slack alert via `/phase_5_alerts_ops/automation/slack_alert_example.json`.
5. Capture screenshots per `/phase_6_polish/docs/README.md`.



---

© Built by James Lim

## Next Steps: Modern Stack (Snowflake + Fivetran + dbt + Looker)
- **Fivetran**: Point connectors at your ops system(s) → land raw tables in Snowflake (schema: `raw_ops`).
- **dbt**: Create staging models (`stg_*`) on top of `raw_ops`, then build `int_*` (logic) and `fct_sla`/`dim_*` in `analytics` schema.
- **Environments**: Use dbt targets (`dev`, `prod`) with separate Snowflake warehouses/roles.
- **Looker**: Point Explores at `analytics.fct_sla`; keep business logic in dbt, not LookML.
- **Alerts**: Use Looker data actions or webhooks to Slack when `fct_sla.sla_pct < 95` over the last N days.

### Snowflake profile example (dbt)
```yaml
sla_operational_dashboard:
  target: prod
  outputs:
    prod:
      type: snowflake
      account: <your_account>
      user: <your_user>
      password: <env var: SNOWFLAKE_PASSWORD>
      role: TRANSFORMER
      database: ANALYTICS
      warehouse: TRANSFORMING
      schema: ANALYTICS
      threads: 8
      client_session_keep_alive: False
```

### Commands
```bash
# duckdb local
dbt deps
dbt build --profiles-dir dbt --project-dir dbt

# snowflake
export SNOWFLAKE_PASSWORD=...
dbt build --profiles-dir ~/.dbt --project-dir dbt --target prod
```
