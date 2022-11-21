library(RODBC)

oracle_user <- "usernamehere"
oracle_password <- "passwordhere"
oracle_server <- "servername"
oracle_port <- "1521"
oracle_service <- "servicename"

# Connect with DSN
#oracle_odbc <- odbcConnect(dbDriver(Oracle), dsn="mydsn", uid=oracle_user, pwd=oracle_password)

# Connect with TNS
oracle_tns <- sprintf("Driver={Oracle}; dbq=mytns; uid=%s; pwd=%s", oracle_user, oracle_password)
#oracle_odbc <- odbcDriverConnect(oracle_tns)

# Connect with full string
oracle_string <- sprintf("Driver={Oracle}; host=%s; port=%s; svc=%s; uid=%s; pwd=%s", oracle_server, oracle_port, oracle_service, oracle_user, oracle_password)
oracle_odbc <- odbcDriverConnect(oracle_string)

# Test connection by getting the database schema for the service
oracle_schemas <- "SELECT username AS schema_name FROM sys.all_users ORDER BY username;"

# Run query
df_schemas <- sqlQuery(oracle_odbc, oracle_schemas)

# Display tables
df_schemas

# Clone connection
close(oracle_odbc)