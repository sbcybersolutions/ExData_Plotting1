# Load required dataset and perform preprocessing

# Read the power consumption dataset while skipping the first row (header)
power <- read.table("household_power_consumption.txt", skip=1, sep=";", stringsAsFactors=FALSE)

# Assign proper column names
colnames(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                     "Voltage", "Global_intensity", "Sub_metering_1", 
                     "Sub_metering_2", "Sub_metering_3")

# Filter data for the required dates: 1st and 2nd February 2007
subpower <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert Date column from character to Date format
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")

# Convert Time column from character to POSIXlt datetime format
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")

# Adjust Time format by merging it with the corresponding Date
subpower[1:1440, "Time"] <- format(subpower[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subpower[1441:2880, "Time"] <- format(subpower[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Convert Time column back to POSIXlt for proper plotting
subpower$Time <- as.POSIXlt(subpower$Time)

# Open PNG device with specified width and height (480x480 pixels)
png(filename = "plot3.png", width = 480, height = 480)

# Plot empty graph to set up axes and labels
plot(subpower$Time, as.numeric(as.character(subpower$Sub_metering_1)), type="n", 
     xlab="", ylab="Energy sub metering")

# Add lines for each sub-metering category
lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_1)), col="black")
lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_2)), col="red")
lines(subpower$Time, as.numeric(as.character(subpower$Sub_metering_3)), col="blue")

# Add a legend to indicate the sub-metering data
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Add a title to the plot
title(main="Energy Sub-Metering")

# Close the PNG device
dev.off()
