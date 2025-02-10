
# Load the data.table package
library(data.table)

# Read the dataset
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

#subset the data
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Convert Date column to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
# Combine Date and Time into DateTime class (ensure DateTime is in POSIXct format)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")


str(data)
summary(data)

# Plot 3 - sub_metering time series

# Plot sub_metering_1 in black with Date on x-axis
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", xlab = "datetime", ylab = "Energy Sub Metering")

# Add sub_metering_2 in red
lines(data$DateTime, data$Sub_metering_2, col = "red")

# Add sub_metering_3 in blue
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# Add a smaller legend to identify the lines, repositioned to avoid overlap
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.5, box.lwd = 0)  

# Save the plot to a PNG file - plot3
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()