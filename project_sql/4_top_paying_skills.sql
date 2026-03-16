/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Scientist positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Scientists and 
helps identify the most financially rewarding to acquire or improve
*/

SELECT
    skills_dim.skills,
   ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL 
    --AND job_location = 'Anywhere'
GROUP BY 
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
Niche and rare technologies pay the most – Skills like Elixir, Lua, and Haskell command higher salaries because fewer data scientists specialize in them.
AI and advanced ML tools are highly valued – Technologies like Hugging Face and IBM Watson appear in high-paying roles, reflecting strong demand for AI and NLP expertise.
Data infrastructure and cloud skills increase salaries – Tools such as Apache Airflow, Google BigQuery, and Amazon DynamoDB show that companies pay more for data scientists who can build and manage large-scale data systems.
Some high-paying roles require cross-functional collaboration – Tools like Asana and Slack suggest that senior data scientists often work closely with product and engineering teams.

[
  {
    "skills": "asana",
    "avg_salary": "215477.38"
  },
  {
    "skills": "airtable",
    "avg_salary": "201142.86"
  },
  {
    "skills": "redhat",
    "avg_salary": "189500.00"
  },
  {
    "skills": "watson",
    "avg_salary": "187417.14"
  },
  {
    "skills": "elixir",
    "avg_salary": "170823.56"
  },
  {
    "skills": "lua",
    "avg_salary": "170500.00"
  },
  {
    "skills": "slack",
    "avg_salary": "168218.76"
  },
  {
    "skills": "solidity",
    "avg_salary": "166979.90"
  },
  {
    "skills": "ruby on rails",
    "avg_salary": "166500.00"
  },
  {
    "skills": "rshiny",
    "avg_salary": "166436.21"
  },
  {
    "skills": "notion",
    "avg_salary": "165636.36"
  },
  {
    "skills": "objective-c",
    "avg_salary": "164500.00"
  },
  {
    "skills": "neo4j",
    "avg_salary": "163971.09"
  },
  {
    "skills": "dplyr",
    "avg_salary": "163111.06"
  },
  {
    "skills": "hugging face",
    "avg_salary": "160867.72"
  },
  {
    "skills": "dynamodb",
    "avg_salary": "160581.13"
  },
  {
    "skills": "haskell",
    "avg_salary": "157500.00"
  },
  {
    "skills": "unity",
    "avg_salary": "156881.25"
  },
  {
    "skills": "airflow",
    "avg_salary": "155878.41"
  },
  {
    "skills": "codecommit",
    "avg_salary": "154683.52"
  },
  {
    "skills": "unreal",
    "avg_salary": "153278.33"
  },
  {
    "skills": "theano",
    "avg_salary": "153133.41"
  },
  {
    "skills": "zoom",
    "avg_salary": "151676.89"
  },
  {
    "skills": "bigquery",
    "avg_salary": "149291.75"
  },
  {
    "skills": "atlassian",
    "avg_salary": "148714.59"
  }
]
*/