# Cart Abandonment Analysis Project

## Overview

Cart abandonment occurs when potential customers add items to their online shopping carts but leave the website before completing their purchase. It is a significant challenge for eCommerce businesses, as it represents lost revenue and an opportunity to understand customer behaviors and preferences.

## Problem Statement

By analyzing cart abandonment, businesses can identify where and why customers are dropping off in the purchasing funnel, leading to insights that can help reduce the abandonment rate, recover lost sales, and improve customer satisfaction.

The eCommerce business is experiencing a high rate of cart abandonment, with many customers failing to complete their purchases after adding items to their shopping cart.

## Business Questions to Answer

1. **Device-Specific Abandonment**: What are the cart abandonment rates across different devices (desktop, mobile, tablet)? *(Addressed in demograph.sql with device type abandonment rate queries)*

2. **Product-Specific Abandonment**: Which product categories experience the highest rates of abandonment? Are there certain products that are frequently abandoned? *(Addressed in demograph.sql with product category and most abandoned products queries)*

3. **Time-Specific Trends**: Are there specific times of the day, days of the week, or months where cart abandonment spikes? What seasonal trends exist?

## Data Sources


### Raw tables (Cart Abandonment Datasets/)
- **fact_table.csv**: 5,000 session-level rows with `session_id`, `customer_id`, `product_id`, `device_id`, `date_id`, `quantity` (note the trailing space in the header), `abandonment_time` (date), and `time_of_set` (synthetic HH:MM:SS times filled only when an abandonment date exists; blank otherwise).
- **customer_table.csv**: 1,000 customers with demographics (`customer_id`, `customer_name`, `age`, `gender`, `city` across London, New York, Sydney, Berlin, Mumbai).
- **date_table.csv**: 366 daily rows from 2023-01-01 to 2024-01-01.
- **device_table.csv**: 5 device types with associated OS details.
- **product_table.csv**: 25 products across five categories with `product_id`, `product_name`, `category`, and `price`.

### Reports and Dashboards
- **cart.pbix**: Power BI dashboard/report file for interactive data visualization and analysis of cart abandonment patterns using the above datasets. Open this file in Power BI Desktop to explore pre-built charts and insights.

