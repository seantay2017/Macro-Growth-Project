#Project_one_P4
setwd("C:/Users/sblat/OneDrive/Documents/Macro Theory")

# Load the CSV files
##Converting PGR from index to rate by subratcting 100 from each value
PGRIndex <- read.csv("Productivity Growth Rates.csv")
PGR <- PGRIndex
pgrr_year_columns <- grep("^X?[0-9]{4}$", names(PGR), value = TRUE)
PGR[pgrr_year_columns] <- lapply(PGR[pgrr_year_columns], function(x) x - 100)
LFPR <- read.csv("Labor Force Participation Rate.csv")
RGDP <- read.csv("rGDP Growth Rates.csv")
WAGE <- read.csv("Annual Average Wage.csv")

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
