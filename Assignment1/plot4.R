library(dplyr)

# Create data directory
if(!dir.exists("data")) { dir.create("data") }
file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

# Loading data as csv 
pre_data <- read.csv("data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?")

# Select subset 2007-02-01 & 2007-02-02
pre_data$Date <- as.Date(pre_data$Date, format="%d/%m/%Y")
data <- subset(pre_data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Adding new column for plot2-4
datetime <- paste(as.Date(data$Date), data$Time)
data$datetime <- as.POSIXct(datetime)

#Plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
par(mfrow=c(2,2), oma=c(0,0,2,0))


with(data, {
  plot(Global_active_power~datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")})


#save plot as png
dev.copy(png, "plot4.png",width  = 480,height = 480)
dev.off()
rm(list = ls())