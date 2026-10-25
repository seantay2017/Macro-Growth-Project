#Project_one_P4
setwd("C:/Users/sblat/OneDrive/Documents/Macro Theory")
library(ggplot2)

# Load the CSV files
##Converting PGR from index to rate by subratcting 100 from each value
PGRIndex <- read.csv("Productivity Growth Rates.csv")
PGR <- PGRIndex
pgrr_year_columns <- grep("^X?[0-9]{4}$", names(PGR), value = TRUE)
PGR[pgrr_year_columns] <- lapply(PGR[pgrr_year_columns], function(x) x - 100)
LFPR <- read.csv("Labor Force Participation Rate.csv")
RGDP <- read.csv("rGDP Growth Rates.csv")
WAGE <- read.csv("Annual Average Wage.csv")
POP <- read.csv("Population.csv")
Patents <- read.csv("Patent Data.csv")

# Convert year columns to country-year-value records
numeric_year_data <- function(data, value_name) {
  if (!is.data.frame(data) || ncol(data) == 0) {
    stop("Expected a non-empty data frame for ", value_name, " data.")
  }
  year_columns <- grep("^X?[0-9]{4}$", names(data), value = TRUE)
  if (length(year_columns) == 0) {
    stop("No year columns were found in ", value_name,
         " data. Check the column names with names(", value_name, ").")
  }
  values <- data[, year_columns, drop = FALSE]
  values[] <- lapply(values, function(x) {
    x <- gsub(",", "", as.character(x))
    x <- sub("^[A-Za-z]+[[:space:]]+", "", x)
    suppressWarnings(as.numeric(x))
  })
  result <- data.frame(
    country = rep(trimws(as.character(data[[1]])), times = length(year_columns)),
    year = rep(sub("^X", "", year_columns), each = nrow(data)),
    value = unlist(values, use.names = FALSE)
  )
  names(result)[3] <- value_name
  result
}

# Correlation analysis for all four measures
RGDP_years <- numeric_year_data(RGDP, "RGDP")
WAGE_years <- numeric_year_data(WAGE, "WAGE")
PGR_years <- numeric_year_data(PGR, "PGR")
LFPR_years <- numeric_year_data(LFPR, "LFPR")
POP_years <- numeric_year_data(POP, "POP")
Patents_years <- numeric_year_data(Patents, "Patents")
                                 
# Merge the data frames by country and year
paired_data <- Reduce(
  function(x, y) merge(x, y, by = c("country", "year")),
  list(RGDP_years, WAGE_years, PGR_years, LFPR_years)
)
measure_names <- c("RGDP", "WAGE", "PGR", "LFPR")
complete_pairs <- complete.cases(paired_data[measure_names])
cat("Complete country-year pairs:", sum(complete_pairs), "\n")
if (sum(complete_pairs) < 2) {
  stop("At least two complete numeric country-year pairs are required.")
}
#Correlation Matrix
all_measure_correlation <- cor(paired_data[complete_pairs, measure_names])
print(all_measure_correlation)

pairs(
  paired_data[complete_pairs, measure_names],
  pch = 16,
  col = grDevices::adjustcolor("purple", alpha.f = 0.35)
)
                                
# Scatter plot of RGDP vs LFPR
plot(
  paired_data[complete_pairs, "RGDP"],
  paired_data[complete_pairs, "LFPR"],
  xlab = "Real GDP Growth Rate (RGDP)",
  ylab = "Labor Force Participation Rate (LFPR)",
  main = "Scatter Plot of RGDP vs LFPR"
)

# Scatter plot of wage vs Patents_per_capita
plot(
  paired_data[complete_pairs, "WAGE"],
  paired_data[complete_pairs, "Patents_per_capita"],
  xlab = "Annual Average Wage",
  ylab = "Patents per Capita",
  main = "Scatter Plot of WAGE vs Patents_per_capita",
  col = grDevices::adjustcolor("blue", alpha.f = 0.35)
  )
abline(lm(Patents_per_capita ~ WAGE, data = paired_data[complete_pairs, ]),
       col = "red", lwd = 2)

#Scatter plot of LFPR vs Patents_per_capita
plot(
  paired_data[complete_pairs, "LFPR"],
  paired_data[complete_pairs, "Patents_per_capita"],
  xlab = "Labor Force Participation Rate",
  ylab = "Patents per Capita",
  main = "Scatter Plot of LFPR vs Patents per Capita",
  col = grDevices::adjustcolor("#6f0808", alpha.f = 0.35)
)
abline(lm(Patents_per_capita ~ LFPR, data = paired_data[complete_pairs, ]),
       col = "blue", lwd = 2)                                 
                                 
# Scatter plot of RGDP vs WAGE
plot(
  paired_data[complete_pairs, "WAGE"],
  paired_data[complete_pairs, "RGDP"],
  ylab = "Real GDP Growth Rate (RGDP)",
  xlab = "Annual Average Wage (WAGE)",
  main = "Scatter Plot of RGDP vs WAGE"
)

