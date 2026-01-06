# ☕ Coffee Shop Sales Analysis (SQL Project)

📌 **Project Overview**
This project involves an end-to-end analysis of retail sales data for a coffee shop business. The goal was to transform raw transaction records into a dynamic dashboard that helps stakeholders understand sales trends, customer behavior, and product performance.
<img width="732" height="469" alt="Coffeeshopsales Dashboard" src="https://github.com/user-attachments/assets/267cd527-8cc6-4952-83bf-7baf6b8402a4" />

🛠️ **Tech Stack**
Database: MySQL
Language: SQL (Data Cleaning, Analysis, Window Functions)
Visualization: Power BI / Excel

🔍 **Key Features & Analysis**
The project focuses on the following Key Performance Indicators (KPIs) and dimensions:

**Data Cleaning**:
Standardized transaction_date and transaction_time formats using SQL STR_TO_DATE.
Handled data types modifications for accurate time-series analysis.
**Time Series Analysis**:
Monthly Sales: Calculated Total Sales, Orders, and Quantity sold.
MoM Growth: Used SQL Window Functions (LAG) to calculate month-over-month percentage increase/decrease.
Hourly & Weekly Trends: Identified peak trading hours and compared Weekend vs. Weekday revenue to assist with workforce planning.
Product & Location Analysis:
Store Performance: Ranked sales by store location (Hell's Kitchen, Lower Manhattan, Astoria).
Product Breakdown: Analyzed sales distribution across categories (Coffee, Tea, Bakery) and specific product types.

📂 SQL Techniques Used
**CTEs (Common Table Expressions)**: For calculating monthly averages and sales aggregation.
**Window Functions**: LAG() for previous month comparisons and AVG() OVER() for daily sales status.
**Case Statements**: For conditional logic (e.g., Categorizing "Weekend" vs. "Weekday" or "Above Average" sales days).
**Date/Time Functions**: MONTH(), HOUR(), DAYOFWEEK() for temporal segmentation.


