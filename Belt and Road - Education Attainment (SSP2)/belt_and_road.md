This is a reproducible example to produce a tile map that shows
forecasted education attainment for ages 15 to 39 for belt and road
countries based on the SSP2 scenario.

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

We use data from Wittgenstein Center...

    belt_road <- read_csv("belt_road_countries.csv")

    belt_road <- belt_road %>%
      filter(Education != "Total" & Education != "Under 15" & Year <= 2050) %>%
      group_by(Area, Scenario, Year, Education) %>%
      summarise(Population = sum(Population))

    edu_levels <- rev(c("No Education", "Incomplete Primary", "Primary", "Lower Secondary", "Upper Secondary", "Post Secondary"))

    belt_road$Education <- factor(belt_road$Education, levels = edu_levels)

    # Colors
    red = "#ff7473"
    blue = "#47b8e0"
    yellow = "#ffc952"
    green = "#8cd790"
    purple = "#6a60a9"
    orange = "#f68657"

Plot for one country (SSP2)
---------------------------

As an example, we can plot the forecasted education attainment for ages
15-39 for Hungary. The tile plot introduced in the next section would
just be a series of such plots arranged in a specific manner(relative to
geographic alignment).

    hungary_education <- belt_road %>%
      filter(Area == "Hungary" & Scenario == "SSP2") %>%
      ggplot(aes(Year, Population, group = Education, fill = Education)) + 
      geom_area() +
      scale_fill_manual(values = c(red, blue, yellow, green, purple, orange)) +
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
        Y = "Population per 1000 people"
      )

    ggsave("hungary_education.png", hungary_education, height = 4, width = 6)

![Forecasted education attainment for ages 15-39 in Hungary (SSP2
Scenario)](hungary_education.png)

Defining the Grid
-----------------

In order to implement grids for the `geofacet` package to plot the area
plots relative to the countries' position on a world map, we define a
grid as per `geofacet`'s guidelines that takes the row and column values
as well as identifiers for the countries and aligns the plots
accordingly.

The grid for belt and road is shown as follows:

    obor_grid <- data.frame(
      row = c(1, 1, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5,
              6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8,
              9, 9, 9, 9, 9, 10, 10, 10, 11),
      col = c(4, 5, 3, 4, 12, 3, 4, 8, 9, 12, 1, 3, 4, 5, 6, 7, 8, 7, 10, 13,
              14, 1, 2, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 9, 11, 12, 14, 3,
              5, 8, 12, 3, 4, 5, 11, 14, 4, 5, 11, 3),
      name = c("Poland", "Russia", "Germany", "Hungary", "Mongolia", "Austria", "Serbia",
               "Kazakhstan", "Kyrgyzstan", "China", "Spain", "Italy", "Greece", "Turkey",
               "Georgia", "Uzbekistan", "Tajikistan", "Turkmenistan", "Nepal", "Macao", 
               "Hong Kong", "Senegal", "Mauritania", "Egypt", "Saudi Arabia", "Iran", 
               "Pakistan", "India", "Bangladesh", "Myanmar", "Laos", "Cote d'Ivoire", 
               "Ghana", "Nigeria", "Sri Lanka", "Thailand", "Viet Nam", "Philippines",
               "Cameroon", "Ethiopia", "Maldives", "Cambodia", "Gabon", "Uganda", "Kenya",
               "Malaysia", "Indonesia", "Rwanda", "Tanzania", "Singapore", "Angola"),
      code = c("POL", "RUS", "DEU", "HUN", "MNG", "AUT", "SRB", "KAZ", "KGZ", "CHN", "ESP",
               "ITA", "GRC", "TUR", "GEO", "UZB", "TJK", "TKM", "NPL", "MAC", "HKG", "SEN",
               "MRT", "EGY", "SAU", "IRN", "PAK", "IND", "BGD", "MMR", "LAO", "CIV", "GHA",
               "NGA", "LKA", "THA", "VNM", "PHL", "CMR", "ETH", "MDV", "KHM", "GAB", "UGA",
               "KEN", "MYS", "IDN", "RWA", "TZA", "SGP", "AGO"),
      stringsAsFactors = FALSE
    )

    knitr::kable(obor_grid)

