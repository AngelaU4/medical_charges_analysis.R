# 📊 Data Analytics: Financial Risk Analysis in Healthcare Insurance

## 📋 Overview
This project provides an end-to-end exploratory and descriptive data analysis (EDA) to evaluate how health risk factors—specifically tobacco usage and Body Mass Index (BMI)—exponentially impact individual medical billing charges. 

The analysis is developed entirely in R, showcasing data cleaning, automated risk alerting systems, advanced descriptive statistics, and multi-variable data visualizations.

## 🛠️ Project Structure & R Script Workflow
The core analysis script (`Taller_Semana2_SIC.R`) is structured into sequential, production-ready blocks:
* **Data Cleansing & Wrangling (Steps 1-4):** Package management (`tidyverse`), cloud data ingestion, dimensional auditing, and data quality filtering (handling missing values and structural duplicates).
* **Automated Risk Engine (Step 6):** An iterative conditional pipeline (`for` loops and nested `if/else` logic) that categorizes patient BMI into clinical risk states.
* **Advanced Descriptive Analytics (Step 8):** Quantitative evaluation of central tendency, dispersion (variance and standard deviation), and distribution geometry (skewness and kurtosis using the `e1071` library).
* **Data Visualization (Step 9):** High-quality, tailored plots using `ggplot2` (including density histograms, demographic bar charts, and multivariate boxplots).
* **Statistical Outlier Detection (Step 10):** Implementation of Tukey's Interquartile Range (IQR) method to isolate and analyze high-cost clinical anomalies.

## 🚀 Key Analytical Insights
1. **The Risk Multiplier Effect:** Tobacco consumption combined with clinical obesity (BMI >= 30) acts as an exponential cost driver, pushing annual individual medical charges above $40,000 USD, while non-smokers maintain stable costs regardless of weight.
2. **Distribution Geometry:** Medical billing shows a heavy right-skewed (positive skewness) and leptokurtic distribution. The sample mean ($13,270 USD) is significantly higher than the median ($9,382 USD) due to a critical 10.4% of high-severity patient outliers.
3. **Data-Driven Retention Choice:** Outliers were deliberately kept in the main model. In healthcare analytics, these data points represent real, high-impact clinical events rather than system errors; removing them would severely underestimate the financial reserves required by the insurance provider.

---
*Developed as a personal data science portfolio project.*