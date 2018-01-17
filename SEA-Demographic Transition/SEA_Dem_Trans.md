This is a reproducible example to produce a tile map that shows
demographic transition (with birth rates and death rates) in the South
East Asia region. We use the `grids.R` script to load custom grids to
align the tiles corresponding to each country's graph. These are all
region based and we will be using the `sea_grid` grid for the plot
produced in this analysis.

Libraries
---------

    library(tidyverse)
    library(geofacet)
    library(kani)

    source("../grids.R")
    options(scipen = 99)

**Note:** I have used a library called `kani` which has some theme
aesthetics for plotting. It can be installed by using
`devtools::install_github("kanishkamisra/kani")` in your R console.

Data import
-----------

We use data from <blank> that contains aggregated birth and death rates
(5 years aggregation) from 1950-1955 to 2010-2015

    birth_rates <- read_csv("Birth_rates.csv")
    death_rates <- read_csv("Death_rates.csv")

    birth_rates <- birth_rates %>%
      gather(`1950-1955`:`2010-2015`, key = "year", value = "birth_rate")

    death_rates <- death_rates %>%
      gather(`1950-1955`:`2010-2015`, key = "year", value = "death_rate")

    demographic_transition <- birth_rates %>%
      inner_join(death_rates)

    demographic_transition

    ## # A tibble: 3,133 x 5
    ##    Country                             `Country … year     birth_… death_…
    ##    <chr>                                    <int> <chr>      <dbl>   <dbl>
    ##  1 WORLD                                      900 1950-19…    36.9    19.1
    ##  2 More developed regions                     901 1950-19…    22.3    10.6
    ##  3 Less developed regions                     902 1950-19…    43.6    23.0
    ##  4 Least developed countries                  941 1950-19…    48.3    28.1
    ##  5 Less developed regions, excluding …        934 1950-19…    43.0    22.4
    ##  6 Less developed regions, excluding …        948 1950-19…    44.4    23.4
    ##  7 High-income countries                     1503 1950-19…    22.5    10.6
    ##  8 Middle-income countries                   1517 1950-19…    41.6    21.6
    ##  9 Upper-middle-income countries             1502 1950-19…    40.1    19.4
    ## 10 Lower-middle-income countries             1501 1950-19…    43.4    24.3
    ## # ... with 3,123 more rows

Wrangling
---------

Since the years are formatted in 5 year intervals, we use the year at
the mid point, rounded to the next whole number to indicate year (makes
it easy to add labels to axis). For example, 1952.5 becomes 1953 for
1950-1955

    get_year <- function(years) {
      return(ceiling(mean(as.numeric(str_split(years, "-")[[1]]))))
    }

    demographic_transition <- demographic_transition %>%
      mutate(
        year = map_dbl(year, get_year)
      )

    demographic_transition

    ## # A tibble: 3,133 x 5
    ##    Country                               `Country c…  year birth_… death_…
    ##    <chr>                                       <int> <dbl>   <dbl>   <dbl>
    ##  1 WORLD                                         900  1953    36.9    19.1
    ##  2 More developed regions                        901  1953    22.3    10.6
    ##  3 Less developed regions                        902  1953    43.6    23.0
    ##  4 Least developed countries                     941  1953    48.3    28.1
    ##  5 Less developed regions, excluding le…         934  1953    43.0    22.4
    ##  6 Less developed regions, excluding Ch…         948  1953    44.4    23.4
    ##  7 High-income countries                        1503  1953    22.5    10.6
    ##  8 Middle-income countries                      1517  1953    41.6    21.6
    ##  9 Upper-middle-income countries                1502  1953    40.1    19.4
    ## 10 Lower-middle-income countries                1501  1953    43.4    24.3
    ## # ... with 3,123 more rows

Plotting demographic transition for one country
-----------------------------------------------

We can take the example of Thailand's birth and death rates as an
example to show demographic transition in the country.

    thailand_dt <- demographic_transition %>%
      filter(Country == "Thailand") %>%
      gather(birth_rate:death_rate, key = "Trend", value = "Rate") %>%
      mutate(Trend = str_to_title(str_replace(Trend, "_", " "))) %>%
      ggplot(aes(year, Rate, color = Trend, group = Trend)) +
      geom_line(size = 1) + 
      geom_hline(yintercept = 0, size = 1) +
      scale_x_continuous(breaks = seq(1950, 2010, by = 10)) + 
      theme_kani() + 
      theme(
        legend.position = "top",
        plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        legend.background = element_rect(fill = "white"),
        legend.key = element_rect(fill = "white"),
        strip.background = element_rect(fill = "white"),
        strip.text.x = element_text(face = "bold")
      ) + 
      labs(
        x = "Year"
      )

    ggsave("thailand_dt.png", thailand_dt)

![Demographic Transition in Thailand - Birth and Death Rates from
1950-2015](thailand_dt.png)

Plotting Demographic Transition in SEA
--------------------------------------

We now use the `geofacet` package to plot birth and death rates in the
South East Asia region. The `sea_grid` in `grids.R` helps us make a grid
for the region which can fit any static, 2D plot as tiles that represent
countries in SEA.

    regional_plot <- function(region_grid) {
      plot <- demographic_transition %>%
        filter(Country %in% region_grid$name) %>%
        gather(birth_rate:death_rate, key = "Trend", value = "Rate") %>%
        mutate(Trend = str_to_title(str_replace(Trend, "_", " "))) %>%
        ggplot(aes(year, Rate, color = Trend, group = Trend)) +
        geom_line(size = 1) + 
        geom_hline(yintercept = 0, size = 1) +
        facet_geo(~Country, grid = region_grid, label = "code") +
        scale_x_continuous(breaks = seq(1950, 2010, by = 20), limits = c(1950, 2015)) + 
        theme_kani() + 
        theme(
          legend.position = "top",
          plot.background = element_rect(fill = "white"),
          panel.background = element_rect(fill = "white"),
          legend.background = element_rect(fill = "white"),
          legend.key = element_rect(fill = "white"),
          strip.background = element_rect(fill = "white"),
          strip.text.x = element_text(face = "bold")
        )
      
      return(plot)
    }

    ggsave("sea_dt.png", regional_plot(sea_grid), height = 11, width = 9)

This produces the plot:

![Demographic Transition in SEA - Birth and Death Rates from
1950-2015](sea_dt.png)
