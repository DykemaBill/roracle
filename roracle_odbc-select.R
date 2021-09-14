######################################################################
### title: "ODBC DSN by Folder Location"                           ###
### author: "Dykema, Bill"                                         ###
### date: "2021/09/08"                                             ###
######################################################################

# Read server variables for the Oracle ODBC DSN
env_dsn_dev <- Sys.getenv("R_DSN_DEV")    # Dev Oracle ODBC DSN name
env_dsn_crt <- Sys.getenv("R_DSN_CRT")    # Test Oracle ODBC DSN name
env_dsn_prd <- Sys.getenv("R_DSN_PRD")    # Production Oracle ODBC DSN name

# Current folder
env_folder <- getwd()

# Set Oracle ODBC DSN based on folder
if (grepl("/PRD", env_folder, fixed = TRUE)) {        # "/PRD"
  odbc_dsn <- env_dsn_prd
} else if (grepl("/CRT", env_folder, fixed = TRUE)) { # "/CRT"
  odbc_dsn <- env_dsn_crt
} else {                                              # Dev
  odbc_dsn <- env_dsn_dev
}

# Load ODBC library
library(RODBC)