# Cart Abandonment Analysis Project

## Overview

Cart abandonment occurs when potential customers add items to their online shopping carts but leave the website before completing their purchase. It is a significant challenge for eCommerce businesses, as it represents lost revenue and an opportunity to understand customer behaviors and preferences.

## Problem Statement

By analyzing cart abandonment, businesses can identify where and why customers are dropping off in the purchasing funnel, leading to insights that can help reduce the abandonment rate, recover lost sales, and improve customer satisfaction.

The eCommerce business is experiencing a high rate of cart abandonment, with many customers failing to complete their purchases after adding items to their shopping cart.

## Business Questions to Answer

1. **Device-Specific Abandonment**: What are the cart abandonment rates across different devices (desktop, mobile, tablet)?

2. **Product-Specific Abandonment**: Which product categories experience the highest rates of abandonment? Are there certain products that are frequently abandoned?

3. **Time-Specific Trends**: Are there specific times of the day, days of the week, or months where cart abandonment spikes? What seasonal trends exist?

## Data Sources

The project uses a star schema database with the following tables:

- **fact_table.csv**: 5,000 session-level rows with `session_id`, `customer_id`, `product_id`, `device_id`, `date_id`, `quantity` (in the raw file the header contains a trailing space), `abandonment_time` (date), and `time_of_set` (synthetic HH:MM:SS times added for rows that have an abandonment date; remains blank when no abandonment date exists)
- **customer_table.csv**: 1,000 customers with demographics (`customer_id`, `customer_name`, `age`, `gender`, `city` across London, New York, Sydney, Berlin, Mumbai)
- **date_table.csv**: 366 daily rows from 2023-01-01 to 2024-01-01
- **device_table.csv**: 5 device types with device and OS details
- **product_table.csv**: 25 products across five categories with `product_id`, `product_name`, `category`, and `price`

## Methodology

### Data Processing
1. **Data Loading**: Import all CSV files into pandas DataFrames
2. **Data Cleaning**: Handle missing values and set consistent dtypes (ints, strings, datetimes)
3. **Data Validation**: Null audits and ID consistency checks across dimension tables
4. **Feature Engineering**: Add `is_abandoned` flag from presence of `abandon_date`; enrich `abandonment_time` with `time_of_set` (blank when no abandonment date)
5. **Exports**: Persist cleaned CSVs to `Cleaned_Datasets/` and bundle processed DataFrames into `variables.pkl` for downstream notebooks

### Analysis Approach
- **Exploratory Data Analysis**: Examine data distributions and relationships
- **Aggregation**: Group data by relevant dimensions (device, product category, time periods)
- **Statistical Analysis**: Calculate abandonment rates and identify patterns
- **Visualization**: Create charts and graphs to illustrate findings

## Project Structure

```
Cart Abandonment/
├── data_processing.ipynb       # Data loading, cleaning, flagging, exports
├── demograph.ipynb             # Demographic and session-level exploration
├── demograph.sql               # SQL reference/queries
├── Cart Abandonment Datasets/  # Raw data
│   ├── fact_table.csv
│   ├── customer_table.csv
│   ├── date_table.csv
│   ├── device_table.csv
│   └── product_table.csv
├── Cleaned_Datasets/           # Exported cleaned CSVs
├── variables.pkl               # Pickled cleaned DataFrames for reuse
└── README.md                   # This file
```

## Technologies Used

- **Python**: Primary programming language
- **Pandas**: Data manipulation and analysis
- **NumPy**: Numerical computing
- **Jupyter Notebook**: Interactive development environment

## Key Findings

*To be updated after running the analysis notebooks.*

## Quick Start

1. Open `data_processing.ipynb` and run all cells to load, clean, flag `is_abandoned`, and export cleaned CSVs plus `variables.pkl`.
2. Use `demograph.ipynb` for exploratory analysis and time/device/product breakdowns (it loads `variables.pkl` to skip reprocessing).

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
