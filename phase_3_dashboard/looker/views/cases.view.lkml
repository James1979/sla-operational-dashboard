view: cases {
  sql_table_name: `operations.cases` ;;
  dimension: case_id { primary_key: yes type: string sql: ${TABLE}.case_id ;; }
  dimension: client_id { type: string sql: ${TABLE}.client_id ;; }
  dimension: case_type { type: string sql: ${TABLE}.case_type ;; }
  dimension: region { type: string sql: ${TABLE}.region ;; }
  dimension: priority_level { type: string sql: ${TABLE}.priority_level ;; }
  dimension_group: created { type: time timeframes: [date, week, month] sql: ${TABLE}.created_date ;; }
  dimension_group: scheduled { type: time timeframes: [date, week] sql: ${TABLE}.scheduled_date ;; }
  dimension_group: expected_delivery { type: time timeframes: [date, week] sql: ${TABLE}.expected_delivery_date ;; }
  measure: total_cases { type: count ;; }
  measure: backlog_cases {
    type: count
    filters: [expected_delivery_date: "before today"]
    sql: CASE WHEN ${expected_delivery_date_date} < CURRENT_DATE THEN 1 ELSE 0 END ;;
  }
}
