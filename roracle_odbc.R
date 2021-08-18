---
  title: "Oracle ODBC Test"
author: "Dykema, Bill - DataTenant"
date: "2021/08/18"
output:
  html_document: default
---
  
## Connect to Oracle ODBC DSN
oracle_odbc <- odbcConnect("DSNNameHere", uid="oracleidhere", pwd="passwordhere")

## Run query
records_test <- sqlQuery(oracle_odbc, "SELECT * FROM testtable")

## Display summary of records returned
summary(records_test)