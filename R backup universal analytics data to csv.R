# Cíl skriptu: Záloha dat z Universal analytics než je Google finálně smaže.
# Co skript dělá?
# Stáhne detailní data z Universal analytics.

# Je tento skript pro všechny? Ne
# Potřebuji lidi takto detailní data? Už vůbec Ne.
# Pro koho to je? Data driven šefy, co řeší věcí v rozsahu desítek let a zajímají je trendy.
# Co dělat kdy tohle je moc? Zálohovat si totálně základní data přes Google sheet a Google analytics plugin.


# Velikost webu vs tento skript. 
# Zvládné to i super velké weby, ale bach, aby vám ty data k něčemu byla.
# Pokud máte web kolem 100k page_views, asi může spustit vše. Stáhnutí bude trvat kolem 5-10min.
# Pokud máte web kolem 1M page_views asi může spustit vše. Stáhnutí bude trvat kolem 2hod. Ale asi vám nemusíte stahovat detailní data.
# Pokud máte web kolem 10M page_views. Stáhnutí bude trvat kolem 10-15hod, proto si vyberte jen důležité data na stáhnutí.
# Pokud máte web kolem 100M page_views. Jedna tabulka může trvat stáhnout i 2-3hod, pokud to je třeba jen návštěvnost. 
# Pokud stahujete velké webu narazíte na limit počtu stažení za den. Limit je 10k requestů za GA view / den.

# Autor: Marek Lecián
# Kontakt: marek.lecian@gmail.com

# Licence:
# Licence Creative Commons Attribution-ShareAlike 4.0 International - Uveďte autora, Zachovejte licenci. .

# Pokud to použijete na velkých klientech nebo v agenturách pro zálohu všech klientů a hodně vám to pomůže, tak mi ideálně pošlete po domluvě nějaký dárek. ;)
# Pokud si zálohujete jen své weby, tak mějte pěkný den ;) .

# Poznámky.
# První si to otestvujete na pár dne dat.
# U velkých webu to může trvat super dlouho stáhnout, zvláště detailní data o stránce, události nebo ecommerce.

# Dostanete super detailní návod? 
# Nedostanete :), možná, kdybych měl čas, ale moc nemám.
# Pokud s neorientuje v jazyku R, tak to může být těžké, není to pro každého. 
# Můžete to zkusit, těžké to není, ale nebudu vám pomáhat.

# Skript se skládá ze tří částí.
# Každou z části spouštějšte samostatně.
# Poslední část jsou jednotlivé skripty nebo bloky skriptu, co nepotřebujete nespouštějte.
# Pokud výstupní soubor má 4 bajty, tak je správný a můžete ho smazat. Není to špatně, né každý má všechno implementované.

# Kromě toho skriptu vám doporučuji si zálohovat cíle z UA, aby jste věděli, co znamenali.


######################################
##  Část 1 - Instalace balíčků #######
##  Instalace R balíčku  #############
##  Přihlášení #######################
######################################


# ------------------------------------------------
# ----- Instalace balíčku potřebných k backupu ---
# ------------------------------------------------

#auto instalace balicek, kdyz chybi
list.of.packages <- c("googleAnalyticsR","googleAuthR")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


## Knihovna 
# https://cran.r-project.org/web/packages/googleAnalyticsR/googleAnalyticsR.pdf
library(googleAnalyticsR) # https://www.quantargo.com/help/r/latest/packages/googleAnalyticsR/1.0.0/google_analytics

#prihlaseni
library(googleAuthR) # https://www.quantargo.com/help/r/latest/packages/googleAuthR/1.4.0
#prihlaseni v Rstudio etc. #ga_auth()

