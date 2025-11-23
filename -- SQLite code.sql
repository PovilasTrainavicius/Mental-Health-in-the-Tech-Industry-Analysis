-- Answers Table
SELECT *
FROM Answer;


--Question Table
SELECT * 
FROM Question;


--Survey Table
SELECT * 
FROM Survey;


-- Full Table
SELECT 
    a.UserID AS user_id,
    a.SurveyID AS year,
    a.QuestionID AS question_id,
    o.QuestionText AS question,
    a.AnswerText AS answer_text
FROM Answer a
JOIN Question o ON a.QuestionID = o.QuestionID
JOIN Survey s ON a.SurveyID = s.SurveyID
ORDER BY 1;


--Respondents Percentage
WITH unique_user_year AS (
    SELECT 
        SurveyID AS year,
        COUNT(DISTINCT UserID) AS unique_users
    FROM Answer
    GROUP BY 1
),
total_unique_user AS (
    SELECT 
        COUNT(DISTINCT UserID) AS total_unique_users
    FROM Answer
)
SELECT 
    u.year,
    u.unique_users,
    (u.unique_users * 100.0 / t.total_unique_users) AS percentage
FROM unique_user_year u
JOIN total_unique_user t
ORDER BY 1 DESC;


-- Unique Answers
SELECT 
    o.QuestionID AS question_id,
    o.questiontext AS question,
    a.AnswerText AS answer_text,
    COUNT(*) AS total
FROM Answer a
JOIN Question o ON a.QuestionID = o.QuestionID
GROUP BY 1
ORDER BY 1;


-- Respondents Gender
WITH respondents_gender AS (
    SELECT 
        CASE 
            WHEN a.AnswerText = "Male" THEN "Male"
            WHEN a.AnswerText = "Female" THEN "Female"
            WHEN a.AnswerText = "-1" THEN "No Response"
            ELSE "Other/Unknown"
        END AS gender
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 2
),
gender_counts AS (
    SELECT 
        gender,
        COUNT(*) AS total
    FROM respondents_gender
    GROUP BY 1
),
total_respondents AS (
    SELECT 
        SUM(total) AS total_count
    FROM gender_counts
)
SELECT 
    g.gender,
    g.total,
    (g.total * 100.0 / t.total_count) AS percentage
FROM gender_counts g
JOIN total_respondents t
ORDER BY 2 DESC;


--Respondents Age
SELECT 
    o.QuestionText AS question,
    ABS(CAST(a.AnswerText AS INT)) AS age
FROM Answer a
JOIN Question o ON a.QuestionID = o.QuestionID
WHERE a.QuestionID = 1
    AND CAST(a.AnswerText AS INT) <= 100
ORDER BY 2 DESC;


--Working Age
SELECT 
        o.QuestionText AS question,
        CAST(a.AnswerText AS INT) AS age
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 1
    ORDER BY 2;


--Working Age Category
WITH respondents_age AS (
SELECT 
    o.QuestionText AS question,
    ABS(CAST(a.AnswerText AS INT)) AS answer_text
FROM Answer a
JOIN Question o ON a.QuestionID = o.QuestionID
WHERE a.QuestionID = 1
    AND CAST(a.AnswerText AS INT) <= 100
ORDER BY 2 DESC
),
career_levels AS (
    SELECT 
        CASE 
            WHEN answer_text BETWEEN 16 AND 30 THEN "Early Work Life"
            WHEN answer_text BETWEEN 31 AND 45 THEN "Mid-Career"
            WHEN answer_text BETWEEN 46 AND 60 THEN "Late Career"
            WHEN answer_text BETWEEN 61 AND 65 THEN "Pre-Retirement"
        END AS career_level,
        COUNT(*) AS total
    FROM respondents_age
    WHERE answer_text >= 16
        AND answer_text <= 65
    GROUP BY career_level
),
total_respondents AS (
    SELECT 
        SUM(total) AS total_count
    FROM career_levels
)
SELECT 
    c.career_level,
    c.total,
    (c.total * 100.0 / t.total_count) AS percentage
FROM career_levels c
JOIN total_respondents t
ORDER BY c.total DESC;


--Respondents Gender
SELECT 
    o.QuestionText AS question,
    a.AnswerText AS gender
FROM Answer a
JOIN Question o ON a.QuestionID = o.QuestionID
WHERE a.QuestionID = 2
ORDER BY 2 DESC;


--Respondents Country
WITH respondents_country AS (
    SELECT 
        REPLACE(a.AnswerText, "United States of America", "United States") AS country
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 3
),
country_counts AS (
    SELECT 
        country,
        COUNT(*) AS total
    FROM respondents_country
    GROUP BY 1
)
SELECT 
    country,
    total
