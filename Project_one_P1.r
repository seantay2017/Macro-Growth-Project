setwd("C:/Users/sblat/OneDrive/Documents/Macro Theory")
data <- read.csv("AS1Data.csv")
names(data)


obs_date <- as.Date(data$observation_date)
UKGDPrate <- c(NA, diff(log(data$UKGDPPC))) * 100
#UK GDP per Capita Annual Rate
plot(obs_date, UKGDPrate, 
    type = "l", 
    main = "UK GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "red", 
    lwd = 2)

axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "1 year"), 
    format = "%Y")

#Slovenia GDP per Capita Annual Rate
SLGDPrate <- c(NA, diff(log(data$SLGDPPC))) * 100
plot(obs_date, SLGDPrate, 
    type = "l", 
    main = "Slovenia GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "blue", 
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "1 year"), 
    format = "%Y")

#Moldova GDP per Capita Annual Rate
MGDPrate <- c(NA, diff(log(data$MGDPPC))) * 100
plot(obs_date, MGDPrate, 
    type = "l", 
    main = "Moldova GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "green", 
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "1 year"), 
    format = "%Y")

#UK Segmented Time Period Analysis
plot(obs_date, UKGDPrate, 
    type = "l", 
    main = "UK GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "red", 
    lwd = 2)

axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "1 year"), 
    format = "%Y")
abline(v = as.Date(c("2006-01-01", "2016-01-01")),
       col = "blue", lwd = 2, lty = 2)
#Establishing the periods
UKPeriod1 <- data$UKGDPPC[1:18] #1990-2006
UKPeriod2 <- data$UKGDPPC[19:28] #2007-2016
UKPeriod3 <- data$UKGDPPC[29:37] #2017-2025


UKPeriod1Growth <- c(NA, diff(log(UKPeriod1))) * 100
UKPeriod2Growth <- c(NA, diff(log(UKPeriod2))) * 100
UKPeriod3Growth <- c(NA, diff(log(UKPeriod3))) * 100
UKPeriod1mean <- mean(UKPeriod1Growth, na.rm = TRUE)
UKPeriod2mean <- mean(UKPeriod2Growth, na.rm = TRUE)
UKPeriod3mean <- mean(UKPeriod3Growth, na.rm = TRUE)
UKPeriod1mean
UKPeriod2mean
UKPeriod3mean
