setwd("C:/Users/sblat/OneDrive/Documents/Macro Theory")
data <- read.csv("AS1Data.csv")
names(data)


obs_date <- as.Date(data$observation_date)
UKGDPrate <- c(NA, diff(log(data$UKGDPPC))) * 100
UKHCRate <- c(NA, diff(log(data$UKHC))) * 100
UKAG <- as.numeric(gsub("%", "", data$UKAG))
UKIND <- as.numeric(gsub("%", "", data$UKIND))
UKSER <- as.numeric(gsub("%", "", data$UKSER))
#UK GDP per Capita Annual Rate
plot(obs_date, UKGDPrate, 
    type = "l", 
    main = "UK GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "red", 
    lwd = 2)

axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#UK Human Capital Growth Rate
plot(obs_date, UKHCRate, 
    type = "l", 
    main = "UK Human Capital Index Growth Rate", 
    xlab = "Time", 
    ylab = "Annual Human Capital Growth Rate (%)", 
    col = "orange", 
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#UK Industrialization
matplot(obs_date, cbind(UKAG, UKIND, UKSER),
    type = "l",
    lty = 1,
    main = "UK Agriculture, Industry, and Services",
    xlab = "Time", 
    ylab = "Share of GDP (%)",
    col = c("green", "blue", "orange"),
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date),
    by = "5 years"),
    format = "%Y")
legend("right",
    legend = c("Agriculture", "Industry", "Services"),
    col = c("green", "blue", "orange"),
    lty = 1,
    lwd = 2)

#Slovenia GDP per Capita Annual Rate
SLGDPrate <- c(NA, diff(log(data$SLGDPPC))) * 100
SLHCRate <- c(NA, diff(log(data$SLHC))) * 100
SLAG <- as.numeric(gsub("%", "", data$SLAG))
SLIND <- as.numeric(gsub("%", "", data$SLIND))
SLSER <- as.numeric(gsub("%", "", data$SLSER))

plot(obs_date, SLGDPrate, 
    type = "l", 
    main = "Slovenia GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "blue", 
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#Slovenia Human Capital
plot(obs_date, SLHCRate, 
     type = "l", 
     main = "Slovenia Human Capital Index Growth Rate", 
     xlab = "Time", 
     ylab = "Annual Human Capital Growth Rate (%)", 
     col = "orange", 
     lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#Slovenia Industrialization
matplot(obs_date, cbind(SLAG, SLIND, SLSER),
        type = "l",
        lty = 1,
        main = "Slovenia Agriculture, Industry, and Services",
        xlab = "Time", 
        ylab = "Share of GDP (%)",
        col = c("green", "blue", "orange"),
        lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date),
                      by = "5 years"),
          format = "%Y")
legend("topleft",
       legend = c("Agriculture", "Industry", "Services"),
       col = c("green", "blue", "orange"),
       lty = 1,
       lwd = 2)

#Moldova GDP per Capita Annual Rate
MGDPrate <- c(NA, diff(log(data$MGDPPC))) * 100
MHCRate <- c(NA, diff(log(data$MHC))) * 100
MAG <- as.numeric(gsub("%", "", data$MAG))
MIND <- as.numeric(gsub("%", "", data$MIND))
MSER <- as.numeric(gsub("%", "", data$MSER))
plot(obs_date, MGDPrate, 
    type = "l", 
    main = "Moldova GDP per Capita Growth Rate", 
    xlab = "Time", 
    ylab = "Annual GDP per Capita Growth Rate (%)", 
    col = "green", 
    lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#Moldova Human Capital
plot(obs_date, MHCRate, 
     type = "l", 
     main = "Moldova Human Capital Index Growth Rate", 
     xlab = "Time", 
     ylab = "Annual Human Capital Growth Rate (%)", 
     col = "orange", 
     lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date), 
    by = "5 years"), 
    format = "%Y")

#Moldova Industrialization
matplot(obs_date, cbind(MAG, MIND, MSER),
        type = "l",
        lty = 1,
        main = "Moldova Agriculture, Industry, and Services",
        xlab = "Time", 
        ylab = "Share of GDP (%)",
        col = c("green", "blue", "orange"),
        lwd = 2)
axis.Date(1, at = seq(min(obs_date), max(obs_date),
         by = "5 years"),
        format = "%Y")
legend("topleft",
       legend = c("Agriculture", "Industry", "Services"),
       col = c("green", "blue", "orange"),
       lty = 1,
       lwd = 2)

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
