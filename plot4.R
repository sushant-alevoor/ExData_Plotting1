## Week 1: Course Project 1: Plot4

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

power_consumption_data4<-fread("household_power_consumption.txt", sep = ";",
                               na.strings = "?")[Date %in% c("1/2/2007","2/2/2007")]

#open the png device
png("plot4.png", width=480, height = 480)

#now split the device space into 2 rows, 2 columns
par(mfrow=c(2,2))

##Plot 1: Global active power vs datetime
#combine Date and Time and convert them into POSIXct format
string_DateTime<-paste(power_consumption_data4$Date, power_consumption_data4$Time)
power_consumption_data4$DateTime<-strptime(string_DateTime,
                                           format = "%d/%m/%Y %H:%M:%S")

#code to adjust the ticks to min, median and max of time from dataset
min_time<-min(power_consumption_data4$DateTime)
max_time<-max(power_consumption_data4$DateTime)
median_time<-median(power_consumption_data4$DateTime)
ticks<-c(min_time, median_time,max_time)

#plot the desired graph: Global active power: y-axis, time: x-axis
plot(power_consumption_data4$DateTime,power_consumption_data4$Global_active_power,
     type="l", xlab="", ylab="Global Active Power", xaxt="n",
     xlim=range(ticks))

axis(1, at = ticks, labels = c("Thu","Fri","Sat"))

##Plot 2: Voltage vs Datetime
plot(power_consumption_data4$DateTime, power_consumption_data4$Voltage,
     type="l", xlab="datetime", ylab="Voltage",xaxt="n",
     xlim = range(ticks))

##Plot 3: Energy sub metering vs Thu,Fri,Sat
plot(power_consumption_data4$DateTime,power_consumption_data4$Sub_metering_1,
     type="n", xlab="", ylab="Energy sub metering", xaxt="n",
     xlim=range(ticks))

axis(1, at = ticks, labels = c("Thu","Fri","Sat"))

#add each line individually later
lines(power_consumption_data4$DateTime,power_consumption_data3$Sub_metering_1,
      col="grey")
lines(power_consumption_data4$DateTime,power_consumption_data3$Sub_metering_2,
      col="red")
lines(power_consumption_data4$DateTime,power_consumption_data3$Sub_metering_3,
      col="blue")

##Plot 4: Global reactive power vs datetime

plot(power_consumption_data4$DateTime,power_consumption_data4$Global_reactive_power,
     type="l", xlab="datetime", ylab = "Global_reactive_power", 
     xaxt="n", xlim = range(ticks))

dev.off()