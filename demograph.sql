-- Total sessions and abandoned sessions

SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN is_abandoned = 0 THEN session_id END) AS abandoned_sessions
FROM fact_table;

-- Over 54% of customers ended up purchasing a product

SELECT 
    ROUND(SUM(is_abandoned) / COUNT(DISTINCT session_id) * 100, 2) 
    AS abandonment_rate_percent
FROM fact_table;

-- Abandonment rate percentage by device type

SELECT 
    device.device_type,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    SUM(fact.is_abandoned) AS abandoned_sessions,
    ROUND(SUM(fact.is_abandoned) / COUNT(DISTINCT fact.session_id) * 100, 2) AS abandonment_rate
FROM fact_table AS fact
JOIN device_table AS device ON fact.device_id = device.device_id
GROUP BY device.device_type
ORDER BY abandonment_rate DESC;

-- Abandonment by product category

SELECT
    product.category,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    SUM(fact.is_abandoned) AS abandoned_sessions,
    ROUND(SUM(fact.is_abandoned) / COUNT(DISTINCT fact.session_id) * 100, 2) AS abandonment_rate
FROM fact_table AS fact
JOIN product_table AS product ON fact.product_id = product.product_id
GROUP BY product.category;

-- Abandonment rate by gender

SELECT 
    customer.gender,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    COUNT(DISTINCT CASE 
        WHEN fact.is_abandoned = 1 THEN fact.session_id END) AS abandoned_sessions,
    ROUND(COUNT(DISTINCT CASE WHEN fact.is_abandoned = 1 THEN fact.session_id END) / COUNT(DISTINCT fact.session_id) * 100, 2) AS abandonment_rate
FROM fact_table AS fact
JOIN customer_table AS customer ON fact.customer_id = customer.customer_id
GROUP BY customer.gender;

-- Abandonment rate by city

SELECT 
    customer.city,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    COUNT(DISTINCT CASE 
        WHEN fact.is_abandoned = 1 THEN fact.session_id END) AS abandoned_sessions,
    ROUND(COUNT(DISTINCT CASE 
            WHEN fact.is_abandoned = 1 THEN fact.session_id END) / COUNT(DISTINCT fact.session_id) * 100, 2) AS abandonment_rate
FROM fact_table AS fact
JOIN customer_table AS customer ON fact.customer_id = customer.customer_id
GROUP BY customer.city;

-- Abandonment rate by age group

SELECT 
    CASE 
        WHEN customer.age < 18 THEN 'Under 18'
        WHEN customer.age BETWEEN 18 AND 24 THEN '18-24'
        WHEN customer.age BETWEEN 25 AND 34 THEN '25-34'
        WHEN customer.age BETWEEN 35 AND 44 THEN '35-44'
        WHEN customer.age BETWEEN 45 AND 54 THEN '45-54'
        WHEN customer.age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65 and over'
    END AS age_group,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    COUNT(DISTINCT CASE 
        WHEN fact.is_abandoned = 1 THEN fact.session_id 
    END) AS abandoned_sessions,
    ROUND(COUNT(DISTINCT CASE 
            WHEN fact.is_abandoned = 1 THEN fact.session_id END) / COUNT(DISTINCT fact.session_id) * 100, 2) AS abandonment_rate
FROM fact_table AS fact
JOIN customer_table AS customer ON fact.customer_id = customer.customer_id
GROUP BY age_group;

-- High Intent Customers

SELECT 
    session_id,
    SUM(quantity) AS items_in_cart
FROM fact_table
WHERE is_abandoned = 1
GROUP BY session_id
HAVING SUM(quantity) >= 3;

-- Most Frequently Abandoned Products

SELECT 
    product.product_name,
    COUNT(DISTINCT fact.session_id) AS abandonment_count
FROM fact_table AS fact
JOIN product_table AS product ON fact.product_id = product.product_id
WHERE fact.is_abandoned = 1
GROUP BY product.product_name
ORDER BY abandonment_count DESC;

