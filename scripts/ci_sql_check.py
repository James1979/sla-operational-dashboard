
import duckdb
import glob
import os

ROOT = os.path.dirname(os.path.dirname(__file__))

ddl_path = os.path.join(ROOT, "phase_1_scope", "sql", "ddl.sql")
seed_path = os.path.join(ROOT, "phase_1_scope", "sql", "seed.sql")
kpis_path = os.path.join(ROOT, "phase_2_kpis", "sql", "kpis.sql")

con = duckdb.connect(database=":memory:")

def run_sql(path):
    with open(path, "r", encoding="utf-8") as f:
        sql = f.read()
    # DuckDB is fairly forgiving; split on semicolons for simple execution
    # but ignore empty statements
    for stmt in [s.strip() for s in sql.split(";") if s.strip()]:
        con.execute(stmt)

print(f"Running DDL: {ddl_path}")
run_sql(ddl_path)
print("OK")

print(f"Running seeds: {seed_path}")
run_sql(seed_path)
print("OK")

print(f"Running KPIs: {kpis_path}")
run_sql(kpis_path)
print("OK")

print("SQL validation completed successfully.")
