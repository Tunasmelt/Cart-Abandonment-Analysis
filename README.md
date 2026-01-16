# Cart Abandonment Analysis – SQL & Power BI

This project delivers an end‑to‑end analysis of eCommerce cart abandonment using SQL analytics and a Power BI dashboard. The objective is to identify where customers drop off in the purchasing funnel and recommend targeted actions to recover revenue.

## Business Impact Summary

| Metric | Value | Status |
|---------|--------|--------|
| **Overall Abandonment Rate** | **50.48%** | Critical |
| **Highest Device Risk** | Mobile (50.82%) | Action Needed |
| **Largest Product Leakage** | Apparel (52.50%) | Priority |
| **Highest Geographic Risk** | Berlin (52.91%) | Localize |
| **High‑Intent Recovery Opportunity** | 1,508 users | High ROI |

---

## Key Business Questions

1. **Device Performance**: Which devices contribute most to abandonment?
2. **Product Analysis**: What product categories leak the most revenue?
3. **Demographic Segments**: Which customer groups need targeted retention?
4. **Recovery Targets**: Who are the high‑intent users we can recover first?

---

## Data Model & Architecture

### Star Schema Design
```
      customer_table ──┐
                     │
      product_table ───┼──→ fact_table (center)
                     │     └─ 5,000 sessions tracked
      device_table ────┤
                     │
      date_table ──────┘
```

### Table Specifications
| Table | Records | Key Fields | Purpose |
|-------|---------|------------|---------|
| **fact_table** | 5,000 | `session_id`, `is_abandoned`, `quantity` | Core transaction data |
| **customer_table** | 1,000 | `customer_id`, `age`, `gender`, `city` | Demographic dimensions |
| **product_table** | 25 | `product_id`, `category`, `price` | Product catalog |
| **device_table** | 5 | `device_id`, `device_type` | Technology dimensions |
| **date_table** | 366 | `date_id`, `date` | Temporal dimension |

### Key Assumptions
- Metrics calculated at **session level** using DISTINCT session_id
- `is_abandoned = 1` indicates cart not purchased
- Fact table stored at **product granularity** (one row per product per session)

---

## Core Metrics & SQL Calculations

### Primary KPI Formulas
```sql
-- Total Sessions
COUNT(DISTINCT session_id)

-- Abandoned Sessions  
COUNT(DISTINCT CASE WHEN is_abandoned = 1 THEN session_id END)

-- Abandonment Rate
Abandoned Sessions / Total Sessions * 100

-- High‑Intent Users
COUNT(DISTINCT CASE WHEN SUM(quantity) >= 3 AND is_abandoned = 1 
                  THEN session_id END)
```

### Device Performance Query
```sql
SELECT 
    device.device_type,
    COUNT(DISTINCT fact.session_id) AS total_sessions,
    SUM(fact.is_abandoned) AS abandoned_sessions,
    ROUND(SUM(fact.is_abandoned) / COUNT(DISTINCT fact.session_id) * 100, 2) 
    AS abandonment_rate
FROM fact_table fact
JOIN device_table device ON fact.device_id = device.device_id
GROUP BY device.device_type
ORDER BY abandonment_rate DESC;
```

---

## Power BI Dashboard Design

### Page Architecture

#### **Page 1 – Executive Overview**
![Executive Overview](Screenshots/dashboard_page_1.png)
- **KPI Cards**: Total Sessions | Abandoned | Abandonment % | Completed
- **Funnel Visual**: Session → Add to Cart → Checkout → Complete
- **Executive Insight Panel**: Key findings and revenue impact

#### **Page 2 – Device & Product Analysis**  
![Device & Product Analysis](Screenshots/dashboard_page_2.png)
- **Device Performance Bar Chart**: Abandonment rates by device type
- **Category Risk Matrix**: Product categories with revenue leakage
- **Diagnostic Insight Panel**: Root cause analysis

#### **Page 3 – Customer Segments**
![Customer Segments](Screenshots/dashboard_page_3.png)
- **Gender Distribution**: Abandonment by gender
- **Age Group Analysis**: Behavioral patterns by age
- **Geographic Comparison**: City-level abandonment rates