<table>
<thead>
<tr class="header">
<th align="right">row</th>
<th align="right">col</th>
<th align="left">name</th>
<th align="left">code</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">1</td>
<td align="right">4</td>
<td align="left">Poland</td>
<td align="left">POL</td>
</tr>
<tr class="even">
<td align="right">1</td>
<td align="right">5</td>
<td align="left">Russia</td>
<td align="left">RUS</td>
</tr>
<tr class="odd">
<td align="right">2</td>
<td align="right">3</td>
<td align="left">Germany</td>
<td align="left">DEU</td>
</tr>
<tr class="even">
<td align="right">2</td>
<td align="right">4</td>
<td align="left">Hungary</td>
<td align="left">HUN</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="right">12</td>
<td align="left">Mongolia</td>
<td align="left">MNG</td>
</tr>
<tr class="even">
<td align="right">3</td>
<td align="right">3</td>
<td align="left">Austria</td>
<td align="left">AUT</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="right">4</td>
<td align="left">Serbia</td>
<td align="left">SRB</td>
</tr>
<tr class="even">
<td align="right">3</td>
<td align="right">8</td>
<td align="left">Kazakhstan</td>
<td align="left">KAZ</td>
</tr>
<tr class="odd">
<td align="right">3</td>
<td align="right">9</td>
<td align="left">Kyrgyzstan</td>
<td align="left">KGZ</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">12</td>
<td align="left">China</td>
<td align="left">CHN</td>
</tr>
<tr class="odd">
<td align="right">4</td>
<td align="right">1</td>
<td align="left">Spain</td>
<td align="left">ESP</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">3</td>
<td align="left">Italy</td>
<td align="left">ITA</td>
</tr>
<tr class="odd">
<td align="right">4</td>
<td align="right">4</td>
<td align="left">Greece</td>
<td align="left">GRC</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">5</td>
<td align="left">Turkey</td>
<td align="left">TUR</td>
</tr>
<tr class="odd">
<td align="right">4</td>
<td align="right">6</td>
<td align="left">Georgia</td>
<td align="left">GEO</td>
</tr>
<tr class="even">
<td align="right">4</td>
<td align="right">7</td>
<td align="left">Uzbekistan</td>
<td align="left">UZB</td>
</tr>
<tr class="odd">
<td align="right">4</td>
<td align="right">8</td>
<td align="left">Tajikistan</td>
<td align="left">TJK</td>
</tr>
<tr class="even">
<td align="right">5</td>
<td align="right">7</td>
<td align="left">Turkmenistan</td>
<td align="left">TKM</td>
</tr>
<tr class="odd">
<td align="right">5</td>
<td align="right">10</td>
<td align="left">Nepal</td>
<td align="left">NPL</td>
</tr>
<tr class="even">
<td align="right">5</td>
<td align="right">13</td>
<td align="left">Macao</td>
<td align="left">MAC</td>
</tr>
<tr class="odd">
<td align="right">5</td>
<td align="right">14</td>
<td align="left">Hong Kong</td>
<td align="left">HKG</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">1</td>
<td align="left">Senegal</td>
<td align="left">SEN</td>
</tr>
<tr class="odd">
<td align="right">6</td>
<td align="right">2</td>
<td align="left">Mauritania</td>
<td align="left">MRT</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">5</td>
<td align="left">Egypt</td>
<td align="left">EGY</td>
</tr>
<tr class="odd">
<td align="right">6</td>
<td align="right">6</td>
<td align="left">Saudi Arabia</td>
<td align="left">SAU</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">7</td>
<td align="left">Iran</td>
<td align="left">IRN</td>
</tr>
<tr class="odd">
<td align="right">6</td>
<td align="right">8</td>
<td align="left">Pakistan</td>
<td align="left">PAK</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">9</td>
<td align="left">India</td>
<td align="left">IND</td>
</tr>
<tr class="odd">
<td align="right">6</td>
<td align="right">10</td>
<td align="left">Bangladesh</td>
<td align="left">BGD</td>
</tr>
<tr class="even">
<td align="right">6</td>
<td align="right">11</td>
<td align="left">Myanmar</td>
<td align="left">MMR</td>
</tr>
<tr class="odd">
<td align="right">6</td>
<td align="right">12</td>
<td align="left">Laos</td>
<td align="left">LAO</td>
</tr>
<tr class="even">
<td align="right">7</td>
<td align="right">1</td>
<td align="left">Cote d'Ivoire</td>
<td align="left">CIV</td>
</tr>
<tr class="odd">
<td align="right">7</td>
<td align="right">2</td>
<td align="left">Ghana</td>
<td align="left">GHA</td>
</tr>
<tr class="even">
<td align="right">7</td>
<td align="right">3</td>
<td align="left">Nigeria</td>
<td align="left">NGA</td>
</tr>
<tr class="odd">
<td align="right">7</td>
<td align="right">9</td>
<td align="left">Sri Lanka</td>
<td align="left">LKA</td>
</tr>
<tr class="even">
<td align="right">7</td>
<td align="right">11</td>
<td align="left">Thailand</td>
<td align="left">THA</td>
</tr>
<tr class="odd">
<td align="right">7</td>
<td align="right">12</td>
<td align="left">Viet Nam</td>
<td align="left">VNM</td>
</tr>
<tr class="even">
<td align="right">7</td>
<td align="right">14</td>
<td align="left">Philippines</td>
<td align="left">PHL</td>
</tr>
<tr class="odd">
<td align="right">8</td>
<td align="right">3</td>
<td align="left">Cameroon</td>
<td align="left">CMR</td>
</tr>
<tr class="even">
<td align="right">8</td>
<td align="right">5</td>
<td align="left">Ethiopia</td>
<td align="left">ETH</td>
</tr>
<tr class="odd">
<td align="right">8</td>
<td align="right">8</td>
<td align="left">Maldives</td>
<td align="left">MDV</td>
</tr>
<tr class="even">
<td align="right">8</td>
<td align="right">12</td>
<td align="left">Cambodia</td>
<td align="left">KHM</td>
</tr>
<tr class="odd">
<td align="right">9</td>
<td align="right">3</td>
<td align="left">Gabon</td>
<td align="left">GAB</td>
</tr>
<tr class="even">
<td align="right">9</td>
<td align="right">4</td>
<td align="left">Uganda</td>
<td align="left">UGA</td>
</tr>
<tr class="odd">
<td align="right">9</td>
<td align="right">5</td>
<td align="left">Kenya</td>
<td align="left">KEN</td>
</tr>
<tr class="even">
<td align="right">9</td>
<td align="right">11</td>
<td align="left">Malaysia</td>
<td align="left">MYS</td>
</tr>
<tr class="odd">
<td align="right">9</td>
<td align="right">14</td>
<td align="left">Indonesia</td>
<td align="left">IDN</td>
</tr>
<tr class="even">
<td align="right">10</td>
<td align="right">4</td>
<td align="left">Rwanda</td>
<td align="left">RWA</td>
</tr>
<tr class="odd">
<td align="right">10</td>
<td align="right">5</td>
<td align="left">Tanzania</td>
<td align="left">TZA</td>
</tr>
<tr class="even">
<td align="right">10</td>
<td align="right">11</td>
<td align="left">Singapore</td>
<td align="left">SGP</td>
</tr>
<tr class="odd">
<td align="right">11</td>
<td align="right">3</td>
<td align="left">Angola</td>
<td align="left">AGO</td>
</tr>
</tbody>
</table>