# očistění dat
ocisteni_dat <- function(df) {
  # Vytvoří vektor sloupců
  sloupce <- names(df)
  
  # Projde každý sloupec
  for (i in sloupce) {
    # Nahradí tabulátory a bílé znaky mezerami
    df[[i]] <- gsub("\\s+", " ", df[[i]]); #smazat speciální prázdné znaky
    df[[i]] <- gsub("\"", "", df[[i]]);    #smazat uvozovky
    df[[i]] <- gsub("\'", "", df[[i]]);    #smazat uvozovky
    df[[i]] <- gsub(";", "", df[[i]]);     #smazat středník
  }
  
  # Vrátí dataframe s nahrazenými znaky
  return(df)
}


# ------------------------------------------------
# ----- Přihlášení do Google  --------------------
# ------------------------------------------------
# Pozor musíte se přihlásit
# Pokud to děláte poprvé, vyskočí vám okno v prohlížeči kde musíte provést 
# přihlášení do vašeho Google učetu a přidat potřebná práva.
# Pokud to děláte po několikáté, tak už to bude chtít jen volbu účtu.
# Pokud jste už přihlášení 1x za skript spustili a nechcete se
# přihlásit na jiný učet nemusíte už to spouštět.

ga_auth()

#
#
#
#
#

######################################
##  Část 2 - Nastavení ###############
######################################

# Výběr a pojmenování Google universal view
ua_view_id  <- 00000000 #id vaseho GA view  (GA view ID (je to jen číslo). A NE GA property (UA-00000-0))
ua_view_name <- "ua_vašedoména_cz" # jmeno vaseho GA view

den1   <- as.Date("2023-01-01") # Od kdy to stahnout? YYYY-MM-DD
den2   <- as.Date("2023-02-01") # Do kdy? 

#  Výstup:
#  CSV soubor s jménem GA UA view, jménem tabulky a rozsahem dat v tabulce
#  Pro kontrolu zde máte ještě proměnou v R s tabulkou.

# Doporučení spouštějete skript po částech, pokud nevíte velikost webu a náročnost.

# Řazení skriptů:
# 1) základní tabulky na úrovni dne, měsíce, roku. Ideální pro rychlou zálohu.
# 2) Větší data, URL zobraných stránek, eventy etc.
# 3) Ecommerce, pokud jste e-shop.
# 4) Detailní data - Pozor, Google nevrátí všechno, ale jen poslední rok. Je tam data retention protože data jsou moc detailní.

######################################
##  Část 3 - stahování dat    ########
######################################

#
#
#
#
#


######################################
## Složitost stáhnutí dat minimální ##
######################################

## Měření času stahování bloku.
start_time <- Sys.time()

############## users years
tablename <- "_users_years_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:year")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,den1,'_',den2,'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_years<-df;rm(df);filename;rm(filename)

############## users months
tablename <- "_users_month_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:yearMonth")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,den1,'_',den2,'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_month<-df;rm(df);filename;rm(filename)

############## users day
tablename<-"_users_day_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_day<-df;rm(df);filename;rm(filename)

############### Sessions channelGrouping
rm(df);rm(tablename);rm(filename);
tablename<-"_session_channelgrouping_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                       ,dimensions = c("ga:date","ga:channelGrouping")
                       ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename; df_channelgrouping<-df;rm(df);rm(tablename);rm(filename);

############### Sessions basic
rm(df);rm(tablename);rm(filename);
tablename<-"_session_basic_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:campaign")
                       ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename; df_sessions_basic<-df;rm(df);rm(tablename);rm(filename);

############### Sessions goals 1-10
rm(df);rm(tablename);rm(filename);
tablename<-"_session_basic_goals1_10_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:goal1Completions","ga:goal2Completions","ga:goal3Completions","ga:goal4Completions","ga:goal5Completions","ga:goal6Completions","ga:goal7Completions","ga:goal8Completions","ga:goal9Completions","ga:goal10Completions")
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:campaign")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename;df_sessions_basic_goals1_10_<-df;rm(df);rm(tablename);rm(filename);

