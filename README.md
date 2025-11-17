# 🍕 Pizza Inventory Analytics — SQL + Looker Studio + Google Cloud

This project analyzes pizza inventory, sales performance, and ingredient usage using SQL and cloud-based analytics tools.
It includes database design, data modeling, SQL queries, and an interactive dashboard built in Looker Studio.

---
# ⭐ Project Overview
The goal of this project is to track pizza sales, understand inventory usage, and identify trends using a fully cloud-based setup:

1. Google Cloud SQL hosts the relational database

2. Navicat Premium is used to manage and query the SQL database

3. Google Cloud Storage stores the CSV data

4. Looker Studio is used to create a dynamic analytics dashboard

---
# 🧰 Tools & Technologies
SQL (MySQL dialect)

Google Cloud SQL

Google Cloud Storage (GCS)

Navicat Premium

Looker Studio (for dashboard & reporting)

ERD / schema design

---
# 📂 Project Structure

pizza-inventory-analytics/

│── data/

│     └── pizza_data.csv


│── sql/

│     └── create_tables.sql

│     └── insert_data.sql

│     └── analytics_queries.sql

│── dashboard/

│     └── looker_screenshot1.png

│     └── looker_screenshot2.png

│── README.md

---
# 📊 Dashboard Insights (Looker Studio)
Includes visualizations for:

Total sales & revenue

Top-selling pizza categories

Inventory usage by ingredient

Daily & monthly sales trends

Order volume peak hours

Cost vs. waste analysis

---
# 🗄️ Database Design
Normalized tables for orders, pizzas, ingredients, and inventory

Primary/foreign key relationships

All SQL scripts included for recreation

Queries optimized for Looker Studio reporting

---
# How the Project Works
Upload CSV files to Google Cloud Storage

Import data into Cloud SQL using Navicat Premium

Run SQL scripts to clean and model the data

Connect Cloud SQL to Looker Studio

Build dashboard visualizations
