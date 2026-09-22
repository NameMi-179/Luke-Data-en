/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/
SELECT 
    ssd.skills,
    ROUND(MEDIAN(jf.salary_year_avg),0) AS median_salary,
    COUNT(jf.job_id) AS demand_count
FROM job_postings_fact AS jf
INNER JOIN skills_job_dim AS sd
    ON jf.job_id = sd.job_id
INNER JOIN skills_dim AS ssd
    ON sd.skill_id = ssd.skill_id
WHERE
    jf.job_title_short = 'Data Engineer' AND jf.job_work_from_home = True
GROUP BY 
    ssd.skills
HAVING
    COUNT(jf.*) > 1000
ORDER BY 
    median_salary DESC
LIMIT 25;

/*
┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ terraform  │      184000.0 │         3248 │
│ kubernetes │      150500.0 │         4202 │
│ airflow    │      150000.0 │         9996 │
│ kafka      │      145000.0 │         6415 │
│ pyspark    │      140000.0 │         4898 │
│ git        │      140000.0 │         4641 │
│ go         │      140000.0 │         1997 │
│ pandas     │      140000.0 │         2929 │
│ spark      │      140000.0 │        12799 │
│ aws        │      137320.0 │        17823 │
│ scala      │      137290.0 │         6304 │
│ dynamodb   │      136000.0 │         1082 │
│ gcp        │      136000.0 │         6446 │
│ looker     │      136000.0 │         1574 │
│ mongodb    │      135750.0 │         3512 │
│ snowflake  │      135500.0 │         8639 │
│ hadoop     │      135000.0 │         5447 │
│ jenkins    │      135000.0 │         1867 │
│ docker     │      135000.0 │         4316 │
│ python     │      135000.0 │        28776 │
│ bigquery   │      135000.0 │         3523 │
│ java       │      135000.0 │         7267 │
│ github     │      135000.0 │         1987 │
│ r          │      134775.0 │         2336 │
│ nosql      │      134415.0 │         4514 │
└────────────┴───────────────┴──────────────┘
  25 rows                         3 columns
*/