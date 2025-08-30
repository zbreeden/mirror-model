-- gold.view_ux_opportunity_table.sql
WITH base AS (
  SELECT
    page_template,
    device,
    SUM(sessions) AS sessions,
    CAST(SUM(conversions) AS DOUBLE) / NULLIF(SUM(sessions),0) AS cvr,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY lcp) AS lcp,
    AVG(cls) AS cls,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY inp) AS inp,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY time_to_task_sec) AS ttt,
    CAST(SUM(errors) AS DOUBLE) / NULLIF(SUM(sessions),0) AS errors
  FROM gold_page_stats
  GROUP BY page_template, device
),
breaches AS (
  SELECT *,
    (CASE WHEN lcp > 2.5 THEN 1 ELSE 0 END +
     CASE WHEN cls > 0.10 THEN 1 ELSE 0 END +
     CASE WHEN inp > 200 THEN 1 ELSE 0 END +
     CASE WHEN errors > 0.05 THEN 1 ELSE 0 END) AS breach_count
  FROM base
)
SELECT *,
  CASE
    WHEN breach_count >= 2 AND sessions >= 500 THEN 'High'
    WHEN breach_count >= 1 AND sessions >= 200 THEN 'Medium'
    ELSE 'Low'
  END AS priority_hint
FROM breaches
ORDER BY
  CASE priority_hint WHEN 'High' THEN 3 WHEN 'Medium' THEN 2 ELSE 1 END DESC,
  sessions DESC;