#### **Page 4 – Recovery Strategy**
- **High‑Intent KPIs**: Users with 3+ items in abandoned carts
- **Top Abandoned Products**: Revenue recovery opportunities
- **Action Panel**: Recommended interventions

---

## Critical Business Insights

### Immediate Risks Identified
- **Mobile UX Crisis**: 50.82% abandonment requires urgent optimization
- **Apparel Category Leakage**: 52.50% abandonment indicates sizing/pricing issues
- **Berlin Market Challenge**: 52.91% abandonment needs localization strategy
- **Checkout Friction**: Primary driver across all segments

### Revenue Recovery Opportunities
| Opportunity | Potential Revenue | Priority |
|-------------|-------------------|-----------|
| **High‑Intent Recovery** | $392,830 | Critical |
| **Mobile Optimization** | $285,000 | Critical |
| **Apparel Enhancement** | $198,000 | High |
| **Berlin Localization** | $156,000 | High |

---

## Strategic Recommendations

### **Immediate Actions (0–30 days)**
1. **Mobile Checkout Simplification**
   - Reduce form fields by 40%
   - Implement one‑click payment
   - Add progress indicators

2. **Apparel Category Enhancement**
   - Interactive size guides
   - Virtual try‑on features
   - Free shipping threshold

3. **Berlin Market Localization**
   - Local payment methods (Sofort, Giropay)
   - German language support
   - Local customer service

### **Strategic Initiatives (30–90 days)**
1. **Cart Recovery Campaigns**
   - Email sequences for high‑intent users
   - Retargeting ads with abandoned products
   - Limited‑time discount offers

2. **Age‑Specific Messaging**
   - 45‑54 age group: Premium support emphasis
   - 18‑24 age group: Student discount programs
   - 25‑34 age group: Convenience benefits

### **Long‑Term Vision (90+ days)**
1. **Predictive Abandonment Model**
   - Machine learning for at‑risk identification
   - Real‑time intervention triggers
   - Personalized recovery offers

2. **A/B Testing Platform**
   - Continuous checkout optimization
   - Feature rollout monitoring
   - Conversion rate tracking

---

## Analysis Limitations

| Limitation | Impact | Mitigation |
|-------------|---------|------------|
| **No step‑level funnel events** | Cannot identify specific drop‑off points | Implement event tracking |
| **No payment failure data** | Missing technical failure insights | Add payment analytics |
| **No shipping cost attributes** | Incomplete cost analysis | Include shipping data |
| **Static time period** | No seasonal trend analysis | Extend data collection |

---

## Repository Structure

```
Cart Abandonment/
├── Cart Abandonment Datasets/  # Raw CSV files
│   ├── fact_table.csv              # 5,000 sessions
│   ├── customer_table.csv           # 1,000 customers  
│   ├── product_table.csv           # 25 products
│   ├── device_table.csv            # 5 device types
│   └── date_table.csv             # 366 days
├── Cleaned_Datasets/          # Processed data
├── demograph.sql              # SQL analytics queries
├── data_processing.ipynb      # ETL pipeline
├── cart.pbix                  # Power BI dashboard
└── README.md                  # This file
```

---

## Technical Stack

| Technology | Purpose | Proficiency |
|-------------|----------|-------------|
| **SQL** | Data analysis & metrics | Advanced |
| **Power BI** | Dashboard creation | Intermediate |
| **Python** | Data processing | Intermediate |
| **Pandas** | Data manipulation | Intermediate |

---

## Quick Start Guide

### For Business Stakeholders
1. Open `cart.pbix` in Power BI Desktop
2. Review **Page 1** for executive overview
3. Focus on **Page 4** for recovery actions

### For Data Analysts
1. Run `data_processing.ipynb` for data preparation
2. Execute `demograph.sql` for detailed analysis
3. Modify queries for custom insights

### For Developers
```python
# Quick data loading
import pickle
with open('variables.pkl', 'rb') as f:
    data = pickle.load(f)

# Access processed DataFrames
facts = data['facts']
customers = data['customer']
products = data['product']
devices = data['device']
dates = data['date']
```

