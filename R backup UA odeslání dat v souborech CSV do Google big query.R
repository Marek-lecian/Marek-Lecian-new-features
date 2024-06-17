# Cíl skriptu: Přeposlat data ve formě CSV ze zálohovacího skriptu Universal analytics do Google big query

# Autor: Marek Lecián
# Kontakt: marek.lecian@gmail.com
# Licence Creative Commons Attribution-ShareAlike 4.0 International - Uveďte autora, Zachovejte licenci. .
# 2024-04-04

# ------------------------------------------------
# ----- Instalace balíčku potřebných k backupu ---
# ------------------------------------------------


#auto instalace baliceku, kdyz chybi
list.of.packages <- c("googleAuthR","bigrquery","stringr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(googleAuthR)
library(stringr)
library("bigrquery")

# ------------------------------------------------
# ----- Přihlášení do Google  --------------------
# ------------------------------------------------

bigrquery::bq_auth()




# ------------------------------------------------
# ----- Nastavení --------------------------------
# ------------------------------------------------


# Nastavení projektu a datové sady BigQuery
project_id <- "Google-cloud-project-name" # Google cloud project name

#dataset ID > je potřeba si v projektu v big query vytvořit dataset a pak ho sem zadat
dataset_id <- "ua_vasedomena_backup"



# Regulární výraz pro najítí všech souborů k uploadu do BQ.
filenames <- list.files(pattern = ".*ua_.*csv") 
# Regulární výraz, změňte dle potřeby, má najít soubory co chcete poslat do BQ.

# test jestli to najde soubory, které chcete
for (filename in filenames) {
  # Získání názvu tabulky
  table_name <- gsub("(_20).*.csv", "", filename)
  print(table_name)
}


# Pokud to jsou soubory co chceš poslat do BQ, stačí spustít následující skript.
# Pokud ne, uprav předešlý regulární výraz


for (filename in filenames) {
  # Získání názvu tabulky
  table_name <- gsub("(_20).*.csv", "", filename)
  print(table_name)
  
  
  rm(dates);rm(start_date);rm(end_date);
  dates <- str_match_all(filename, "(?<=_)([0-9]{4}-[0-9]{2}-[0-9]{2})(?=[_.]).")
  
  start_date <- gsub("[-_.]", "", dates[[1]][1])
  end_date <- gsub("[-_.]", "", dates[[1]][2])
  
  print(paste("Start date:", start_date))
  print(paste("End date:", end_date))
  
  
  rm(df_upload)
  df_upload<-read.csv(filename, header = TRUE,  fileEncoding = "UTF-8")
  print(filename)
  rm(bq_ua_data)
  bq_ua_data <- bq_table(bq_dataset(project_id,
                                    dataset_id),
                         table_name)
  bq_table_create(
    bq_ua_data,
    fields = df_upload,
    friendly_name = table_name,
    description = paste("Data z Universal analytics, stáhnute skriptem od Marek Lecian ", filename),
    labels = list(input = "universal_analytics", "createdby" = "marek_lecian", backupdatestart=start_date,backupdateend=end_date, backupdate = strftime(as.POSIXlt(Sys.time(), "UTC") , "%Y-%m-%d"))
  )
  print("table created")
  bq_table_upload(bq_ua_data, df_upload)
  print("table uploaded")
  
}
