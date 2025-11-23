# Mental Health in the Tech Industry Analysis

## Project Overview

This project analyzes the data from surveys conducted by Open Source Mental Illness (OSMI) between 2014 and 2019. The surveys focus on mental health issues and attitudes towards mental health in the tech workplace. The dataset includes responses from employees of various tech companies and provides valuable insights into how mental health is perceived and reported in the industry.

The goal of this project is to identify and analyze common mental health conditions within employees working in tech companies. We explore various aspects of the data, including respondent demographics, career levels, and prevalent mental health issues.

## Dataset Overview

## Dataset

[**Kaggle**: Coursera Course Dataset](https://www.kaggle.com/code/tasneemhesham/mental-health-in-tech-industries-analysis)

The dataset is stored in an **SQLite** database and contains three primary tables:

The data is organized into three tables in an **SQLite** database:

**Survey**

- SurveyID (PRIMARY KEY)
- Description (TEXT)

**Question**

- QuestionID (PRIMARY KEY)
- QuestionText (TEXT)

**Answer**

- UserID (PRIMARY KEY)
- SurveyID (FOREIGN KEY)
- QuestionID (FOREIGN KEY)
- AnswerText (TEXT)

## Key Questions and Insights

The following questions guide the analysis and exploration of the dataset:

- How many respondents' data are available from 2014 to 2019?
This explores the frequency of surveys completed and the number of respondents per year.

- What is the distribution of respondents' ages?
This provides insights into the age groups most represented in the survey data.

- What is the career level among respondents based on age?
This examines career level demographics in the survey responses.

- What is the gender distribution of respondents?
This identifies the gender breakdown of respondents to better understand diversity within the dataset.

- Which countries/continents do the respondents live in?
This explores the global reach of the survey, identifying where respondents are located geographically.

- What are the most common mental health issues reported by respondents?
This looks at the types of mental health issues that are most prevalent among respondents.

- What are the most common mental health issues among respondents in tech companies?
This focuses specifically on the tech industry to identify the key mental health challenges.

## Usage

```python
import sqlite3 as sql
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from Functions import *
```

## Getting Started

To run this project, follow these steps:

- Ensure you have Python 3.x installed.
- [**VisualStudio Marketplace**: SQLite](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite)
- Install the required libraries by running:

```bash
pip install pandas matplotlib seaborn
```

- Download the dataset and the database files.
- Open the project and run the Python scripts
