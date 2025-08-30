# Quickstart — The Mirror

1) Load CSVs into tables:
   - gold_web_kpi_values  ← data/synthetic/web_kpi_values.csv
   - gold_page_stats      ← data/synthetic/gold_page_stats.csv

2) Run SQL in /sql to create:
   - gold.view_ux_exec_summary
   - gold.view_ux_opportunity_table
   - gold.view_ux_backlog

3) Build one dashboard page:
   - Tiles: CVR, LCP, CLS, INP (with target lines)
   - Table: UX Opportunity Table
   - Bar: Top ICE Backlog items
   - Info pane: formulas + owners/targets

4) DQ checks (tool-agnostic):
   - Use dq/mirror_checks.yaml to enforce freshness and guardrails.
