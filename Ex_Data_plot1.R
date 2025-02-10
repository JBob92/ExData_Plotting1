
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