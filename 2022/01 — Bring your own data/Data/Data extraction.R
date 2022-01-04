
# (a) Dependencies ----

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, here, comtradr)

# (b) Extraction functions ----

## Comtrade search parameters
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

## Export as .rds
write <-
  function(data) {
    name <- deparse(substitute(data))
    write_rds(data, file = paste0("../2022/01 — Bring your own data/Data/", name, ".rds"))
  }

write <-
  function(data) {
    name <- deparse(substitute(data))
    write_rds(data, file = paste0(here::here(), "/2022/01 — Bring your own data/Data/", 
                                  name, ".rds"))
  }

# (c) Data extraction ----

df <-
  get(partners = c("USA", "Mexico", "El Salvador", "China"),
      years = c(1995:2020))
write(df)


