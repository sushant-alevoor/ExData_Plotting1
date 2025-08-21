## Week 1: Course Project 1: Plot3

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

power_consumption_data3<-fread("household_power_consumption.txt", sep = ";",
                               na.strings = "?")[Date %in% c("1/2/2007","2/2/2007")]

#open the png device
png("plot3.png", width=480, height = 480)

#combine Date and Time and convert them into POSIXct format
string_DateTime<-paste(power_consumption_data3$Date, power_consumption_data3$Time)
power_consumption_data3$DateTime<-strptime(string_DateTime,
                                           format = "%d/%m/%Y %H:%M:%S")

#code to adjust the ticks to min, median and max of time from dataset
min_time<-min(power_consumption_data3$DateTime)
max_time<-max(power_consumption_data3$DateTime)
median_time<-median(power_consumption_data3$DateTime)
ticks<-c(min_time, median_time,max_time)

#just create the plot first with the appropriate labels
plot(power_consumption_data3$DateTime,power_consumption_data3$Sub_metering_1,
     type="n", xlab="", ylab="Energy sub metering", xaxt="n",
     xlim=range(ticks))

axis(1, at = ticks, labels = c("Thu","Fri","Sat"))

#add each line individually later
lines(power_consumption_data3$DateTime,power_consumption_data3$Sub_metering_1,
      col="grey")
lines(power_consumption_data3$DateTime,power_consumption_data3$Sub_metering_2,
      col="red")
lines(power_consumption_data3$DateTime,power_consumption_data3$Sub_metering_3,
      col="blue")

dev.off()
