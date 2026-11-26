# Dashboard report specification

## Page 1 — Executive Overview
- KPI cards: Revenue, Gross Profit, Gross Margin %, Orders, Units Sold, Average Order Value.
- Line chart: Revenue by month using Date[Year Month], sorted chronologically.
- Clustered bar: Revenue and Gross Profit by region.
- Donut: Revenue by sales channel.
- Slicers: Year, Region, Category and Customer Segment.

## Page 2 — Product & Category
- Bar chart: Top 10 products by Revenue, descending.
- Matrix: Category → Product with Revenue, Gross Profit, Gross Margin % and Units Sold.
- Scatter: Product Revenue vs Gross Profit; bubble size = Units Sold.
- Slicers: Category and Region.

## Page 3 — Trends & Detail
- Line chart: Revenue and Gross Profit by month.
- Column chart: Month-over-month revenue change.
- Detail table: Order ID, date, region, product, quantity, revenue and gross profit.
- Optional drill-through page filtered to selected product.

## Model
Fact table: Sales (one row per order line). Date dimension: Date (one row per date).
Relationship: Date[Date] (1) → Sales[OrderDate] (*), single direction.
Sort Date[Month] by Date[Month Number]. Use explicit measures for financial KPIs.

## Design
Use a 16:9 canvas, clear titles, restrained palette, aligned KPI cards, INR currency formatting and accessible contrast. Avoid 3D charts and clutter.

## QA checklist
- Cancelled orders excluded from Revenue, Cost, Orders and Units Sold.
- Revenue and Gross Profit reconcile to row-level calculations.
- Date slicer filters all time visuals.
- Region/category slicers cross-filter expected visuals.
- Currency shown as INR (₹); percentages to one decimal place.
- Add a screenshot of the final report after building the PBIX.
