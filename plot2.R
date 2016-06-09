## Setting up file path for download
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downloading file
download.file(fileurl, destfile = "1stAss.zip", method = "curl")

## Unzipping file
unzip(zipfile = "1stAss.zip")

## Read unzipped file
dt <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, dec = ".", stringsAsFactors = FALSE)

## Subset data for dates equal to "2007-02-01" and "2007-02-02" and call it fdt
fdt <- dt[dt$Date %in% c("1/2/2007","2/2/2007"), ]

## Join date and time together in a single variable and convert it to date format
datetime <- strptime(paste(fdt$Date, fdt$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

## Convert Global_Active_Power column to numeric
fdt$Global_active_power <- as.numeric(as.character(fdt$Global_active_power))

## Create graph
plot(datetime, fdt$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")

## Create file with graph
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()