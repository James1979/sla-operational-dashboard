dashboard: sla_operational_performance {
  title: "SLA & Operational Performance"
  layout: newspaper
  filters: [
    { name: date_range, title: "Date Range", type: field_filter, field: cases.created_date }
  ]

  elements: [
    {
      title: "Current SLA Performance"
      name: sla_kpi
      model: operations
      explore: operations
      type: single_value
      fields: [deliveries.sla_compliance_rate]
    },
    {
      title: "SLA Trend (Daily)"
      name: sla_trend
      model: operations
      explore: operations
      type: looker_line
      fields: [deliveries.delivery_date, deliveries.sla_compliance_rate]
    }
  ]
}
