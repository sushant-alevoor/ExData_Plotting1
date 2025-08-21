## Week 1: Course Project 1: Plot2

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

power_consumption_data2<-fread("household_power_consumption.txt", sep = ";",
                              na.strings = "?")[Date %in% c("1/2/2007","2/2/2007")]

#open the png device
png("plot2.png", width=480, height = 480)

#combine Date and Time and convert them into POSIXct format
string_DateTime<-paste(power_consumption_data2$Date, power_consumption_data2$Time)
power_consumption_data2$DateTime<-strptime(string_DateTime,
                                          format = "%d/%m/%Y %H:%M:%S")

#code to adjust the ticks to min, median and max of time from dataset
min_time<-min(power_consumption_data2$DateTime)
max_time<-max(power_consumption_data2$DateTime)
median_time<-median(power_consumption_data2$DateTime)
ticks<-c(min_time, median_time,max_time)

#plot the desired graph: Global active power: y-axis, time: x-axis
plot(power_consumption_data2$DateTime,power_consumption_data2$Global_active_power,
     type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n",
     xlim=range(ticks))

axis(1, at = ticks, labels = c("Thu","Fri","Sat"))

dev.off()