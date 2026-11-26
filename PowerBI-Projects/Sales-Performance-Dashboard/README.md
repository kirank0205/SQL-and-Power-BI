# Sales Performance Dashboard | Power BI

## Objective
Build an executive dashboard to monitor revenue, order volume, profitability, product mix and regional performance.

## Included source files
- data/sales_dashboard_data.csv — synthetic order-line data in INR.
- dax/measures.dax — KPI and time-intelligence measures.
- power-query/transform.m — example Power Query transformations.
- dashboard-design/report-specification.md — report pages, visuals and QA checklist.

## Build steps in Power BI Desktop
1. Get Data → Text/CSV → import the CSV.
2. Apply the data types and transformations in power-query/transform.m (update the file path).
3. Create a Date table using the DAX definition in dax/measures.dax and mark it as the date table.
4. Create a one-to-many relationship: Date[Date] to Sales[OrderDate].
5. Add the measures from dax/measures.dax.
6. Build pages using dashboard-design/report-specification.md.
7. Save as Sales_Performance_Dashboard.pbix in this folder.

## Validation
Exclude cancelled orders from commercial KPIs. Revenue = quantity × unit price. Gross profit = quantity × (unit price − unit cost). Reconcile totals to row-level calculations.

The repository provides editable source materials and instructions; the native PBIX must be generated in Power BI Desktop. Dataset is synthetic and not from a real company.
