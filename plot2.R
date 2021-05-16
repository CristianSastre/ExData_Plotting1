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
plot(data$Global_active_power~data$dateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

# copy and save in png
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()