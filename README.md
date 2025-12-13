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

- **fact_table.csv**: Contains transaction-level data including session_id, customer_id, product_id, device_id, date_id, quantity, and abandonment_time
- **customer_table.csv**: Customer demographics including customer_id, name, age, gender, and city
- **date_table.csv**: Date dimension with date_id and date information
- **device_table.csv**: Device information including device_id, device_type, and operating system
- **product_table.csv**: Product details including product_id, name, category, and price

## Methodology

### Data Processing
1. **Data Loading**: Import all CSV files into pandas DataFrames
2. **Data Cleaning**: Handle missing values and data type conversions
3. **Data Validation**: Check for null values and ensure data integrity
4. **Data Type Setting**: Convert columns to appropriate data types (integers, strings, datetimes)

### Analysis Approach
- **Exploratory Data Analysis**: Examine data distributions and relationships
- **Aggregation**: Group data by relevant dimensions (device, product category, time periods)
- **Statistical Analysis**: Calculate abandonment rates and identify patterns
- **Visualization**: Create charts and graphs to illustrate findings

## Project Structure

```
Cart Abandonment/
├── data-processing.ipynb          # Data loading and preprocessing notebook
├── demograpic-info.ipynb          # Demographic analysis notebook
├── Cart Abandonment Datasets/     # Data files
│   ├── fact_table.csv
│   ├── customer_table.csv
│   ├── date_table.csv
│   ├── device_table.csv
│   └── product_table.csv
└── README.md                      # This file
```

## Technologies Used

- **Python**: Primary programming language
- **Pandas**: Data manipulation and analysis
- **NumPy**: Numerical computing
- **Jupyter Notebook**: Interactive development environment

## Key Findings

*(To be updated based on analysis results)*

### Device-Specific Insights
- Analysis of abandonment rates by device type

### Product-Specific Insights
- Identification of high-abandonment product categories
- Analysis of frequently abandoned products

### Time-Specific Insights
- Temporal patterns in cart abandonment
- Peak abandonment periods

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
