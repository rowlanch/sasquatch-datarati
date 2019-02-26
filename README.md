# Sasquatch and the Datarati Data Mining Project
---
This project was done for a course project in MKTG 708 Customer Relationship Management and Data Mining, a Business Analytics elective in the PMBA program of the Darla Moore School of Business at the University of South Carolina.  The team for this project was:  Robert Mashburn, Richard Klemm, Clay Rowland, James (Brent) Varitz, and Mark Sarver.

The source code can be found on [GitHub](https://github.com/rowlanch/sasquatch-datarati).

---
## Introduction 
Hospitals and medical service providers have a need to project future service volumes and revenues for financial and operational planning.  For many of these organizations, Medicare patients make up a large percentage of their customer base.  If they can accurately predict Medicare patient volumes, they can make decisions on staffing, capital expenditure, organizational finance-mix, and inform investor relations reports.

---
## Proposed Objective
The objective of this project is to produce a predictive model using data from the Centers for Disease Control and Prevention, and the Centers for Medicare and Medicaid Services that accurately predicts Medicare service volumes.

---
## Sources of Data
The sources of data for this project are as follows:

1.	[CDC - 500 Cities: Local Data for Better Health](https://www.cdc.gov/500cities/)

2.	[CMS - Medicare Provider Utilization and Payment Data: Physician and Other Supplier PUF](https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/medicare-provider-charge-data/physician-and-other-supplier.html)


----
## Programs
Execute the programs in the following order to recreate the models used in this project:

**1. load-data.sas:** This program will download and load data from Medicare and 500 Cities to initialize the library and raw data sets for the project.  This program calls download-data.sas and 7 different load programs to execute the load routine.

**2. transform-and-join.sas:**  This program will clean, transform, and join datasets from Medicare and 500 Cities to prepare the raw data for model estimation.

**3. estimate-model.sas:**  This program builds three different regression models based on the three categores of 500 Cities Survey data.  It uses the PROC REG and its STEPWISE selection method to optimize the models.   The models are scored using PROC score and then MAE and RMSE values are calculated to compare the three models.  Finally, it performs some analysis of the error rates of the OUTCOME model.

The following programs were used to explore the raw data sets:

**4. analyze-attributes.sas:**  This program explores the 500 Cities and Medicare datasets to gain insight into model estimation

**5. outlier-analysis.sas:** This program produces plots that analyze the observations that are outliers and/or exert leverage over the model.  Extreme prejudice was used in the removal of outliers so as to not overfit the model.

**6. cancer-plot.sas:**  This program creates a plot of total_services vs population and the prevalance of cancer in the population