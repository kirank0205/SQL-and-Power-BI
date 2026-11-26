# Retail Sales & Customer Analysis (SQL)

## Business scenario
A multi-region retailer wants to understand sales performance, product profitability and customer purchasing behaviour.

## Questions
- What are revenue, completed orders, units sold, gross profit and margin?
- Which categories, products and regions contribute most?
- Who are the highest-value customers?
- What proportion of purchasing customers make repeat purchases?
- How does revenue change month over month?

## Files
- data/customers.csv — customer attributes and acquisition channel.
- data/orders.csv — order header, date, customer and region.
- data/order_items.csv — product, quantity, price and cost.
- sql/01_schema.sql — PostgreSQL table definitions.
- sql/02_analysis.sql — KPI, category, region, product and customer queries.

## Setup
1. Create a PostgreSQL database.
2. Run sql/01_schema.sql.
3. Import the three CSV files into their matching tables.
4. Run sql/02_analysis.sql.

## Skills demonstrated
Relational modelling, primary/foreign keys, joins, aggregations, CASE, CTEs, date functions, window functions, ranking and data-quality checks.

All data is synthetic. Revenue = quantity × unit price; gross profit = quantity × (unit price − unit cost). Cancelled orders are excluded from commercial KPIs.
