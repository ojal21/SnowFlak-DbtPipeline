Data Engineering Projects

This repository showcases two real-world data engineering pipelines using **Snowflake**, **dbt**, **Python**, and **cron-based scheduling**. Each pipeline demonstrates modern ELT practices, data modeling, and analytics-readiness across two distinct domains: **e-commerce** and **epidemic + climate surveillance**.

---

## 📦 Project 1: E-Commerce Orders Pipeline

Batch ingestion + transformation using dbt Cloud

### 🧰 Tech Stack

* Python (for batch ingestion)
* Snowflake (data warehouse)
* dbt + dbt Cloud (transformation & scheduling)

### 📁 Data

* **Source:** Mock e-commerce orders CSV (from a public GitHub dataset)
* **Destination:** `raw.orders_raw` in Snowflake

### 🔧 Pipeline Overview

1. **CSV Upload:** Python script ingests e-commerce order data into Snowflake
2. **Staging Model – `stg_orders`:**

   * Casts data types
   * Converts date columns to `TIMESTAMP`
3. **Fact Model – `fct_customer_revenue`:**

   * Aggregates revenue and order count per customer
   * Removes null values

### ✅ Key Output Metrics

* `total_orders`
* `total_revenue`
* `first_order_date`, `last_order_date`

### 📚 Documentation

* Auto-generated **lineage graphs** and searchable **dbt docs**
* **Column-level tests** (`not_null`, `unique`) applied

---

## 🌍 Project 2: Epidemic + Climate Data Pipeline

Incremental weekly ingestion with Python + cron simulation

### 🧰 Tech Stack

* Python (ingestion + cron job simulation)
* dbt (transformations and aggregation)
* Snowflake (data warehouse)

### 📁 Data

* **Source:** EpiClim dataset from Zenodo
* **Destination:** `raw.epiclim_raw` in Snowflake
* **Ingestion:** Simulated weekly via `load_epiclim_weekX.py` scripts

### 🔁 Pipeline Flow

* Python handles weekly ingestion (automated via cron)
* Replaces outdated jobs and handles schema parsing
* Clean data mapping (type conversions, date parsing)

### 🧼 dbt Models

* **`stg_epiclim`**

  * Parses raw CSV
  * Constructs `outbreak_date` from year/month/day
* **`fct_disease_metrics`**

  * Aggregates case/death counts + climate indicators
  * Enables time/district-level analysis

### ✅ Key Output Metrics

* Disease frequency by week
* Average temperature and precipitation by region

### 📚 Documentation

* **dbt docs** with searchable metadata
* Validated via `not_null` and `unique` tests

---
## Lineage graph

<img width="1657" height="451" alt="image" src="https://github.com/user-attachments/assets/4c7790cf-20f9-4add-8a91-e3afab880d4a" />

---
## 🚀 How to Run This Project

### 🐍 Set Up Python Environment

```bash
pip install snowflake-connector-python pandas python-dotenv
```

### 🔑 Configure Snowflake Credentials

Create a `.env` file in your project root:

```env
SNOWFLAKE_USER=your_user  
SNOWFLAKE_PASSWORD=your_password  
SNOWFLAKE_ACCOUNT=your_account  
SNOWFLAKE_DATABASE=your_db  
SNOWFLAKE_SCHEMA=raw  
SNOWFLAKE_WAREHOUSE=your_wh  
```

---

### 🏃 Run Batch Loader (E-Commerce Orders)

```bash
python load_ecommerce.py
```

### 🗓 Simulate Weekly Cron Ingestion (EpiClim)

```bash
python load_epiclim_week1.py  
crontab -e  # add future weeks as cron jobs
```

---

### 🛠 Run dbt Models

```bash
dbt run
```

### 🔍 Run Tests & Generate Docs

```bash
dbt test  
dbt docs generate && dbt docs serve
```

---

## 💡 Next Steps

Interested in the **dashboarding layer** or **real-time ingestion**?
Open to collaborations or extensions using Apache Airflow or event-based pipelines.

---

Let me know if you'd like this adapted into a `README.ipynb`, or split by folders with individual `README.md` files inside `/project1` and `/project2`.