FROM country_counts
ORDER BY 2 DESC;


--Respondents Continent
WITH respondents_country AS (
    SELECT 
        CASE
            WHEN a.AnswerText = "United States of America" THEN "United States"
            WHEN a.AnswerText = "United States" THEN "United States"
            ELSE a.AnswerText
        END AS country
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 3
),
country_continent AS (
    SELECT 
        country,
        CASE
            WHEN country IN ("United States", "Canada", "Mexico", "Bahamas, The", "Guatemala", "Costa Rica") THEN "North America"
            WHEN country IN ("United Kingdom", "Germany", "Netherlands", "France", "Ireland", "Sweden", "Switzerland", "Spain", "Portugal", "Poland", "Italy", "Belgium", "Norway", "Austria", "Denmark", "Romania", "Greece", "Bulgaria", "Finland", "Czech Republic", "Estonia", "Croatia", "Hungary", "Serbia", "Bosnia and Herzegovina", "Slovakia", "Iceland", "Latvia", "Lithuania", "Ukraine", "Belarus", "Moldova", "Slovenia", "Turkey") THEN "Europe"
            WHEN country IN ("Australia", "New Zealand") THEN "Oceania"
            WHEN country IN ("India", "Russia", "China", "Japan", "Pakistan", "Bangladesh", "Indonesia", "Israel", "Singapore", "Turkey", "Afghanistan", "Bangladesh", "Hong Kong", "Georgia", "Iran", "Jordan", "Philippines", "Saudi Arabia", "Taiwan", "Thailand", "Vietnam") THEN "Asia"
            WHEN country IN ("Brazil", "Argentina", "Colombia", "Chile", "Uruguay", "Venezuela", "Ecuador") THEN "South America"
            WHEN country IN ("South Africa", "Algeria", "Nigeria", "Kenya", "Mauritius", "Ghana", "Ethiopia", "Uganda", "Zimbabwe") THEN "Africa"
            ELSE "Other"
        END AS continent
    FROM respondents_country
),
total_respondents AS (
    SELECT COUNT(*) AS total_count
    FROM country_continent
)
SELECT 
    c.continent,
    COUNT(*) AS total,
    COUNT(*) * 100.0 / t.total_count AS percentage
FROM country_continent c
JOIN total_respondents t 
GROUP BY 1
ORDER BY 2 DESC;


--State Other Country
WITH state AS (
    SELECT 
        o.QuestionText AS question,
        a.AnswerText AS state
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 4
),
total_respondents AS (
    SELECT COUNT(*) AS total_count
    FROM state
)
SELECT
    CASE 
        WHEN state = "-1" THEN "Other Country"
        WHEN state != "-1" THEN "United States"
    END AS living,
    COUNT(*) AS total,
    (COUNT(*) * 100.0 / t.total_count) AS percentage
FROM state s
JOIN total_respondents t
GROUP BY living
ORDER BY total DESC;


--Total Mental Healt Respondents
WITH mental_health AS (
    SELECT 
        CASE 
            WHEN a.AnswerText = -1 THEN "No Mental Health Problems"
            ELSE a.AnswerText 
        END AS mental_health,
        COUNT(*) AS total
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    JOIN Survey s ON a.SurveyID = s.SurveyID
    WHERE a.QuestionID = 115
    GROUP BY 1
), 
total_respondents AS (
    SELECT COUNT(*) AS total_count
    FROM Answer a
    WHERE a.QuestionID = 115
),
top_mental_health AS (
    SELECT 
        mental_health,
        total
    FROM mental_health
    ORDER BY total DESC
    LIMIT 5
)
SELECT 
    tr.total_count AS total_respondents,
    SUM(th.total) AS total_top5_respondents,
    (SUM(th.total) * 100.0 / tr.total_count) AS percentage
FROM total_respondents tr
JOIN top_mental_health th;


--Mental Healt
WITH mental_health AS (
    SELECT 
        CASE 
            WHEN a.AnswerText = -1 THEN "No Mental Health Problems"
            ELSE a.AnswerText 
        END AS mental_health,
        COUNT(*) AS total
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 115
    GROUP BY 1
), 
total_respondents AS (
    SELECT COUNT(*) AS total_count
    FROM Answer a
    WHERE a.QuestionID = 115
)
SELECT 
    m.mental_health,
    m.total,
    (m.total * 100.0 / t.total_count) AS percentage
FROM mental_health m
JOIN total_respondents t
ORDER BY 3 DESC
LIMIT 10;


