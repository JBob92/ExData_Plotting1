# Specify the zip file path
zip_file <- "C:/Users/Shutlerj/OneDrive - Australia Post/Documents/Training & useful stuff/Johns Hopkins - Data Science/4. Exploratory Data Analysis/exdata_data_household_power_consumption.zip"

# Unzip the file
unzip(zip_file, exdir = "C:/Users/Shutlerj/OneDrive - Australia Post/Documents/Training & useful stuff/Johns Hopkins - Data Science/4. Exploratory Data Analysis")

setwd("C:/Users/Shutlerj/OneDrive - Australia Post/Documents/Training & useful stuff/Johns Hopkins - Data Science/4. Exploratory Data Analysis")

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


# Plot 1 - histogram

# Plot a red histogram of Global Active Power
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Plot 1, Histogram of Global Active Power", border = "black")

# Save the plot to a PNG file - plot1
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

# Plot 2 - time series

# Extract day of the week
data$DayOfWeek <- weekdays(data$DateTime)

# Plot Global Active Power against Day of Week
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "Date", ylab = "Global Active Power (kilowatts)",main = "Plot 2")


# Save the plot to a PNG file - plot2
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

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

#Plot 4 - 4 way plot
# Save the plot to a PNG file - plot 4
png("plot4.png", width = 480, height = 480)

# Build 4-way plot matrix
par(mfrow = c(2, 2))  # Set 2x2 layout

# First plot: Global Active Power
plot(data$DateTime, data$Global_active_power, type = "l", 
     xlab = "Date", ylab = "Global Active Power")

# Second plot: Voltage
plot(data$DateTime, data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# Third plot: Sub Metering
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", 
     xlab = "datetime", ylab = "Energy Sub Metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), 
       col = c("black", "red", "blue"), lty = 1, cex = 0.5, box.lwd = 0)

# Fourth plot: Global Reactive Power
plot(data$DateTime, data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global Reactive Power")

# Close the PNG device
dev.off()


# Reset to default layout
par(mfrow = c(1, 1))

