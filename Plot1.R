# Define the file path of the dataset
file_path <- "household_power_consumption.txt"

# Read only the relevant lines containing dates "1/2/2007" and "2/2/2007"
# This avoids loading the entire dataset, making the process more efficient
filtered_lines <- grep("^[1|2]/2/2007", readLines(file_path), value = TRUE)

# Read the filtered data into a dataframe
data <- read.table(text = filtered_lines, sep = ";", header = FALSE, na.strings = "?",
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                                 "Voltage", "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"),
                   colClasses = c("character", "character", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", "numeric", "numeric"))

# Combine Date and Time columns into a single DateTime column of POSIXlt class
data$DateTime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Open a PNG graphics device with a size of 480x480 pixels
png("plot1.png", width = 480, height = 480)

# Generate a histogram of Global Active Power
hist(data$Global_active_power, 
     main = "Global Active Power",           # Title of the histogram
     xlab = "Global Active Power (kilowatts)", # X-axis label
     ylab = "Frequency",                      # Y-axis label
     col = "red",                             # Fill color of bars
     border = "black")                        # Border color of bars

# Close the PNG graphics device to save the plot
dev.off()

