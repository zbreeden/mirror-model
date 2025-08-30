-- gold.view_ux_exec_summary.sql
WITH kpis AS (
  SELECT term, value, target, owner, last_refresh_ts
  FROM gold_web_kpi_values
),
guards AS (
  SELECT
    MAX(CASE WHEN term='lcp' THEN value END) AS lcp,
    MAX(CASE WHEN term='cls' THEN value END) AS cls,
    MAX(CASE WHEN term='inp' THEN value END) AS inp
  FROM kpis
)
SELECT
  'Increase online conversion reliably' AS goal,
  k.term AS kpi,
  k.value,
  k.owner,
  k.target,
  k.last_refresh_ts,
  g.lcp, g.cls, g.inp
FROM kpis k CROSS JOIN guards g
WHERE k.term IN ('conversion_rate','average_order_value')
ORDER BY kpi;
