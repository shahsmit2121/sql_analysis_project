# Introduction
🗃️ Dive into the data job market! Focusing on data scientist roles, this project explores 💰 top_paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data science.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
In today’s rapidly evolving data landscape, understanding which skills truly drive high-paying opportunities is critical. This project analyzes the data scientist job market to uncover top-paying roles, in-demand skills, and the technologies that maximize career growth.

Using a real-world dataset from a SQL course, this project explores job postings containing detailed information on salaries, locations, job titles, and required skill sets. Through structured SQL queries and data analysis, the goal is to bridge the gap between learning data science and applying it effectively in the job market.

## 🔍 Key Questions Explored:

1. What are the highest-paying data scientist roles?
2. Which skills are required for these top-paying positions?
3. What skills are most in demand across the data science job market?
4. Which technologies are associated with higher salaries?
5. What are the most optimal skills to learn to maximize career opportunities?

# Tools I Used
To conduct a comprehensive analysis of the data scientist job market, I leveraged the following tools and technologies:

- **SQL:** The foundation of this project, used to query and analyze job posting data to extract meaningful insights.
- **PostgreSQL:** Served as the database management system for storing and efficiently handling large volumes of job-related data.
- **Visual Studio Code:** Used as the primary development environment for writing and executing SQL queries.
- **Git & GitHub:** Enabled version control, project tracking, and sharing of code and analysis in a structured and collaborative manner.

# Analysis
Each query for this project aimed at investigating specific aspects of the data scientist job market.
Here's how I approached each question:

### 1. Top Paying Data Scientist Jobs

To identify the highest-paying roles, I filtered data scientist positions based on average yearly salary and location, focusing on remote opportunities. This query highlights the most lucrative roles in the data science field.

```
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
```

Here's the breakdown of the top data analyst jobs in 2023:
- **Extremely High Salary Ceiling:** The top roles range from $300,000 to $550,000, with the highest-paying role (Staff Data Scientist / Quant Researcher) reaching $550K, highlighting the massive earning potential at senior levels.
- **Senior & Leadership Roles Dominate:** Most top-paying positions are Head, Director, or Staff-level roles, showing that compensation increases significantly with experience, leadership, and strategic impact.
- **Quant & Specialized Roles Pay the Most:** Roles like Quant Researcher and niche domains (e.g., battery data science) command premium salaries, indicating that domain expertise + data science = higher pay.
- **Strong Demand Across Companies:** Companies like Selby Jennings, Demandbase, Reddit, and Walmart appear in the top listings, showing that both startups and large enterprises compete heavily for top data science talent.

![Top Paying Roles](/assets/query1_image.png)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; Gemini generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs

To understand which skills are required for the highest-paying roles, I joined the job postings data with the skills dataset. This provides insight into what employers prioritize for high-compensation data scientist positions.

```
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
```

Here are the key points from this data analysis:

- **Foundational Languages are Crucial:** Python and SQL emerged as the absolute most in-demand technical skills for top-paying Data Science roles, followed closely by Java.
- **Deep Learning and Big Data Reign Supreme:** Employers paying top-of-market salaries specifically require expertise in deep learning frameworks (TensorFlow, PyTorch) and big data processing technologies (Spark).
- **Cloud Ecosystems are Mandatory:** There is a strong emphasis on cloud platforms and related infrastructure, with specific mentions of AWS, Azure, GCP, and containerization systems like Kubernetes for deploying these models.