############### Sessions goals 11-20
rm(df);rm(tablename);rm(filename);
tablename<-"_session_basic_goals11_20_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:goal11Completions","ga:goal12Completions","ga:goal13Completions","ga:goal14Completions","ga:goal15Completions","ga:goal16Completions","ga:goal17Completions","ga:goal18Completions","ga:goal19Completions","ga:goal20Completions")
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:campaign")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename; df_sessions_basic_goals11_20_<-df; rm(df);rm(tablename);rm(filename);


############## Device only
tablename<-"_device_only_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:deviceCategory")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_device_only<-df;rm(df);filename;rm(filename)

############## Country
tablename<-"_country_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:country","ga:city")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_country<-df;rm(df);filename;rm(filename)

############## users retention - sessionCount
tablename<-"_users_retention_sessioncount_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date", "ga:sessionCount")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_retention_sessioncount<-df;rm(df);filename;rm(filename)


############## users demographic age
tablename<-"_users_demographic_age_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:userAgeBracket")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_demographic_age<-df;rm(df);filename;rm(filename)

############## users demographic usergender 
tablename<-"_users_demographic_usergender_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:userGender")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_demographic_usergender<-df;rm(df);filename;rm(filename)

############## page speed date
tablename<-"_page_speed_date_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:pageviews","ga:avgPageLoadTime","ga:avgDomainLookupTime","ga:avgPageDownloadTime","ga:avgRedirectionTime","ga:avgServerConnectionTime","ga:avgServerResponseTime","ga:avgDomInteractiveTime","ga:avgDomContentLoadedTime")
                              ,dimensions = c("ga:date")
                              ,filtersExpression = "ga:avgPageLoadTime!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_page_speed_date<-df;rm(df);filename;rm(filename)


## Měření času stahování bloku.
end_time <- Sys.time()
time_diff_basic <- end_time - start_time
print(time_diff_basic)

#
#
#
#
#

######################################
######################################
## Složitost stáhnutí dat střední   ##
######################################
######################################

## Měření času stahování bloku.
start_time <- Sys.time()

############## users demographic detail
tablename<-"_users_demographic_detail_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:userAgeBracket", "ga:userGender", "ga:userType")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_demographic_detail<-df;rm(df);filename;rm(filename)

############### Sessions seo keywords basic
rm(df);rm(tablename);rm(filename);
tablename<-"_session_basic_seo_keywords_basic_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:keyword")
                       ,filtersExpression = "ga:keyword!=(not set);ga:keyword!=(not provided);ga:sourceMedium=~organic"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename; df_session_basic_seo_keywords_basic<-df;rm(df);rm(tablename);rm(filename);


############## Pageviews basic
# Bacha výší náročnost u velkých projektů.
tablename<-"_pageviews_basic_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:pageviews","ga:uniquePageviews","ga:entrances","ga:exits","ga:bounces","ga:bounceRate","ga:timeOnPage","ga:avgTimeOnPage")
                              ,dimensions = c("ga:date", "ga:pagePath")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_pageviews_basic<-df;rm(df);filename;rm(filename)

############## Internal Site Search Analysis
tablename<-"_search_internal_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:users","ga:sessions","ga:pageviews","ga:uniquePageviews","ga:searchResultViews", "ga:searchUniques")
                              ,dimensions = c("ga:date","ga:searchKeyword", "ga:searchStartPage", "ga:searchCategory")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_search_internal<-df;rm(df);filename;rm(filename)

############## Events basic
tablename<-"_events_basic_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:users","ga:totalEvents","ga:uniqueEvents","ga:eventValue","ga:avgEventValue")
                              ,dimensions = c("ga:date","ga:pagePath","ga:eventCategory","ga:eventAction","ga:eventLabel")
                              #,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_events_basic<-df;rm(df);filename;rm(filename)


## Měření času stahování bloku.
end_time <- Sys.time()
time_diff_pages <- end_time - start_time
print(time_diff_pages)


#
#
#
#
#


