## Setting up file path for download
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downloading file
download.file(fileurl, destfile = "1stAss.zip", method = "curl")

## Unzipping file
unzip(zipfile = "1stAss.zip")

## Read unzipped file
dt <- read.table("household_power_consumption.txt", sep = ";", dec = ".", header = TRUE, stringsAsFactors = FALSE)

## Convert date column to date format
library(lubridate)
dt$Date <- dmy(dt$Date)

## Subset data for dates equal to "2007-02-01" and "2007-02-02" and call it fdt
fdt <- dt[ which( dt$Date == "2007-02-01" | dt$Date == "2007-02-02") , ]

## Convert Global_Active_Power column to numeric
fdt$Global_active_power <- as.numeric(as.character(fdt$Global_active_power))

## Create histogram for Global_Active_Power
hist(fdt$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Create file with histogram
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
