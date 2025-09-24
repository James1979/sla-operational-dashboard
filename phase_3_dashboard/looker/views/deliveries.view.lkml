view: deliveries {
  sql_table_name: `operations.deliveries` ;;
  dimension: delivery_id { primary_key: yes type: string sql: ${TABLE}.delivery_id ;; }
  dimension: case_id { type: string sql: ${TABLE}.case_id ;; }
  dimension_group: delivery { type: time timeframes: [date, week, month] sql: ${TABLE}.delivery_date ;; }
  dimension: is_on_time { type: yesno sql: ${TABLE}.is_on_time = 1 ;; }
  measure: total_deliveries { type: count ;; }
  measure: sla_compliance_rate {
    type: number
    sql: (SUM(CASE WHEN ${is_on_time} THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*),0) ;;
    value_format_name: percent_1
  }
  dimension: delivery_delay_days { type: number sql: DATEDIFF(${delivery_date}, ${cases.expected_delivery_date}) ;; }
  measure: avg_lead_time_days { type: average sql: ${delivery_delay_days} ;; }
}
