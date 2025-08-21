## Week 1: Course Project 1: Plot1

#Download the data indicated by first checking if the said file is already
#present. Unzip after download

filename <- "exdata_data_household_power_consumption.zip"
if (!file.exists(filename)) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  filename, mode = "wb")
    unzip(filename)
}

#Read only specific lines within the dataset since the file is huge
library(data.table)

power_consumption_data<-fread("household_power_consumption.txt", sep = ";",
                              na.strings = "?")[Date %in% c("1/2/2007","2/2/2007")]

#open the png device
png("plot1.png", width=480, height = 480)

#code for the desired histogram
hist(power_consumption_data$Global_active_power, main="Global Active Power",
     xlab = "Global Active Power (kilowatts)", col="red", border="black")

dev.off()

