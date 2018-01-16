library(stringr)
library(geofacet)

# Helper function to plot
grid_name <- function(grid_var) {
  return(str_to_title(str_split(grid_var, "_")[[1]][1]))
}

# Europe grid
europe_grid <- data.frame(
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 9, 9),
  col = c(1, 4, 5, 6, 7, 1, 2, 5, 7, 8, 4, 5, 6, 7, 8, 2, 3, 4, 5, 6, 7, 8, 1, 2, 4, 5, 6, 7, 8, 4, 6, 7, 8, 7, 8, 6, 7, 8),
  code = c("ISL", "NOR", "SWE", "FIN", "EST", "IRL", "GBR", "DEN", "LAT", "RUS", "NLD", "DEU", "POL", "LTU", "BLR", "FRA", "BEL", "LUX", "AUT", "CZE", "SVK", "UKR", "PRT", "ESP", "CHE", "SVN", "HUN", "ROU", "MDA", "ITA", "HRV", "SRB", "BGR", "MNE", "MKD", "BIH", "ALB", "GRC"),
  name = c("Iceland", "Norway", "Sweden", "Finland", "Estonia", "Ireland", "United Kingdom", "Denmark", "Latvia", "Russian Federation", "Netherlands", "Germany", "Poland", "Lithuania", "Belarus", "France", "Belgium", "Luxembourg", "Austria", "Czechia", "Slovakia", "Ukraine", "Portugal", "Spain", "Switzerland", "Slovenia", "Hungary", "Romania", "Republic of Moldova", "Italy", "Croatia", "Serbia", "Bulgaria", "Montenegro", "TFYR Macedonia", "Bosnia and Herzegovina", "Albania", "Greece"),
  stringsAsFactors = FALSE
)

# grid_preview(europe_grid)
# grid_design(europe_grid)

# Asia grid
asia_grid <- data.frame(
  row = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 7, 8, 8),
  col = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 11, 9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 2, 3, 4, 5, 7, 9, 10, 11, 4, 3, 12, 10, 9, 7, 9, 11, 10, 11, 12),
  code = c("TUR", "GEO", "ARM", "AZB", "TKM", "AFG", "UZB", "KGZ", "KAZ", "MNG", "PRK", "JPN", "KOR", "CHN", "NPL", "TJK", "PAK", "IRN", "IRQ", "SYR", "LBN", "CYP", "PSE", "JOR", "KWT", "BHR", "IND", "BGD", "BTN", "MAC", "HKG", "TWN", "ISR", "SAU", "QAT", "ARE", "LKA", "MMR", "LAO", "VNM", "OMN", "YEM", "PHL", "KHM", "THA", "MDV", "MYS", "BRN", "SGP", "IDN", "TLS"),
  name = c("Turkey", "Georgia", "Armenia", "Azerbaijan", "Turkmenistan", "Afghanistan", "Uzbekistan", "Kyrgyzstan", "Kazakhstan", "Mongolia", "Dem. People's Republic of Korea", "Japan", "Republic of Korea", "China", "Nepal", "Tajikistan", "Pakistan", "Iran (Islamic Republic of)", "Iraq", "Syrian Arab Republic", "Lebanon", "Cyprus", "State of Palestine", "Jordan", "Kuwait", "Bahrain", "India", "Bangladesh", "Bhutan", "Macao SAR", "Hong Kong SAR", "Taiwan Province of China", "Israel", "Saudi Arabia", "Qatar", "United Arab Emirates", "Sri Lanka", "Myanmar", "Lao People's Democratic Republic", "Viet Nam", "Oman", "Yemen", "Philippines", "Cambodia", "Thailand", "Maldives", "Malaysia", "Brunei Darussalam", "Singapore", "Indonesia", "Timor-Leste"),
  stringsAsFactors = FALSE
)

# grid_preview(asia_grid)
# grid_design(asia_grid)

# Caribbean Grid

caribbean_grid <- data.frame(
  row = c(1, 2, 3, 3, 3, 3, 4, 4, 5, 6, 7, 8, 8, 8, 8, 9, 10),
  col = c(1, 1, 1, 3, 4, 5, 6, 7, 7, 8, 8, 3, 4, 7, 9, 6, 7),
  code = c("BHS", "CUB", "JAM", "HTI", "DOM", "PRI", "VIR", "ATG", "GLP", "MTQ", "LCA", "ABW", "CUW", "VCT", "BRB", "GRD", "TTO"),
  name = c("Bahamas", "Cuba", "Jamaica", "Haiti", "Dominican Republic", "Puerto Rico", "United States Virgin Islands", "Antigua and Barbuda", "Guadeloupe", "Martinique", "Saint Lucia", "Aruba", "Curacao", "Saint Vincent and the Grenadines", "Barbados", "Grenada", "Trinidad and Tobago"),
  stringsAsFactors = FALSE
)

# grid_preview(caribbean_grid)