######################################
######################################
##              Ecommerce           ##
######################################
## Složitost stáhnutí dat VYSOKÁ    ##
######################################
######################################

## Měření času stahování bloku.
start_time <- Sys.time()


############## ecom products
tablename<-"_ecom_products_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:productListViews","ga:productListClicks","ga:productListCTR","ga:productDetailViews","ga:productAddsToCart","ga:productCheckouts","ga:itemRevenue")
                              ,dimensions = c("ga:date","ga:productSku","ga:productName","ga:productBrand","ga:productCategoryHierarchy")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_ecom_products_<-df;rm(df);filename;rm(filename)

############## ecom products impresion list
tablename<-"_ecom_products_product_list_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:productListViews","ga:productListClicks","ga:productListCTR","ga:productDetailViews","ga:productAddsToCart","ga:productCheckouts","ga:itemRevenue")
                              ,dimensions = c("ga:date","ga:productListName","ga:productSku","ga:productName","ga:productBrand","ga:productCategoryHierarchy")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_ecom_products_product_list_<-df;rm(df);filename;rm(filename)

############## ecom products
tablename<-"_ecom_products_sourcemedium"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:productListViews","ga:productListClicks","ga:productListCTR","ga:productDetailViews","ga:productAddsToCart","ga:productCheckouts","ga:itemRevenue")
                              ,dimensions = c("ga:date","ga:productSku","ga:productName","ga:productBrand","ga:productCategoryHierarchy","ga:sourceMedium")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_ecom_products_sourcemedium<-df;rm(df);filename;rm(filename)

############## ecom transaction items
tablename<-"_transaction_items_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:itemQuantity","ga:itemRevenue")
                              ,dimensions = c("ga:date","ga:transactionId","ga:productSku","ga:productName","ga:productBrand","ga:productCategoryHierarchy")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_transaction_items<-df;rm(df);filename;rm(filename)

############## ecom transaction detail
tablename<-"_transaction_detail_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:transactions","ga:transactionRevenue","ga:transactionShipping","ga:transactionTax")
                              ,dimensions = c("ga:date","ga:transactionId","ga:campaign","ga:sourceMedium")
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_transaction_detail<-df;rm(df);filename;rm(filename)

############## ecom users shopping stage
tablename<-"_users_shopping_stage_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:shoppingStage")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_shopping_stage<-df;rm(df);filename;rm(filename)

############## ecom internal promo
tablename<-"_internal_promo_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:internalPromotionViews","ga:internalPromotionCTR","ga:internalPromotionClicks","ga:users","ga:sessions","ga:pageviews","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:internalPromotionCreative","ga:internalPromotionId","ga:internalPromotionName","ga:internalPromotionPosition")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_internal_promo_<-df;rm(df);filename;rm(filename)


## Měření času stahování bloku.
end_time <- Sys.time()
time_diff_ecom <- end_time - start_time
print(time_diff_ecom)



###############################################
###############################################
##  Super Detailní tabulky #################### 
###############################################
## Složitost stáhnutí datVYSOKÁ  ##############
###############################################
## Tyto data nebudou nejspíše kompletní  ######
## protože je omezená životnost ###############
## díky data retention ########################   
###############################################

