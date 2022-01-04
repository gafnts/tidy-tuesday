
# (a) Dependencies ----

library(tidyverse)
library(comtradr)
library(here)

# (b) Extraction functions ----

## Comtrade parameters
search <-
  function(partner, year) {
    data <- ct_search(
      reporters = "Guatemala",
      partners = partner,
      trade_direction = "all",
      start_date = year,
      end_date = year,
      commod_codes = "total"
    )
  }

## Extraction loop
get <-
  function(partners, years) {
    data <- data.frame()
    for (year in years) {
      query <- search(partners, year)
      data <- rbind(data, query)
    }
    data %>%
      as_tibble()
  }

## Export as csv
write <-
  function(data) {
    name <- deparse(substitute(data))
    write_csv(data,
              file = paste0(
                here::here(),
                "/2022/01 — Bring your own data/Data/",
                name,
                ".csv"
              ))
  }

# (c) Data extraction ----

data <-
  get(
    partners = c("USA", "Mexico", "El Salvador", "China"),
    years = c(1995:2020)
  )

write(data)
