# Northwind Traders Sales & Customer Analysis

## Project Overview

This project analyzes the Northwind Traders database using SQL to evaluate sales performance, customer behavior, product and category performance, geographic revenue, employee-associated order revenue, monthly sales trends, customer segmentation, and data quality.

The analysis progresses from basic data exploration and filtering to aggregate calculations, multi-table JOINs, conditional logic, subqueries, date analysis, and relationship validation.

## Business Questions

This analysis was designed to answer the following questions:

- How much total revenue is represented in the analyzed sales data?
- Which products generate the most revenue?
- Which customers generate the most revenue?
- Which product categories generate the most revenue?
- Which customer countries are associated with the most revenue?
- Which employees are associated with the highest order revenue?
- How does revenue change over time?
- How can customers be segmented based on total revenue?
- Are there missing, duplicate, invalid, or unmatched records that could affect the analysis?

## Dataset

The project uses the Northwind Traders sample dataset.

The analyzed database contains:

- 91 customers
- 830 orders
- 77 products

Tables used in the analysis include:

- `customers`
- `orders`
- `order_details`
- `products`
- `categories`
- `employees`
- `shippers`

## Tools Used

- SQL
- SQLite
- SQLPro Studio
- GitHub

## SQL Skills Demonstrated

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()` and `MAX()`
- Multi-table `JOIN`
- `LEFT JOIN`
- Table aliases
- Calculated fields
- `CASE WHEN`
- Subqueries
- Date analysis with `strftime()`
- `NULL` handling
- `HAVING`
- Duplicate detection
- Referential-integrity checks

## Key Findings

The analysis identified approximately **$1.27 million in total revenue** across the analyzed order-detail records.

**Côte de Blaye** was the highest-revenue product, generating approximately **$141,396.74**.

**QUICK-Stop** was the highest-revenue customer, accounting for approximately **$110,277.31**.

**Beverages** was the highest-revenue product category, generating approximately **$267,868.18**.

The **United States** had the highest customer-associated revenue at approximately **$245,584.61**.

Orders associated with **Margaret Peacock** represented approximately **$232,890.85**, the highest employee-associated order revenue in the dataset.

**July 2013** was the highest-revenue month, generating approximately **$27,861.90**.

## Customer Segmentation

Customers with order activity were segmented using project-defined revenue thresholds:

- **High Value:** $20,000 or more
- **Medium Value:** $10,000 to less than $20,000
- **Low Value:** Less than $10,000

The resulting segments were:

- **18 High-Value customers**
- **20 Medium-Value customers**
- **51 Low-Value customers**

The segmentation includes **89 of the 91 customers**. A follow-up `LEFT JOIN` identified two customers, **FISSA** and **PARIS**, with no matching order activity. Because they had no order revenue, they were not classified by the revenue-based segmentation query.

## Data Quality Checks

Data-quality testing was performed before interpreting the results.

The analysis identified:

- 21 orders with missing shipped dates
- 0 duplicate order IDs
- 0 zero or negative quantities
- 0 discount values outside the expected range
- 0 unmatched customer relationships
- 0 unmatched product relationships

The missing shipped dates should be reviewed before using `shippedDate` for fulfillment or shipping-performance analysis.

## Business Recommendations

### Product Performance

Further analyze **Côte de Blaye** to determine how pricing, quantity sold, and discounting contribute to its leading revenue position. Comparing these factors with other high-performing products could help explain the drivers behind its performance.

### Customer Strategy

Review the purchasing behavior of **QUICK-Stop** and other high-value customers to identify patterns that may support customer-retention and account-development strategies.

### Category Performance

Analyze the individual products within the **Beverages** category to determine which products contribute most strongly to the category's leading revenue position.

### Geographic Performance

Investigate the U.S. customer base further to determine which customers, categories, and products contribute most to its leading customer-associated revenue.

### Data Quality

Review the **21 missing shipped dates** before conducting fulfillment-time or shipping-performance analysis to determine whether the missing values represent incomplete historical records, unshipped orders, or another operational explanation.

## Project Files

- `northwind_analysis.sql` — Complete SQL analysis
- `screenshots/` — Selected SQL queries and results demonstrating key analyses

## Analysis Examples

### Top Revenue-Generating Products

This analysis ranks products by total revenue after accounting for discounts.

![Top Revenue Products](screenshots/top-products-sql.png)

### Top Revenue-Generating Customers

Customer revenue was calculated by joining the customers, orders, and order details tables.

![Top Revenue Customers](screenshots/top-customers-sql.png)

### Revenue by Product Category

This analysis compares total revenue across Northwind's product categories.

![Category Revenue](screenshots/category-revenue-sql.png)

### Monthly Revenue Trends

Monthly revenue was calculated using SQLite date functions to evaluate sales performance over time.

![Monthly Revenue](screenshots/monthly-revenue-sql.png)

### Customer Segmentation

Customers with order activity were classified into High-, Medium-, and Low-Value segments using `CASE WHEN` and total revenue.

![Customer Segmentation](screenshots/customer-segmentation-sql.png)

### Data Quality Validation

SQL data-quality checks were used to identify missing, invalid, duplicate, and unmatched records.

![Data Quality](screenshots/data-quality-sql.png)

## Conclusion

This project demonstrates how SQL can be used to move from raw relational data to business-focused analysis. The workflow included data exploration, aggregation, multi-table analysis, customer segmentation, time-based analysis, and data-quality validation.

The project also demonstrates the importance of investigating unexpected results. When customer segmentation accounted for only 89 of 91 customers, an additional relationship check identified two customers without matching orders, explaining the difference rather than leaving the discrepancy unresolved.
