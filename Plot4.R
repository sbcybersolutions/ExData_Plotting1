# Load necessary libraries (if required)
# library(ggplot2) # Uncomment if using ggplot for visualization instead

# Reading the household power consumption data
# `skip=1` is used to ignore the first row (header) and `sep=";"` indicates the delimiter
power <- read.table("household_power_consumption.txt", skip=1, sep=";", stringsAsFactors=FALSE)

# Assigning proper column names based on the dataset description
colnames(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", 
                     "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# Subsetting data for the required dates: 1st and 2nd February 2007
subpower <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Converting the "Date" column to Date format
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")

# Converting "Time" column to POSIXct format by combining Date and Time columns
subpower$DateTime <- as.POSIXct(paste(subpower$Date, subpower$Time), format="%Y-%m-%d %H:%M:%S")

# Converting necessary columns to numeric for proper plotting
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
subpower$Global_reactive_power <- as.numeric(as.character(subpower$Global_reactive_power))
subpower$Voltage <- as.numeric(as.character(subpower$Voltage))
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))

# Setting up a 2x2 plotting area
par(mfrow=c(2,2))

# Plot 1: Global Active Power over time
plot(subpower$DateTime, subpower$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)", col="black")

# Plot 2: Voltage over time
plot(subpower$DateTime, subpower$Voltage, type="l",
     xlab="datetime", ylab="Voltage", col="blue")

# Plot 3: Energy sub-metering over time
plot(subpower$DateTime, subpower$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(subpower$DateTime, subpower$Sub_metering_1, col="black")
lines(subpower$DateTime, subpower$Sub_metering_2, col="red")
lines(subpower$DateTime, subpower$Sub_metering_3, col="blue")

# Adding a legend to distinguish the sub-metering lines
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex=0.6, bty="n")

# Plot 4: Global Reactive Power over time
plot(subpower$DateTime, subpower$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global Reactive Power", col="green")

# Saving the plot as a PNG file
dev.copy(png, filename="plot4.png", width=480, height=480)
dev.off()
