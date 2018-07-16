setwd("C:/Users/Colin/Documents/R/Quant/Coursera/Exploratory Data Analysis")

#read in zip file, unzip, and create data frame housedata
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "housepower.zip", method = "curl")
unzip("housepower.zip", exdir = getwd())
housedata <- read.delim("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

#subset housing data to just Feb 1 thru Feb 2
housedata[,1] <- as.Date(housedata[,1], format = "%d/%m/%Y")
houseclean <- subset(housedata, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
rm(housedata)

#convert date and time columns to a single datetime column
datetime <- as.POSIXct(paste(houseclean$Date, houseclean$Time), format = "%Y-%m-%d %H:%M:%S")
housenew <- cbind(houseclean, datetime)

#generate plot 4
par(mfrow = c(2,2))

plot(Global_active_power ~ datetime, housenew, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "") #first quadrant

plot(Voltage ~ datetime, housenew, type = "l", ylab = "Voltage", xlab = "") #second quadrant

plot(Sub_metering_1 ~ datetime, housenew, type = "l", xlab = "", ylab = "Energy sub metering")
lines(housenew$datetime, housenew$Sub_metering_2, col = "red")
lines(housenew$datetime, housenew$Sub_metering_3, col = "blue") #third quadrant
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

plot(Global_reactive_power~datetime, housenew, type = "l") #fourth quadrant

#copy to png file
dev.copy(png, file = "plot4.png")
dev.off()