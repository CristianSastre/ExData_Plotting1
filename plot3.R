# Read the data whit header, and split by ; and na == ? 
data <- read.table("household_power_consumption.txt", sep = ";", 
                   header = TRUE, na.strings = "?",
                   colClasses = c("character", "character",
                                  "numeric", "numeric",
                                  "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))


# subset the Data by Date we need
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Date as date class
data$Date <- as.Date(data$Date , "%d/%m/%Y")

# Date and Time in one column
dateTime <- paste(data$Date, data$Time)

# del old time and date column
data <- data[ ,!(names(data) %in% c("Date","Time"))]

# add datetime to data
data <- cbind(dateTime, data)

## Format dateTime Column
data$dateTime <- as.POSIXct(dateTime)

# PLOT
png("plot3.png", width = 480, height = 480) # init device

# set up plot
with(data, {
    plot(Sub_metering_1~dateTime, type="l",
        ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})

legend("topright", col = c("black", "red", "blue"), bty = "o", lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# shut down device
dev.off()
