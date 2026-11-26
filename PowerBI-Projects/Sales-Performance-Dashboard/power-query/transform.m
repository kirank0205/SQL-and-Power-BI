// Power Query M example. Change the source path for your computer.
let
 Source = Csv.Document(
  File.Contents("C:\\Data\\sales_dashboard_data.csv"),
  [Delimiter=",",Encoding=65001,QuoteStyle=QuoteStyle.Csv]
 ),
 PromotedHeaders = Table.PromoteHeaders(Source,[PromoteAllScalars=true]),
 ChangedTypes = Table.TransformColumnTypes(PromotedHeaders,{
  {"OrderID",type text},{"OrderDate",type date},{"Region",type text},
  {"SalesChannel",type text},{"Category",type text},{"Product",type text},
  {"CustomerSegment",type text},{"Quantity",Int64.Type},
  {"UnitPrice",Currency.Type},{"UnitCost",Currency.Type},{"OrderStatus",type text}
 }),
 AddedRevenue = Table.AddColumn(ChangedTypes,"LineRevenue",
  each [Quantity]*[UnitPrice],Currency.Type),
 AddedGrossProfit = Table.AddColumn(AddedRevenue,"LineGrossProfit",
  each [Quantity]*([UnitPrice]-[UnitCost]),Currency.Type)
in
 AddedGrossProfit