--Mental_Healt
WITH respondents_gender AS (
    SELECT 
        a.UserID,
        CASE 
            WHEN a.AnswerText = "Male" THEN "Male"
            WHEN a.AnswerText = "Female" THEN "Female"
            WHEN a.AnswerText = "-1" THEN "No Response"
            ELSE "Other/Unknown"
        END AS gender
    FROM Answer a
    JOIN Question o ON a.QuestionID = o.QuestionID
    WHERE a.QuestionID = 2
),
mental_health AS (
    SELECT 
        CASE 
            WHEN a.AnswerText = "-1" THEN "No Mental Health Problems" 
            ELSE a.AnswerText 
        END AS mental_health,
        rg.gender,
        COUNT(*) AS total
    FROM Answer a
    JOIN respondents_gender rg ON a.UserID = rg.UserID 
    WHERE a.QuestionID = 115
    GROUP BY 1, 2
)
SELECT 
    mh.mental_health,
    mh.gender,
    mh.total,
    (mh.total * 100.0 / SUM(mh.total) OVER (PARTITION BY mh.gender)) AS percentage
FROM mental_health mh
ORDER BY 2, 4 DESC;

--Mental Health 
WITH categorized_users AS (
    SELECT
        q1.UserID,
        CASE
            WHEN q1.AnswerText = 1 THEN 'Tech Company'
            WHEN q1.AnswerText = 0 THEN 'Not Specified'
            ELSE 'Non-Tech Company'
        END AS company,
        CASE 
            WHEN q2.AnswerText = 'Male' THEN 'Male'
            WHEN q2.AnswerText = 'Female' THEN 'Female'
            WHEN q2.AnswerText = '-1' THEN 'No Response'
            ELSE 'Other/Unknown'
        END AS gender,
        CASE 
            WHEN q3.AnswerText = '-1' THEN 'No Mental Health Problems'
            ELSE q3.AnswerText
        END AS mental_health
    FROM Answer q1
    JOIN Answer q2 ON q1.UserID = q2.UserID AND q2.QuestionID = 2
    JOIN Answer q3 ON q1.UserID = q3.UserID AND q3.QuestionID = 115
    WHERE q1.QuestionID = 9
),
grouped_data AS (
    SELECT
        company,
        gender,
        mental_health,
        COUNT(*) AS user_count
    FROM categorized_users
    GROUP BY company, gender, mental_health
)
SELECT
    company,
    gender,
    mental_health,
    user_count,
    (user_count * 100.0 / SUM(user_count) OVER (PARTITION BY gender)) AS percentage
FROM grouped_data
WHERE company = "Tech Company"
ORDER BY gender, mental_health;


-- Tech Companies Productivity Levels
WITH tech_company AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = 1 THEN 'Tech Company'
            WHEN a.AnswerText = 0 THEN 'Not Specified'
            ELSE 'Non-Tech Company'
        END AS company
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 9
),
productivity AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = -1 THEN 'No'
            ELSE a.AnswerText  
        END AS answer
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 54
)
SELECT
    tc.company,
    p.answer,
    COUNT(*) AS total
FROM productivity p
JOIN tech_company tc ON  p.user = tc.user
GROUP BY 1, 2


-- Affected Carrer
WITH tech_company AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = 1 THEN 'Tech Company'
            WHEN a.AnswerText = 0 THEN 'Not Specified'
            ELSE 'Non-Tech Company'
        END AS company
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 9
),
productivity AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = -1 THEN 'No'
            WHEN a.AnswerText = 1 THEN 'Yes'
             ELSE 'Maybe'
        END AS answer
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 79
)
SELECT
    tc.company,
    p.answer,
    COUNT(*) AS total
FROM productivity p
JOIN tech_company tc ON  p.user = tc.user
GROUP BY 1, 2
ORDER BY total DESC;


-- Disccused with employee
WITH tech_company AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = 1 THEN 'Tech Company'
            WHEN a.AnswerText = 0 THEN 'Not Specified'
            ELSE 'Non-Tech Company'
        END AS company
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 9
),
productivity AS (
    SELECT
        a.UserID AS user,
        CASE
            WHEN a.AnswerText = -1 THEN 'No'
            WHEN a.AnswerText = 1 THEN 'Yes'
             ELSE 'Maybe'
        END AS answer
    FROM Answer a
    JOIN Question q ON a.QuestionID = q.QuestionID
    WHERE a.QuestionID = 58
)
SELECT
    tc.company,
    p.answer,
    COUNT(*) AS total
FROM productivity p
JOIN tech_company tc ON  p.user = tc.user
GROUP BY 1, 2