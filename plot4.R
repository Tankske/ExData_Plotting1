# ---------------------------------------------------------------------------------
# Exploratory data analysis
# ---------------------------------------------------------------------------------
# Author: Yves Langeraert
# Date: 20160326
# Description: Notes on how to explor data from the Coursera Specialization:
# John Hopkins University - Data Science - 4 Exploratory Data Analysis
# ---------------------------------------------------------------------------------
# 0| Prepare the data
# ---------------------------------------------------------------------------------
# Upload the data
df <- read.csv('household_power_consumption.txt', sep = ";")

# Keep original data save and use other object to manipulate data
# Prevents reloading data when manipulations need to be adjusted
df1 <- df

# Convert numeric variables to numeric factor
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Convert date variable to date type
df$Date <- strptime(df$Date, format="%d/%m/%Y")
# Convert time variable to time type
# df$Time <- strptime(df$Time, format="%H:%M:%S")

# Create subset of the data
 dataSet <- subset(df, Date == "2007-02-01" | Date == "2007-02-02")
 # Alternative methods for this query are:
 # df[df$Date in c("2007-02-01", "2007-02-02")]
 # subset(df, Date == c("2007-02-01", "2007-02-02"))

dataSet$newdate <- with(dataSet, as.POSIXct(paste(Date, Time)))

# ---------------------------------------------------------------------------------
# 1| Create plot 4
# ---------------------------------------------------------------------------------
# Create PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot4.png", width = 480, height = 480, units = "px")
#Create canvas with 4 positions (2X2)
par(mfrow = c(2,2), mar = c(4, 4, 2, 1))

with(dataSet, {
  # Plot 1: global active power as a line in function of date-time
  plot(newdate, Global_active_power, type="n", ylab = "Global Active Power", xlab="") 
  lines(newdate, Global_active_power, type="l")
  
  # Plot 2: voltage as a line in function of date-time
  plot(newdate, Voltage, type="n", ylab = "Voltage", xlab="datetime") 
  lines(newdate, Voltage, type="l")
  
  # Plot 3: Sub_metering variables in function of time using black, red and blue color
  plot(newdate, Sub_metering_1, type="n", ylab = "Energy sub metering", xlab="") 
  lines(dataSet$newdate, dataSet$Sub_metering_1, type="l")
  lines(dataSet$newdate, dataSet$Sub_metering_2, type="l", col="red")
  lines(dataSet$newdate, dataSet$Sub_metering_3, type="l", col="blue")
  legend('topright', c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lwd=c(2.5,2.5, 2.5),col=c("black", "red", "blue"), bty='n')
  
  
  # Plot 4: global reactive power as a line in function of date-time
  plot(newdate, Global_reactive_power, type="n", ylab = "Voltage", xlab="datetime") 
  lines(dataSet$newdate, dataSet$Global_reactive_power, type="l")
})
# Save it to a PNG file 
dev.off()
