# 🛒 Instacart Data Warehouse on Snowflake

## 📌 Introduction

This project demonstrates the creation of a dimensional data warehouse using Snowflake for the popular **Instacart Online Grocery Shopping Dataset**. It covers everything from data staging using AWS S3 to schema design, fact/dimension table creation, and insightful analytical queries.

It is a hands-on demonstration of cloud data warehousing concepts, dimensional modeling, and SQL analytics — ideal for beginners and aspiring data engineers.

---

## 🧱 Architecture Overview

* **Stage**: Raw CSV files from the Instacart dataset are hosted on Amazon S3 and accessed via an external stage in Snowflake.
* **Load**: Data is loaded into Snowflake tables with appropriate file formats and staging configurations.
* **Model**: The raw data is transformed into star-schema-style fact and dimension tables.
* **Analyze**: SQL queries are used to extract insights related to product demand, user behavior, and reorder patterns.

---

## 📁 Datasets

Download the ecommerce datasets here:
🔗 [Google Drive Folder](https://drive.google.com/drive/folders/1pjmEQOxse7Q3kldm7YPBUANS4Nlo7rCc?usp=drive_link)

---


### 📁 Tables Created:

* **Raw Tables**: `orders`, `order_products`, `products`, `departments`, `aisles`
* **Dimensions**: `dim_orders`, `dim_users`, `dim_products`, `dim_departments`, `dim_aisles`
* **Fact Table**: `fact_order_products`

---

## 📈 Key Analytical Queries

* 🧮 **Total Products Ordered per Department**
  Aggregates total orders by department name

* 🔁 **Top 5 Reordered Aisles**
  Identifies the aisles with the most reordered products

* 📅 **Average Cart Size by Day of Week**
  Reveals trends in user shopping habits across the week

* 👤 **Top 10 Users by Unique Products Ordered**
  Highlights users with the most diverse carts

---

## 🧰 Technologies Used

* **Snowflake**: Cloud data warehouse for storage and compute
* **Amazon S3**: Stores raw Instacart dataset files
* **SQL**: Used for data modeling and querying
* **Dimensional Modeling**: Star schema approach for analytical querying

---



## 📚 Reference

* [Snowflake Documentation](https://docs.snowflake.com/en)


