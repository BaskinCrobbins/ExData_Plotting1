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

#Plot 1: Histogram
hist(houseclean$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

#copy to png file
dev.copy(png, file = "plot1.png")
dev.off()