# Scatter plot of RGDP vs PGR
plot(
  paired_data[complete_pairs, "RGDP"],
  paired_data[complete_pairs, "PGR"],
  xlab = "Real GDP Growth Rate (RGDP)",
  ylab = "Productivity Growth Rate (PGR)",
  main = "Scatter Plot of RGDP vs PGR"
)
abline(h = 0, col = "red", lwd = 2)
abline(lm(PGR ~ RGDP, data = paired_data[complete_pairs, ]),
       col = "blue", lwd = 2)

# Scatter plot of real GDP growth and annual average wage for France
##Shows general relationship between measures for developed country
france_data <- merge(
  subset(RGDP_years, country == "France"),
  subset(WAGE_years, country == "France"),
  by = c("country", "year")
)
france_data <- france_data[complete.cases(france_data[, c("RGDP", "WAGE")]), ]
if (nrow(france_data) == 0) {
  stop("No complete RGDP and WAGE observations were found for France.")
}

france_plot <- ggplot(france_data, aes(x = WAGE, y = RGDP)) +
  geom_point() +
  labs(
    title = "Real GDP Growth vs Annual Average Wage for France",
    x = "Annual Average Wage",
    y = "Real GDP Growth Rate"
  )
if (length(unique(france_data$RGDP)) > 1) {
  france_plot <- france_plot + geom_smooth(method = "lm", se = FALSE)
}
print(france_plot)

#Line plot of real GDP growth and annual average wage for France over time
##Shows overtime trends between measures
france_data$year <- as.numeric(france_data$year)

rgdp_min <- min(france_data$RGDP, na.rm = TRUE)
rgdp_range <- diff(range(france_data$RGDP, na.rm = TRUE))
wage_min <- min(france_data$WAGE, na.rm = TRUE)
wage_range <- diff(range(france_data$WAGE, na.rm = TRUE))

wage_scale <- rgdp_range / wage_range
wage_offset <- rgdp_min - wage_min * wage_scale
ggplot(france_data, aes(x = year)) +
  geom_line(aes(y = RGDP, color = "RGDP"), linewidth = 1) +
  geom_line(
    aes(y = WAGE * wage_scale + wage_offset, color = "WAGE"),
    linewidth = 1
  ) +
  scale_y_continuous(
    name = "Real GDP growth rate (RGDP)",
    sec.axis = sec_axis(
      ~ (. - wage_offset) / wage_scale,
      name = "Annual average wage (WAGE)"
    )
  ) +
  labs(
    title = "RGDP and WAGE over Time for France",
    x = "Year",
    color = "Measure"
  )

#Scatter plot of real GDP growth and annual average wage for Colombia (middle income)
colombia_data <- merge(
  subset(RGDP_years, country == "Colombia"),
  subset(WAGE_years, country == "Colombia"),
  by = c("country", "year")
)
colombia_data <- colombia_data[complete.cases(colombia_data[, c("RGDP", "WAGE")]), ]
if (nrow(colombia_data) == 0) {
  stop("No complete RGDP and WAGE observations were found for Colombia.")
}
colombia_plot <- ggplot(colombia_data, aes(x = WAGE, y = RGDP)) +
  geom_point() +
  labs(
    title = "Real GDP Growth vs Annual Avg Wage for Colombia",
    x = "Annual Average Wage",
    y = "Real GDP Growth Rate"
  )
if (length(unique(colombia_data$RGDP)) > 1) {
  colombia_plot <- colombia_plot + geom_smooth(method = "lm", se = TRUE)
}
colombia_plot

#Line plot of real GDP growth and annual average wage for Colombia over time
colombia_data$year <- as.numeric(colombia_data$year)

rgdp_min <- min(colombia_data$RGDP, na.rm = TRUE)
rgdp_range <- diff(range(colombia_data$RGDP, na.rm = TRUE))
wage_min <- min(colombia_data$WAGE, na.rm = TRUE)
wage_range <- diff(range(colombia_data$WAGE, na.rm = TRUE))

wage_scale <- rgdp_range / wage_range
wage_offset <- rgdp_min - wage_min * wage_scale
ggplot(colombia_data, aes(x = year)) +
  geom_line(aes(y = RGDP, color = "RGDP"), linewidth = 1) +
  geom_line(
    aes(y = WAGE * wage_scale + wage_offset, color = "WAGE"),
    linewidth = 1
  ) +
  scale_y_continuous(
    name = "Real GDP Growth Rate",
    sec.axis = sec_axis(
      ~ (. - wage_offset) / wage_scale,
      name = "Annual Average Wage")
  ) +
  labs(
    title = "RGDP and WAGE over Time for Colombia",
    x = "Year",
    color = "Measure"
  )