# North and Central America
na_central_grid <- data.frame(
  row = c(1, 2, 3, 4, 4, 5, 5, 6, 7, 7),
  col = c(1, 1, 1, 2, 3, 2, 3, 3, 3, 4),
  code = c("CAN", "USA", "MEX", "GTM", "BLZ", "SLV", "HND", "NIC", "CRI", "PAN"),
  name = c("Canada", "United States of America", "Mexico", "Guatemala", "Belize", "El Salvador", "Honduras", "Nicaragua", "Costa Rica", "Panama"),
  stringsAsFactors = FALSE
)

# Oceania

oceania_grid <- data.frame(
  row = c(1, 2, 3, 3, 4, 4, 5, 5, 5, 6, 6, 6, 8),
  col = c(1, 3, 1, 9, 3, 7, 3, 5, 9, 1, 3, 6, 3),
  code = c("GUM", "FSM", "PNG", "KIR", "SLB", "WSM", "VUT", "FJI", "PYF", "AUS", "NCL", "TON", "NZL"),
  name = c("Guam", "Micronesia (Fed. States of)", "Papua New Guinea", "Kiribati", "Solomon Islands", "Samoa", "Vanuatu", "Fiji", "French Polynesia", "Australia", "New Caledonia", "Tonga", "New Zealand"),
  stringsAsFactors = FALSE
)

# grid_preview(oceania_grid)

# South America

south_america_grid <- data.frame(
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4),
  col = c(1, 2, 3, 4, 5, 2, 3, 4, 5, 3, 4, 5, 4),
  code = c("COL", "VEN", "GUY", "SUR", "GUF", "ECU", "PER", "BOL", "BRA", "CHL", "PRY", "URY", "ARG"),
  name = c("Colombia", "Venezuela (Bolivarian Republic of)", "Guyana", "Suriname", "French Guiana", "Ecuador", "Peru", "Bolivia (Plurinational State of)", "Brazil", "Chile", "Paraguay", "Uruguay", "Argentina"),
  stringsAsFactors = FALSE
)

# grid_design(south_america_grid)

# SEA grid
sea_grid <- data.frame(
  name = c("Lao People's Democratic Republic", "Myanmar", "Viet Nam", "Thailand", "Cambodia", "Philippines", "Brunei Darussalam", "Malaysia", "Singapore", "Timor-Leste", "Indonesia"),
  code = c("LAO", "MMR", "VNM", "THA", "KHM", "PHL", "BRN", "MYS", "SGP", "TLS", "IDN"),
  row = c(1, 1, 1, 2, 2, 2, 3, 3, 4, 5, 5),
  col = c(2, 1, 3, 1, 2, 4, 3, 1, 2, 4, 3),
  stringsAsFactors = FALSE
)

# AFRICA grid
africa_grid <- data.frame(
  row = c(1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 9, 9, 10, 10, 11),
  col = c(5, 4, 5, 6, 7, 8, 9, 1, 4, 5, 7, 8, 9, 10, 11, 3, 6, 11, 3, 4, 5, 7, 8, 9, 10, 6, 3, 4, 5, 7, 8, 9, 10, 13, 14, 3, 7, 8, 9, 10, 13, 7, 5, 8, 9, 10, 14, 8, 9, 10, 12, 13, 8, 9, 8, 9, 8),
  name = c("Morocco", "Western Sahara", "Mauritania", "Algeria", "Tunisia", "Libya", "Egypt", "Cabo Verde", "Senegal", "Mali", "Niger", "Chad", "Sudan", "Eritrea", "Djibouti", "Gambia", "Burkina Faso", "Somalia", "Guinea-Bissau", "Guinea", "Ghana", "Nigeria", "Central African Republic", "South Sudan", "Ethiopia", "Benin", "Sierra Leone", "Côte d'Ivoire", "Togo", "Cameroon", "Congo", "Uganda", "Kenya", "Comoros", "Seychelles", "Liberia", "Equatorial Guinea", "Democratic Republic of the Congo", "Rwanda", "United Republic of Tanzania", "Mayotte", "Gabon", "Sao Tome and Principe", "Angola", "Burundi", "Malawi", "Mauritius", "Namibia", "Zambia", "Mozambique", "Madagascar", "Réunion", "Botswana", "Zimbabwe", "Lesotho", "Swaziland", "South Africa"),
  code = c("MAR", "ESH", "MRT", "DZA", "TUN", "LBY", "EGY", "CPV", "SEN", "MLI", "NER", "TCD", "SDN", "ERI", "DJI", "GMB", "BFA", "SOM", "GNB", "GIN", "GHA", "NGA", "CAF", "SSD", "ETH", "BEN", "SLE", "CIV", "TGO", "CMR", "COG", "UGA", "KEN", "COM", "SYC", "LBR", "GNQ", "COD", "RWA", "TZA", "MYT", "GAB", "STP", "AGO", "BDI", "MWI", "MUS", "NAM", "ZMB", "MOZ", "MDG", "REU", "BWA", "ZWE", "LSO", "SWZ", "ZAF"),
  stringsAsFactors = FALSE
)

# grid_design(africa2_grid)

