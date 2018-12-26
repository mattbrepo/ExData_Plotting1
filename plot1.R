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

# The plot must be a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Plot 1
hist(data$Global_active_power, breaks = 12, col = 'red', 
     xlab = 'Glocal Active Power (kilowatt)',
     main = 'Glocal Active Power')

dev.off()
