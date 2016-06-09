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

## Convert sub metering columns to numeric
fdt$Sub_metering_1 <- as.numeric(as.character(fdt$Sub_metering_1))
fdt$Sub_metering_2 <- as.numeric(as.character(fdt$Sub_metering_2))
fdt$Sub_metering_3 <- as.numeric(as.character(fdt$Sub_metering_3))

## Create graph
plot(datetime, fdt$Sub_metering_1, type = "l", ylab = "Energy Submetering", xlab = "")
lines(datetime, fdt$Sub_metering_2, type = "l", col = "red")
lines(datetime, fdt$Sub_metering_3, type = "l", col = "blue")
bestgrid <- quantile(datetime, probs = 0.70) ## Setting up a place for the legend so all text fits
legend(list(x=bestgrid, y=40), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue"), cex = 0.9)

## Create file with graph
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()