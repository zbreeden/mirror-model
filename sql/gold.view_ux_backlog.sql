-- gold.view_ux_backlog.sql
WITH opp AS (
  SELECT page_template, device, sessions, cvr, lcp, cls, inp, ttt, errors, breach_count
  FROM gold_view_ux_opportunity_table
),
scored AS (
  SELECT
    page_template,
    device,
    CASE
      WHEN lcp > 2.5 THEN 'Improve LCP'
      WHEN cls > 0.10 THEN 'Reduce CLS'
      WHEN inp > 200 THEN 'Lower INP'
      WHEN errors > 0.05 THEN 'Fix client errors'
      ELSE 'Tune UX path'
    END AS issue,
    LEAST(10, GREATEST(1, ROUND(sessions/500.0)))            AS impact,
    CASE WHEN breach_count >= 2 THEN 8 WHEN breach_count=1 THEN 6 ELSE 4 END AS confidence,
    CASE
      WHEN lcp > 2.5 THEN 3
      WHEN cls > 0.10 THEN 4
      WHEN inp > 200 THEN 5
      WHEN errors > 0.05 THEN 4
      ELSE 6
    END AS effort
  FROM opp
)
SELECT
  page_template, device, issue, impact, confidence, effort,
  ROUND((impact*confidence)/NULLIF(effort,0),2) AS ice_score,
  'Pair fix with A/B guardrail check' AS note
FROM scored
ORDER BY ice_score DESC
LIMIT 20;