### Derived outputs
- **Cleaned_Datasets/**: CSV exports from `data_processing.ipynb` with cleaned types and engineered fields (e.g., `is_abandoned` in the cleaned fact table).
- **variables.pkl**: Pickled DataFrames (customer, date, facts, product, device) for quick loading in downstream notebooks.

## Methodology


## Data Structure and Relationships

The project uses a star schema structure, with a central fact table and several dimension tables. Here’s how the CSV files are connected:

### Central Table (Fact Table)

**fact_table.csv** – Contains the transactional data (cart abandonment events)
  - `session_id` (Primary Key)
  - `customer_id` (Foreign Key → customer_table)
  - `product_id` (Foreign Key → product_table)
  - `device_id` (Foreign Key → device_table)
  - `date_id` (Foreign Key → date_table)
  - `quantity`, `abandon_date`, `abandon_time`, `is_abandoned` (Measures/Facts)

### Dimension Tables (Connected to Fact Table)

1. **customer_table.csv**
  - `customer_id` (Primary Key)
  - Contains: customer_name, age, gender, city
  - **Relationship**: Each session in fact_table belongs to ONE customer

2. **product_table.csv**
  - `product_id` (Primary Key)
  - Contains: product_name, category, price
  - **Relationship**: Each session in fact_table involves ONE product

3. **device_table.csv**
  - `device_id` (Primary Key)
  - Contains: device_type, os
  - **Relationship**: Each session in fact_table uses ONE device

4. **date_table.csv**
  - `date_id` (Primary Key)
  - Contains: date
  - **Relationship**: Each session in fact_table occurs on ONE date

#### Relationship Diagram

```
      customer_table ──┐
                 │
      product_table ───┼──→ fact_table (center)
                 │     └─ Tracks cart abandonment events
      device_table ────┤
                 │
      date_table ──────┘
```

This structure allows for flexible analysis of cart abandonment patterns by customer, product, device, and time.

### Data Processing
1. **Data Loading**: Import all CSV files into pandas DataFrames
2. **Data Cleaning**: Handle missing values and set consistent dtypes (ints, strings, datetimes)
3. **Data Validation**: Null audits and ID consistency checks across dimension tables
4. **Feature Engineering**: Add `is_abandoned` flag based on presence of `abandonment_time` (0 if abandoned, 1 if completed); `time_of_set` contains synthetic timestamps when abandonment occurred
5. **Exports**: Persist cleaned CSVs to `Cleaned_Datasets/` and bundle processed DataFrames into `variables.pkl` for downstream notebooks

### Analysis Approach
- **SQL Analysis**: Execute queries in `demograph.sql` to calculate abandonment rates by device, product category, demographics (gender, city, age), and identify high-intent customers and frequently abandoned products
- **Exploratory Data Analysis**: Examine data distributions and relationships
- **Aggregation**: Group data by relevant dimensions (device, product category, time periods)
- **Statistical Analysis**: Calculate abandonment rates and identify patterns
- **Visualization**: Create charts and graphs to illustrate findings

## Project Structure

```
Cart Abandonment/
├── data_processing.ipynb       # Load, clean, validate, engineer fields, export cleaned CSVs and variables.pkl
├── demograph.ipynb             # Exploratory analysis using preprocessed data
├── demograph.sql               # SQL queries for cart abandonment analysis including demographic breakdowns, device/product analysis, and abandonment rate calculations
├── Cart Abandonment Datasets/  # Raw inputs (fact_table, dimensions)
├── Cleaned_Datasets/           # Outputs from data_processing.ipynb
├── variables.pkl               # Pickled cleaned DataFrames for fast reuse
├── cart.pbix                   # Power BI dashboard/report for interactive data visualization
└── README.md                   # Project overview and guidance
```

## Technologies Used

- **Python 3.12**: Core language for data prep and analysis
- **Pandas / NumPy**: Data wrangling and numerical operations
- **Jupyter Notebook**: Interactive execution and documentation
- **SQL**: Database querying for abandonment analysis (queries in `demograph.sql`)
- **Power BI**: Interactive dashboard/reporting using `cart.pbix` for data visualization and insights
- **pickle**: Persisting processed DataFrames for reuse (`variables.pkl`)
- **OS utilities**: File-system orchestration for cleaned exports

## Key Findings

Based on SQL analysis of the cart abandonment data:

### Overall Abandonment Rate
- Total sessions: 5,000
- Abandoned sessions: 2,524
- Overall abandonment rate: 50.48%

### Abandonment by Device Type
- Desktop: 49.95% abandonment rate (1,021 total sessions)
- Mobile: 50.82% abandonment rate (1,960 total sessions)
- Tablet: 50.42% abandonment rate (2,019 total sessions)

### Abandonment by Product Category
- Apparel: 52.50% abandonment rate (highest)
- Electronics: 51.83% abandonment rate
- Sports & Outdoors: 49.65% abandonment rate
- Beauty & Personal Care: 49.40% abandonment rate
- Home & Kitchen: 48.87% abandonment rate (lowest)

### Demographic Analysis
- **By Gender**:
  - Female: 50.60% abandonment rate (2,508 sessions)
  - Male: 50.36% abandonment rate (2,492 sessions)
- **By City**:
  - Berlin: 52.91% abandonment rate (highest)
  - London: 52.15% abandonment rate
  - Mumbai: 50.61% abandonment rate
  - Sydney: 49.48% abandonment rate
  - New York: 47.49% abandonment rate (lowest)
- **By Age Group**:
  - 18-24: 47.10% abandonment rate (lowest)
  - 25-34: 51.29% abandonment rate
  - 35-44: 50.64% abandonment rate
  - 45-54: 51.58% abandonment rate (highest)
  - 55-64: 51.10% abandonment rate

### High Intent Customers
- 1,508 customers abandoned carts with 3 or more items, indicating high purchase intent

### Most Frequently Abandoned Products
- Top 5 most abandoned products:
  1. Dress (118 abandonments)
  2. Headphones (118 abandonments)
  3. Blender (115 abandonments)
  4. Smartphone (113 abandonments)
  5. Smartwatch (112 abandonments)

## Quick Start

1. Open `data_processing.ipynb` and run all cells to load, clean, flag `is_abandoned`, and export cleaned CSVs plus `variables.pkl`.
2. Review `demograph.sql` for SQL-based abandonment analysis queries covering device types, product categories, demographics, and high-intent customers.
3. Use `demograph.ipynb` for exploratory analysis and time/device/product breakdowns (it loads `variables.pkl` to skip reprocessing).

## Future Work

- Implement machine learning models to predict abandonment likelihood
- Develop recommendation systems to reduce abandonment
- Create real-time abandonment alerts
- A/B testing of abandonment reduction strategies

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is for educational purposes. Please refer to individual data source licenses for usage rights.