Grid Preview
------------

    grid_prev <- grid_preview(obor_grid) + theme_minimal()
    ggsave("obor_grid.png", grid_prev)

![Belt and road countries shown as tiles](obor_grid.png)

Plotting Belt and Road countries
--------------------------------

    belt_road_plot <- belt_road %>%
      filter(Scenario == "SSP2") %>%
      ggplot(aes(Year, Population, fill = Education, group = Education)) + 
        geom_area() + 
        facet_geo(~Area, grid = obor_grid, scales = "free_y", label = "code") +
        theme_kani() + 
        scale_fill_manual(values = c(red, blue, yellow, green, purple, orange)) +
        scale_x_continuous(limits = c(2015,2050)) +
        theme(
          legend.position = "top",
              legend.margin = margin(b = -1, unit = "cm"),
              plot.background = element_rect(fill = "white"),
              panel.background = element_rect(fill = "white"),
              legend.background = element_rect(fill = "white"),
              legend.key = element_rect(fill = "white"),
              strip.background = element_rect(fill = "white"),
              strip.text = element_text(face = "bold"),
              legend.text = element_text(size = rel(1.1)),
              legend.title = element_text(size = rel(1.1))
        ) +
        labs(
          y = "Total population by educational attainment, 000s",
          x = ""
        )

    ggsave("belt_road_education.png", belt_road_plot, height = 15, width = 26)

<!-- ![Education in the Belt and Road countries (2015 - 2050)](belt_road_education.png) -->
![Education in the Belt and Road countries (2015 -
2050)](belt_road_education.png) Figure 3: Education in the Belt and Road
countries (2015 - 2050)