############## page speed
#	ga:pageviews	 - 	Pageviews	 - 	The total number of pageviews for your property.
#	ga:avgPageLoadTime	 - 	Avg. Page Load Time (sec)	 - 	The average amount of time (in seconds) it takes for pages from the sample set to load, from initiation of the pageview (e.g. click on a page link) to load completion in the browser.
#	ga:avgDomainLookupTime	 - 	Avg. Domain Lookup Time (sec)	 - 	The average amount of time (in seconds) spent in DNS lookup for this page.
#	ga:avgPageDownloadTime	 - 	Avg. Page Download Time (sec)	 - 	The average amount of time (in seconds) to download this page.
#	ga:avgRedirectionTime	 - 	Avg. Redirection Time (sec)	 - 	The average amount of time (in seconds) spent in redirects before fetching this page. If there are no redirects, the value for this metric is expected to be 0.
#	ga:avgServerConnectionTime	 - 	Avg. Server Connection Time (sec)	 - 	The average amount of time (in seconds) spent in establishing TCP connection for this page.
#	ga:avgServerResponseTime	 - 	Avg. Server Response Time (sec)	 - 	The average amount of time (in seconds) your server takes to respond to a user request, including the network time from user's location to your server.
#	ga:avgDomInteractiveTime	 - 	Avg. Document Interactive Time (sec)	 - 	The average time (in seconds) it takes the browser to parse the document and execute deferred and parser-inserted scripts including the network time from the user's location to your server.
#	ga:avgDomContentLoadedTime	 - 	Avg. Document Content Loaded Time (sec)	 - 	The average time (in seconds) it takes the browser to parse the document.

start_time <- Sys.time()


tablename<-"_page_speed_detail"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:pageviews","ga:avgPageLoadTime","ga:avgDomainLookupTime","ga:avgPageDownloadTime","ga:avgRedirectionTime","ga:avgServerConnectionTime","ga:avgServerResponseTime","ga:avgDomInteractiveTime","ga:avgDomContentLoadedTime")
                              ,dimensions = c("ga:date","ga:deviceCategory","ga:country","ga:hostname","ga:pagePath")
                              ,filtersExpression = "ga:avgPageLoadTime!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_page_speed<-df;rm(df);filename;rm(filename)

############## Events detail
tablename<-"_events_detail_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:users","ga:totalEvents","ga:uniqueEvents","ga:eventValue","ga:avgEventValue")
                              ,dimensions = c("ga:date","ga:country","ga:language","ga:pagePath","ga:eventCategory","ga:eventAction","ga:eventLabel")
                              # ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_events_detail<-df;rm(df);filename;rm(filename)

############## Pageviews
tablename<-"_pageviews_detail_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:pageviews","ga:uniquePageviews","ga:entrances","ga:exits","ga:bounces","ga:bounceRate","ga:timeOnPage","ga:avgTimeOnPage")
                              ,dimensions = c("ga:date","ga:pagePath","ga:hostname","ga:deviceCategory","ga:country","ga:language")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_pageviews_detail<-df;rm(df);filename;rm(filename)

############## Pageviews path - User Journey Analysis
tablename<-"_pageviews_path_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:pageviews","ga:uniquePageviews","ga:entrances","ga:exits","ga:bounces","ga:bounceRate","ga:timeOnPage","ga:avgTimeOnPage")
                              ,dimensions = c("ga:date","ga:landingPagePath", "ga:exitPagePath", "ga:pagePath", "ga:previousPagePath")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_pageviews_path<-df;rm(df);filename;rm(filename)


############### Sessions detail probably cuted by user date retention
rm(df);rm(tablename);rm(filename);
tablename<-"_session_detail_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:campaign","ga:adContent","ga:landingPagePath","ga:language","ga:fullReferrer")
                       ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_sessions<-df;rm(df);rm(tablename);rm(filename)

#	ga:users	 - 	Users	 - 	The total number of users for the requested time period.
#	ga:sessions	 - 	Sessions	 - 	The total number of sessions.
#	ga:pageviews	 - 	Pageviews	 - 	The total number of pageviews for your property.
#	ga:bounces	 - 	Bounces	 - 	The total number of single page (or single engagement hit) sessions for your property.
#	ga:bounceRate	 - 	Bounce Rate	 - 	The percentage of single-page session (i.e., session in which the person left your property from the first page).
#	ga:sessionDuration	 - 	Session Duration	 - 	The total duration of user sessions represented in total seconds.
#	ga:avgSessionDuration	 - 	Avg. Session Duration	 - 	The average duration of user sessions represented in total seconds.
#	ga:goalCompletionsAll	 - 	Goal Completions	 - 	The total number of completions for all goals defined for your profile.
#	ga:transactions	 - 	Transactions	 - 	The total number of transactions.
#	ga:transactionRevenue	 - 	Revenue	 - 	The total sale revenue provided in the transaction excluding shipping and tax.