![Count of skills for top 10 paying jobs](/assets/query2_image.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; Gemini generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Scientist

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```
SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_location = 'Anywhere'
GROUP BY 
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

- **Python and SQL lead:** They overwhelmingly dominate the job market as the absolute most required foundational skills.
- **R remains relevant:** It maintains a strong third-place position for statistical computing and analysis.
- **Cloud and visualization are key:** AWS and Tableau round out the top five, emphasizing the need for model deployment and clear communication.

| skills | demand_count |
|--------|--------------|
| python | 10390 |
| sql | 7488 |
| r | 4674 |
| aws | 2593 |
| tableau | 2458 |

*Table of the demand for the top 5 skills in data scientist job postings*

### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```
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
```

Here are the short key points from this data:

- **Workflow tools indicate leadership:** Skills like Asana, Airtable, and Slack being at the top suggest that cross-functional collaboration and project management capabilities are highly valued in senior or leadership Data Science roles.
- **Niche languages pay a premium:** Proficiency in less common but specialized programming languages like Elixir, Lua, Solidity, and Ruby on Rails leads to significant financial rewards due to talent scarcity.
- **AI and specialized infrastructure remain lucrative:** Experience with enterprise AI (Watson), advanced machine learning (Hugging Face, Theano), and specific infrastructure tools (Redhat, Neo4j) reliably pushes average salaries above the $150k–$160k mark.

| Skill         | Average Salary   |
|:--------------|:-----------------|
| Asana         | $215,477.38      |
| Airtable      | $201,142.86      |
| Redhat        | $189,500.00      |
| Watson        | $187,417.14      |
| Elixir        | $170,823.56      |
| Lua           | $170,500.00      |
| Slack         | $168,218.76      |
| Solidity      | $166,979.90      |
| Ruby On Rails | $166,500.00      |
| Rshiny        | $166,436.21      |
| Notion        | $165,636.36      |
| Objective-C   | $164,500.00      |
| Neo4J         | $163,971.09      |
| Dplyr         | $163,111.06      |
| Hugging Face  | $160,867.72      |
| Dynamodb      | $160,581.13      |
| Haskell       | $157,500.00      |
| Unity         | $156,881.25      |
| Airflow       | $155,878.41      |
| Codecommit    | $154,683.52      |
| Unreal        | $153,278.33      |
| Theano        | $153,133.41      |
| Zoom          | $151,676.89      |
| Bigquery      | $149,291.75      |
| Atlassian     | $148,714.59      |

*Table of the average salary for the top 10 paying skills for data scientists*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY    
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

Here are three key points derived from this data:

- **The Machine Learning & Big Data "Sweet Spot":** Skills like PyTorch, TensorFlow, and Spark offer the most optimal balance, combining high market demand (over 100 job postings each) with excellent compensation (averaging over $150,000).
- **Specialized Languages Command a Premium:** While foundational languages like Python offer the highest sheer volume of job security (763 postings), niche languages like C and Go command the absolute highest average salaries (nearly $165,000) due to a scarcity of talent.
- **Cloud & Infrastructure Skills are Highly Lucrative:** Expertise in cloud platforms (AWS, GCP) and modern data warehousing (Snowflake, BigQuery, Redshift) consistently correlate with high salaries, proving that knowing how to store and deploy data is just as valuable as analyzing it.

| Skill ID | Skills | Demand Count | Average Salary |
|:---|:---|:---|:---|
| 26 | C | 48 | $164,864.98 |
| 8 | Go | 57 | $164,691.09 |
| 187 | Qlik | 15 | $164,484.64 |
| 185 | Looker | 57 | $158,714.91 |
| 96 | Airflow | 23 | $157,414.13 |
| 77 | BigQuery | 36 | $157,142.36 |
| 3 | Scala | 56 | $156,701.92 |
| 81 | GCP | 59 | $155,810.57 |
| 80 | Snowflake | 72 | $152,686.88 |
| 101 | PyTorch | 115 | $152,602.70 |
| 78 | Redshift | 36 | $151,708.14 |
| 99 | TensorFlow | 126 | $151,536.49 |
| 233 | Jira | 22 | $151,164.55 |
| 92 | Spark | 149 | $150,188.49 |
| 76 | AWS | 217 | $149,629.96 |
| 94 | NumPy | 73 | $149,089.24 |
| 106 | Scikit-Learn | 81 | $148,963.95 |
| 95 | PySpark | 34 | $147,544.45 |
| 182 | Tableau | 219 | $146,970.05 |
| 2 | NoSQL | 31 | $146,110.28 |
| 4 | Java | 64 | $145,706.30 |
| 196 | PowerPoint | 23 | $145,139.04 |
| 93 | Pandas | 113 | $144,815.95 |
| 213 | Kubernetes | 25 | $144,497.96 |
| 1 | Python | 763 | $143,827.93 |

*Table of the most optimal skills for data scientist sorted by salary*

# What I Learned

Throughout this adventure, I leveled up my data game and packed my toolkit with some serious data scientist firepower:

- **🧩 Complex Query Crafting:** Mastered advanced SQL by stitching together datasets like a pro, using joins and WITH clauses to uncover hidden insights in job market data.
- **📊 Data Crunching Magic:** Got hands-on with GROUP BY, COUNT(), and AVG()—turning raw data into clean, meaningful patterns around salaries, skills, and demand.
- **🤖 Data Science Thinking:** Transformed real-world career questions into sharp, insight-driven queries—bridging the gap between raw data and smart decision-making.

# Conclusions

From the analysis, several key trends emerged in the data scientist job market:

- **Top-Paying Data Scientist Roles:** Salaries for top roles range from $300K to $550K, with senior positions like Staff, Head, and Director-level - roles dominating the highest pay brackets.
- **Core Skills Drive the Market:** Python and SQL overwhelmingly lead as the most in-demand foundational skills, making them essential for any data science role.
- **AI, Big Data & Cloud Define High Salaries:** Expertise in deep learning (TensorFlow, PyTorch), big data tools (Spark), and cloud platforms (AWS, GCP, Azure) is strongly associated with top-tier compensation.
- **Niche & Specialized Skills Command Premium Pay:** Less common technologies (e.g., Elixir, Solidity, Neo4j) and domain-specific roles (like quant research) offer higher salaries due to talent scarcity and specialization.
- **Modern Data Scientists Need Hybrid Skills:** The most valuable profiles combine machine learning, data engineering, and cloud/MLOps, showing that top-paying roles go beyond traditional analytics.