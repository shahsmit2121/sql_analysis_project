/* 
Questions: What are the top-paying Data Scientist jobs?
- Identify the top 10 highest-paying Data Scientist roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Scientists, offering insights into employment options and location flexibility.
*/

SELECT
    jobs_postings.job_id,
    jobs_postings.job_title,
    jobs_postings.job_location,
    comp.name,
    jobs_postings.job_schedule_type,
    jobs_postings.salary_year_avg,
    jobs_postings.job_posted_date
FROM 
    job_postings_fact AS jobs_postings
INNER JOIN company_dim AS comp ON jobs_postings.company_id = comp.company_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;