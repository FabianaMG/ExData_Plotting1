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

## Converting variables to numeric format
fdt$Global_active_power <- as.numeric(as.character(fdt$Global_active_power))
fdt$Sub_metering_1 <- as.numeric(as.character(fdt$Sub_metering_1))
fdt$Sub_metering_2 <- as.numeric(as.character(fdt$Sub_metering_2))
fdt$Sub_metering_3 <- as.numeric(as.character(fdt$Sub_metering_3))
fdt$Voltage <- as.numeric(as.character(fdt$Voltage))
fdt$Global_reactive_power <- as.numeric(as.character(fdt$Global_reactive_power))

## Create graphs
par(mfrow = c(2,2))
plot(datetime, fdt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(datetime, fdt$Voltage, type = "l", ylab = "Voltage")
plot(datetime, fdt$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, fdt$Sub_metering_2, type = "l", col = "red")
lines(datetime, fdt$Sub_metering_3, type = "l", col = "blue")
midgrid <- quantile(datetime, probs = 0.25) ## Setting up middle of the grid for the legend so all text fits
legend(list(x=midgrid, y=40), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=3, col=c("black", "red", "blue"), bty = "n", cex = 0.9)
plot(datetime, fdt$Global_reactive_power, type = "l", ylab = "Global reactive power")

## Create file with graph
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()