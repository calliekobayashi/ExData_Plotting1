# Create data directory
if(!dir.exists("data")) { dir.create("data") }
file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

# Loading data as csv and selecting subsets
data2 <- read.csv("data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", check.names=F, stringsAsFactors=FALSE, comment.char="", quote='\"')

data <- read.csv("data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?")

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data_set <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")


# Loading data as csv and selecting subsets (option2)
data <- read_delim("data/household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))



