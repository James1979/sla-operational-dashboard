# Monitoring & Alerts
- Schedule KPI queries daily.
- Run `/tests/kpi_validations.sql` and alert on FAIL.
- Post to Slack using webhook with `slack_alert_example.json` template.
- Rotate webhooks quarterly; restrict by IP where possible.
