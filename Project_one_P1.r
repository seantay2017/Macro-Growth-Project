setwd("C:/Users/sblat/OneDrive/Documents/Macro Theory")
data <- read.csv("AS1Data.csv")
names(data)

obs_date <- as.Date(data$observation_date)
UKGDPrate <- c(NA, diff(log(data$UKGDPPC))) * 100
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

    