#	ga:date	 - 	Date	 - 	The date of the session formatted as YYYYMMDD.
#	ga:sourceMedium	 - 	Source / Medium	 - 	Combined values of ga:source and ga:medium.
#	ga:campaign	 - 	Campaign	 - 	When using manual campaign tracking, the value of the utm_campaign campaign tracking parameter. When using AdWords autotagging, the name(s) of the online ad campaign that you use for your property. Otherwise the value (not set) is used.
#	ga:adContent	 - 	Ad Content	 - 	When using manual campaign tracking, the value of the utm_content campaign tracking parameter. When using AdWords autotagging, the first line of the text for your online Ad campaign. If you are using mad libs for your AdWords content, this field displays the keywords you provided for the mad libs keyword match. Otherwise the value is (not set)
#	ga:landingPagePath	 - 	Landing Page	 - 	The first page in a user's session, or landing page.
#	ga:language	 - 	Language	 - 	The language provided by the HTTP Request for the browser. Values are given as an ISO-639 code (e.g. en-gb for British English).
#	ga:fullReferrer	 - 	Full Referrer	 - 	The full referring URL including the hostname and path.


############### Sessions seo keywords detailed
rm(df);rm(tablename);rm(filename);
tablename<-"_session_basic_seo_keywords_"
df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                       ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                       ,dimensions = c("ga:date","ga:sourceMedium","ga:landingPagePath","ga:keyword")
                       ,filtersExpression = "ga:keyword!=(not set);ga:keyword!=(not provided);ga:sourceMedium=~organic"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
filename; df_session_basic_seo_keywords<-df;rm(df);rm(tablename);rm(filename)

############## Device detailed
tablename<-"_device_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:deviceCategory", "ga:browser", "ga:operatingSystem")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_device<-df;rm(df);filename;rm(filename)

############## users retention - Audience Loyalty and Retention
tablename<-"_users_retention_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics = c("ga:users","ga:sessions","ga:pageviews","ga:bounces","ga:bounceRate","ga:sessionDuration","ga:avgSessionDuration","ga:goalCompletionsAll","ga:transactions","ga:transactionRevenue") #basic session metrics
                              ,dimensions = c("ga:date","ga:userType", "ga:sessionCount", "ga:daysSinceLastSession")
                              ,filtersExpression = "ga:pageviews!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_users_retention<-df;rm(df);filename;rm(filename)

############## page speed detail
tablename<-"_page_speed_"
rm(df);df <- google_analytics(ua_view_id,date_range = c(den1, den2),anti_sample = TRUE
                              ,metrics =    c("ga:pageviews","ga:avgPageLoadTime","ga:avgDomainLookupTime","ga:avgPageDownloadTime","ga:avgRedirectionTime","ga:avgServerConnectionTime","ga:avgServerResponseTime","ga:avgDomInteractiveTime","ga:avgDomContentLoadedTime")
                              ,dimensions = c("ga:date","ga:deviceCategory","ga:country","ga:hostname","ga:pagePath")
                              ,filtersExpression = "ga:avgPageLoadTime!=0"
)
df<-ocisteni_dat(df)
filename<- paste(ua_view_name,tablename,min(df$date, na.rm = TRUE),'_',max(df$date, na.rm = TRUE),'.csv', sep='');rm(tablename)
file.create(filename);write.csv(df,file = filename, fileEncoding = "UTF-8", row.names = FALSE)
df_page_speed<-df;rm(df);filename;rm(filename)


## Měření času stahování bloku.
end_time <- Sys.time()
time_diff_detail <- end_time - start_time
print(time_diff_detail)
