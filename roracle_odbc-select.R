######################################################################
### title: "ODBC DSN by Folder Location"                           ###
### author: "Dykema, Bill"                                         ###
### date: "2021/09/08"                                             ###
######################################################################

# Read server variables for Oracle ODBC DSN connections
# AREA1
env_dsn_area1_dev <- Sys.getenv("R_DSN_AREA1_DEV")
env_dsn_area1_crt <- Sys.getenv("R_DSN_AREA1_CRT")
env_dsn_area1_prd <- Sys.getenv("R_DSN_AREA1_PRD")
# AREA2
env_dsn_area2_dev <- Sys.getenv("R_DSN_AREA2_DEV")
env_dsn_area2_crt <- Sys.getenv("R_DSN_AREA2_CRT")
env_dsn_area2_prd <- Sys.getenv("R_DSN_AREA2_PRD")

# Get folder to location of script calling this script
#install.packages("tidyverse")
library(tidyverse)

# Current folder (this only works when this script is called from another R script)
this_file <- commandArgs() %>% 
  tibble::enframe(name = NULL) %>%
  tidyr::separate(col=value, into=c("key", "value"), sep="=", fill='right') %>%
  dplyr::filter(key == "--file") %>%
  dplyr::pull(value)
if (length(this_file)==0)
{
  this_file <- rstudioapi::getSourceEditorContext()$path
}
env_folder <- this_file

# Set Oracle ODBC DSN based on folder of the calling R script file
if (grepl("/PRD", env_folder, fixed = TRUE)) {        # "/PRD"
  odbc_dsn_area1 <- env_dsn_area1_prd
  odbc_dsn_area2 <- env_dsn_area2_prd
} else if (grepl("/CRT", env_folder, fixed = TRUE)) { # "/CRT"
  odbc_dsn_area1 <- env_dsn_area1_crt
  odbc_dsn_area2 <- env_dsn_area2_crt
} else {                                              # /DEV or other
  odbc_dsn_area1 <- env_dsn_area1_dev
  odbc_dsn_area2 <- env_dsn_area2_dev
}

# Load ODBC library
library(RODBC)

# Output of the new variables
cat("AREA1 DSN: ", odbc_dsn_area1, "\n")
cat("AREA2 DSN: ", odbc_dsn_area2, "\n") 