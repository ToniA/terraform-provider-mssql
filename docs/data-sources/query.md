---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "mssql_query Data Source - terraform-provider-mssql"
subcategory: ""
description: |-
  Retrieves arbitrary SQL query result.
  -> Note This data source is meant to be an escape hatch for all cases not supported by the provider's data sources. Whenever possible, use dedicated data sources, which offer better plan, validation and error reporting.
---

# mssql_query (Data Source)

Retrieves arbitrary SQL query result.

-> **Note** This data source is meant to be an escape hatch for all cases not supported by the provider's data sources. Whenever possible, use dedicated data sources, which offer better plan, validation and error reporting.

## Example Usage

```terraform
data "mssql_database" "test" {
  name = "test"
}

data "mssql_query" "column" {
  database_id = data.mssql_database.test.id
  query       = "SELECT [column_id], [name] FROM sys.columns WHERE [object_id] = OBJECT_ID('test_table')"
}

output "column_names" {
  value = data.mssql_query.column.result[*].name
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `database_id` (String) ID of database. Can be retrieved using `mssql_database` or `SELECT DB_ID('<db_name>')`.
- `query` (String) SQL query returning single result set, with any number of rows, where all columns are strings

### Read-Only

- `id` (String) Used only internally by Terraform. Always set to `query`
- `result` (List of Map of String) Results of the SQL query, represented as list of maps, where the map key corresponds to column name and the value is the value of column in given row.

