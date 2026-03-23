# SQL Data Cleaning & Exploratory Data Analysis – Layoffs Dataset

## Overview

This project demonstrates a comprehensive data cleaning and exploratory data analysis (EDA) workflow using MySQL. The objective is to transform raw layoffs data into a clean, structured, and analysis-ready dataset, and then extract meaningful insights regarding global layoff trends.

You can download the dataset from:

* https://www.kaggle.com/datasets/swaptr/layoffs-2022
* https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv

---

## Objectives

* Remove duplicate records
* Standardize inconsistent data entries
* Handle missing and null values
* Convert data types for accuracy
* Perform exploratory data analysis to identify trends and insights
* Prepare the dataset for downstream analysis and visualization

---

# Data Cleaning

## Key Steps

### 1. Data Staging

A staging table was created to preserve the integrity of the raw dataset. All transformations were performed on this copy to ensure the original data remained unchanged.

### 2. Duplicate Removal

* Identified duplicate records using the `ROW_NUMBER()` window function
* Removed redundant entries while retaining the first occurrence

### 3. Data Standardization

* Trimmed leading and trailing whitespace from text fields
* Standardized categorical values (e.g., industry and country)
* Consolidated inconsistent entries (e.g., "Crypto%" → "Crypto")

### 4. Data Type Conversion

* Converted date fields from text format to the `DATE` data type to enable time-series analysis

### 5. Handling Missing Values

* Identified NULL and empty values across key columns
* Used self-joins to populate missing industry values based on company-level data
* Removed records with insufficient or unusable information

### 6. Final Cleanup

* Dropped temporary/helper columns used during transformation
* Produced a clean dataset ready for analysis

---

# Exploratory Data Analysis (EDA)

## Overview

After cleaning the dataset, exploratory data analysis was conducted to uncover key patterns and trends in global layoffs across companies, industries, and regions.

---

## Key Analysis Areas

### 1. Maximum Layoffs

* Identified the highest number of employees laid off in a single event
* Examined the maximum percentage of workforce affected
* Highlighted companies that laid off 100% of their employees

---

### 2. Layoffs by Company, Industry, and Country

* Aggregated total layoffs by company to identify the most impacted organizations
* Analyzed layoffs by industry to determine which sectors were most affected
* Evaluated layoffs by country to understand geographic distribution

---

### 3. Time-Based Analysis

* Determined the overall time range of the dataset
* Identified dates with the highest number of layoffs
* Analyzed yearly trends to identify peak layoff periods

---

### 4. Rolling (Cumulative) Layoffs Over Time

* Calculated monthly total layoffs
* Computed a cumulative rolling total to track how layoffs evolved over time
* Validated cumulative values against overall totals for consistency

---

### 5. Top Companies by Layoffs Per Year

* Grouped data by company and year
* Ranked companies using `DENSE_RANK()` based on annual layoffs
* Identified the top 5 companies with the highest layoffs for each year

---

## Key Insights

* A notable number of companies experienced complete workforce layoffs (100%)
* Layoffs were heavily concentrated in specific industries, particularly within the technology sector
* Certain periods showed sharp spikes in layoffs, reflecting broader economic or market shifts
* A small group of companies contributed disproportionately to total layoffs

---

## Tools Used

* MySQL
* SQL (Window Functions, Joins, Aggregations, Data Cleaning Techniques)

---

## Outcome

The project results in a clean and structured dataset, along with meaningful insights into layoff trends. It provides a strong foundation for further analysis, dashboard creation, and data-driven decision-making.

---

## Author

**Khalid Abdikarim Adow**

---

## Notes

This project highlights practical SQL techniques used in real-world data cleaning and exploratory analysis workflows, making it a strong foundation for data analytics and data engineering roles.
