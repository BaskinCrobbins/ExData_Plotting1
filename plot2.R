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

#Generate Plot 2
plot(Global_active_power ~ datetime, housenew, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#copy to png file
dev.copy(png, file = "plot2.png")
dev.off()