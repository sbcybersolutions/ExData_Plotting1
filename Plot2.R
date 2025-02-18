# Reading power consumption data from the text file
# The dataset is separated by semicolons and the first row is skipped as it contains headers.
power <- read.table("household_power_consumption.txt", skip=1, sep=";", stringsAsFactors=FALSE)

# Assigning column names to match the dataset documentation
colnames(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                     "Voltage", "Global_intensity", "Sub_metering_1", 
                     "Sub_metering_2", "Sub_metering_3")

# Subsetting data for the specific dates: 1st and 2nd February 2007
subpower <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert 'Date' column from character to Date format
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")

# Convert 'Time' column from character to POSIXlt datetime format
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")

# Adjust the 'Time' column to include the full date information for plotting purposes
subpower[1:1440, "Time"] <- format(subpower[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subpower[1441:2880, "Time"] <- format(subpower[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Convert 'Time' column back to POSIXlt after formatting
subpower$Time <- as.POSIXlt(subpower$Time)

# Convert 'Global_active_power' from character to numeric for proper plotting
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))

# Save the plot as a PNG file with a specified size of 480x480
png("plot2.png", width=480, height=480)

# Plot Global Active Power against Time
plot(subpower$Time, subpower$Global_active_power, type="l",
     xlab="", ylab="Global Active Power (kilowatts)", 
     main="Global Active Power vs. Time")

# Close the device
dev.off()