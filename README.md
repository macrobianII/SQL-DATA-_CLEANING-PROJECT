# SQL-DATA-_CLEANING-PROJECT
End-to-end SQL data cleaning project transforming raw layoffs data into an analysis-ready dataset.
# SQL Data Cleaning Project – Layoffs Dataset

## Overview

This project demonstrates a complete data cleaning workflow using MySQL. The goal is to transform raw layoff data into a structured and analysis-ready dataset.
Use This link to download the dataset https://www.kaggle.com/datasets/swaptr/layoffs-2022 or 
https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv

## Objectives

* Remove duplicate records
* Standardize inconsistent data entries
* Handle missing and null values
* Convert data types for accuracy
* Prepare the dataset for further analysis

## Key Steps

### 1. Data Staging

A staging table was created to preserve the integrity of the original dataset. All transformations were performed on the copied data.

### 2. Duplicate Removal

* Identified duplicates using `ROW_NUMBER()`
* Removed redundant records while retaining the first occurrence

### 3. Data Standardization

* Trimmed whitespace from text fields
* Standardized categorical values (e.g., industry, country)
* Unified inconsistent entries (e.g., "Crypto%" → "Crypto")

### 4. Data Type Conversion

* Converted date fields from text format to proper `DATE` type for time-series analysis

### 5. Handling Missing Values

* Identified NULL and empty values
* Used self-joins to populate missing industry values based on company
* Removed records with insufficient data

### 6. Final Cleanup

* Dropped temporary/helper columns
* Produced a clean dataset ready for analysis

## Tools Used

* MySQL
* SQL (Window Functions, Joins, Data Cleaning Techniques)

## Outcome

A cleaned and standardized dataset suitable for exploratory data analysis (EDA) and visualization.

---

## Author

KHALID ABDIKARIM ADOW

## Notes

This project focuses on practical SQL data cleaning techniques commonly used in real-world data workflows.
