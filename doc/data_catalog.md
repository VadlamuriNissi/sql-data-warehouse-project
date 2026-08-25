# Data Catalog for Gold Layer

## 1. gold.dim_customers
- **Purpose:** Stores customer details enriched with demographic and geographic data.
- **Columns:**
| :--- | :--- | :--- |
| Column Name | Data Type | Description |
| customer_key | INT | Surrogate key uniquely identifying each customer |
| customer_id | INT | Unique numerical identifier assigned to each customer |
| customer_number | NVARCHAR(50) | Alphanumeric identifier for tracking and referencing |
| first_name | NVARCHAR(50) | Customer's first name |
| last_name | NVARCHAR(50) | Customer's last name |
| country | NVARCHAR(50) | Country of residence (e.g., 'Australia') |
| marital_status | NVARCHAR(50) | Marital status ('Married', 'Single') |
| gender | NVARCHAR(50) | Gender of the customer (e.g., 'Male', 'Female', 'n/a')|
| birthdate | DATE | Date of birth formatted as YYYY-MM-DD (e.g., 1971-10-06)|
| create_date | DATE | Record creation date |

## 2. gold.dim_products
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| product_key | INT | Surrogate key |
| product_id | INT | Unique product ID |
... add your columns

## 3. gold.fact_sales
| Column Name | Data Type | Description |
| :--- | :--- | :--- |
| order_number | NVARCHAR(50) | Sales order number |
| product_key | INT | FK to dim_products |
| customer_key | INT | FK to dim_customers |
| sales_amount | INT | Total sales amount |
...
