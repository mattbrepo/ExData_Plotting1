library(sqldf)

WITH_DOWNLOAD = TRUE
if (WITH_DOWNLOAD) {
  zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zip_file <- "exdata_data_household_power_consumption.zip"
  download.file(zip_url, zip_file)
  unzip(zip_file)
}

fileName <- "household_power_consumption.txt"

# Read data  over a 2-day period in February, 2007 (from 1/2/2007 to 2/2/2007)
data <- read.csv.sql(fileName, "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", sep=";")

# note: missing values are coded as ? but they are not present within this date range

# create column DateTime
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

# The plot must be a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Switch to English otherwise weekday name are in my language
Sys.setlocale("LC_ALL","English")

# Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(1, 0, 2, 1))
with(data, {
  plot(DateTime, Global_active_power, type = "l", xlab = "", 
       ylab = "Glocal Active Power")
  
  plot(DateTime, Voltage, type = "l", xlab = "datetime", 
       ylab = "Voltage")
  
  plot(DateTime, Sub_metering_1, type = "l", xlab = "", 
       ylab = "Energy sub metering")
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  legend("topright", lwd = 1, bty = "n", lty = c(1, 1, 1), seg.len = 2, 
         col = c("black", "blue", "red"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
})

dev.off()