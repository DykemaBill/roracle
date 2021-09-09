######################################################################
### title: "Oracle ODBC Test"                                      ###
### author: "Dykema, Bill"                                         ###
### date: "2021/08/18"                                             ###
######################################################################

## Read data from CSV file, not using this just yet
csv_test <- read.csv("testtable_source.csv", stringsAsFactors=FALSE)

## Connect to Oracle ODBC DSN
#install.packages("RODBC")
library(RODBC)
#oracle_odbc <- odbcConnect("DSNNameHere", uid="oracleidhere", pwd="passwordhere")
oracle_odbc <- odbcConnect("DSNNameHere")

## Create table if needed
#sqlQuery(oracle_odbc, "CREATE TABLE testtable (test_datetime TIMESTAMP NOT NULL, test_number INT, test_text VARCHAR2(50))")

## Run query
records_test <- sqlQuery(oracle_odbc, "SELECT * FROM testtable")

## Display summary of records returned
summary(records_test)

## Get the current date and time
now_is = Sys.time()

## Store a random Int
db_numfield <- floor(runif(1, 1, 1000000))

## Store some text
db_textfield <- "This is some test text!"

## Insert a new record
my_insert <- sprintf("INSERT INTO testtable (test_datetime, test_number, test_text) VALUES (TO_DATE('%s', 'YYYY/MM/DD HH24:MI:SS'), '%d', '%s')", now_is, db_numfield, db_textfield)
sqlQuery(oracle_odbc, my_insert)

## Run query again
records_test <- sqlQuery(oracle_odbc, "SELECT * FROM testtable")

## Display summary of records returned
summary(records_test)

## Write data out to CSV file
write.csv(records_test, "testtable_new.csv", row.names = FALSE)
