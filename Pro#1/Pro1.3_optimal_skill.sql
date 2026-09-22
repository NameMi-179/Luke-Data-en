/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/
SELECT 
    ssd.skills,
    ROUND(MEDIAN(jf.salary_year_avg),0) AS median_salary,
    --COUNT(jf.job_id) AS demand_count,
    COUNT(jf.salary_year_avg) AS demand_tod,
    ROUND(LN(COUNT(jf.salary_year_avg)),2) AS LN_demand,
    ROUND((MEDIAN(jf.salary_year_avg) * LN(COUNT(jf.salary_year_avg)))/1_000_000,2) AS optimal_rank
FROM job_postings_fact AS jf
INNER JOIN skills_job_dim AS sd
    ON jf.job_id = sd.job_id
INNER JOIN skills_dim AS ssd
    ON sd.skill_id = ssd.skill_id
WHERE
    jf.job_title_short = 'Data Engineer' AND jf.job_work_from_home = True AND jf.salary_year_avg IS NOT NULL
GROUP BY 
    ssd.skills
HAVING
    COUNT(jf.*) > 100
ORDER BY  
    optimal_rank DESC
LIMIT 25;

/*
┌────────────┬───────────────┬────────────┬───────────┬──────────────┐
│   skills   │ median_salary │ demand_tod │ LN_demand │ optimal_rank │
│  varchar   │    double     │   int64    │  double   │    double    │
├────────────┼───────────────┼────────────┼───────────┼──────────────┤
│ terraform  │      184000.0 │        193 │      5.26 │         0.97 │
│ python     │      135000.0 │       1133 │      7.03 │         0.95 │
│ sql        │      130000.0 │       1128 │      7.03 │         0.91 │
│ aws        │      137320.0 │        783 │      6.66 │         0.91 │
│ airflow    │      150000.0 │        386 │      5.96 │         0.89 │
│ spark      │      140000.0 │        503 │      6.22 │         0.87 │
│ kafka      │      145000.0 │        292 │      5.68 │         0.82 │
│ snowflake  │      135500.0 │        438 │      6.08 │         0.82 │
│ azure      │      128000.0 │        475 │      6.16 │         0.79 │
│ java       │      135000.0 │        303 │      5.71 │         0.77 │
│ scala      │      137290.0 │        247 │      5.51 │         0.76 │
│ kubernetes │      150500.0 │        147 │      4.99 │         0.75 │
│ git        │      140000.0 │        208 │      5.34 │         0.75 │
│ databricks │      132750.0 │        266 │      5.58 │         0.74 │
│ redshift   │      130000.0 │        274 │      5.61 │         0.73 │
│ gcp        │      136000.0 │        196 │      5.28 │         0.72 │
│ hadoop     │      135000.0 │        198 │      5.29 │         0.71 │
│ nosql      │      134415.0 │        193 │      5.26 │         0.71 │
│ pyspark    │      140000.0 │        152 │      5.02 │          0.7 │
│ docker     │      135000.0 │        144 │      4.97 │         0.67 │
│ mongodb    │      135750.0 │        136 │      4.91 │         0.67 │
│ go         │      140000.0 │        113 │      4.73 │         0.66 │
│ r          │      134775.0 │        133 │      4.89 │         0.66 │
│ github     │      135000.0 │        127 │      4.84 │         0.65 │
│ bigquery   │      135000.0 │        123 │      4.81 │         0.65 │
└────────────┴───────────────┴────────────┴───────────┴──────────────┘
  25 rows                                                  5 columns
*/