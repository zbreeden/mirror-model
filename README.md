# The Mirror (Web UX Diagnostics) — Starter

What it is: a focused UX diagnostics module pairing business KPIs with Core Web Vitals and quality guardrails to surface high-impact opportunities and a scored backlog.

Views
- gold.view_ux_exec_summary.sql — exec-level tiles (CVR + LCP/CLS/INP with owner/target/freshness)
- gold.view_ux_opportunity_table.sql — where to act (by page_template × device)
- gold.view_ux_backlog.sql — ICE-scored backlog (top 20)

Data
- data/synthetic/web_kpi_values.csv — global KPIs (CVR, LCP, CLS, INP, AOV)
- data/synthetic/gold_page_stats.csv — 14 days × 4 templates × 2 devices

Notes
- If your warehouse lacks PERCENTILE_CONT, replace medians with AVG() or your engine’s percentile function.
- Add consent filters as needed (e.g., restrict to consent_state='granted').
