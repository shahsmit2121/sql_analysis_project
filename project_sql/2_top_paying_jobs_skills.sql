/*
Question: What skills are required for the top-paying Data Scientist jobs?
- Use the top 10 highest-paying Data Scientist jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which skills to develop that align with top salaries
*/
WITH top_paying_jobs AS (
    SELECT
        jobs_postings.job_id,
        jobs_postings.job_title,
        comp.name,
        jobs_postings.salary_year_avg
    FROM 
        job_postings_fact AS jobs_postings
    INNER JOIN company_dim AS comp ON jobs_postings.company_id = comp.company_id
    WHERE
        job_title_short = 'Data Scientist' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY  
    top_paying_jobs.salary_year_avg DESC;

/*
SQL and Python appear the most (top skills).
Java is also relatively common, indicating some roles involve engineering-heavy data work.
Spark, TensorFlow, PyTorch, and AWS appear multiple times, suggesting big data + ML + cloud skills are valued even for analyst roles.
Other tools like Tableau, Pandas, NumPy, Scikit-learn, Hadoop, and Kubernetes appear but less frequently.

[
  {
    "job_id": 40145,
    "job_title": "Staff Data Scientist/Quant Researcher",
    "name": "Selby Jennings",
    "salary_year_avg": "550000.0",
    "skills": "sql"
  },
  {
    "job_id": 40145,
    "job_title": "Staff Data Scientist/Quant Researcher",
    "name": "Selby Jennings",
    "salary_year_avg": "550000.0",
    "skills": "python"
  },
  {
    "job_id": 1714768,
    "job_title": "Staff Data Scientist - Business Analytics",
    "name": "Selby Jennings",
    "salary_year_avg": "525000.0",
    "skills": "sql"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "sql"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "python"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "java"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "cassandra"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "spark"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "hadoop"
  },
  {
    "job_id": 1131472,
    "job_title": "Data Scientist",
    "name": "Algo Capital Group",
    "salary_year_avg": "375000.0",
    "skills": "tableau"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "azure"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "aws"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "tensorflow"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "keras"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "pytorch"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "scikit-learn"
  },
  {
    "job_id": 126218,
    "job_title": "Director Level - Product Management - Data Science",
    "name": "Teramind",
    "salary_year_avg": "320000.0",
    "skills": "datarobot"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "sql"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "java"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "c"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "aws"
  },
  {
    "job_id": 38905,
    "job_title": "Principal Data Scientist",
    "name": "Storm5",
    "salary_year_avg": "300000.0",
    "skills": "gcp"
  },
  {
    "job_id": 129924,
    "job_title": "Director of Data Science",
    "name": "Storm4",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_id": 129924,
    "job_title": "Director of Data Science",
    "name": "Storm4",
    "salary_year_avg": "300000.0",
    "skills": "pandas"
  },
  {
    "job_id": 129924,
    "job_title": "Director of Data Science",
    "name": "Storm4",
    "salary_year_avg": "300000.0",
    "skills": "numpy"
  },
  {
    "job_id": 457991,
    "job_title": "Head of Battery Data Science",
    "name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "python"
  },
  {
    "job_id": 457991,
    "job_title": "Head of Battery Data Science",
    "name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "aws"
  },
  {
    "job_id": 457991,
    "job_title": "Head of Battery Data Science",
    "name": "Lawrence Harvey",
    "salary_year_avg": "300000.0",
    "skills": "gcp"
  }
]
*/