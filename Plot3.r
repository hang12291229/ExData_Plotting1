# Read the file
power<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")
str (power)

#Format the file
#Change the column name
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2","Sub_metering_3")
str(power)
#Change to date format 
power$Datev2 <- strptime(power$Date, "%d/%m/%Y")
str(power)

#Set the start and end date, then subset the data
starttime <- which (power$Datev2 == strptime("2007-02-01", "%Y-%m-%d") )
endtime <- which (power$Datev2 == strptime ("2007-02-02", "%Y-%m-%d") )
dataset <- power[starttime, ]
dataset2 <- power[endtime, ]
dataset <- rbind (dataset, dataset2)

#Build Plot3
#Convert and combine the date and time variable 
dataset$Datetime <- as.POSIXct(paste(dataset$Date, dataset$Time))
##Use the graphic device to extract the data
png(filename = 'plot3.png', width = 480, height = 480, units='px')
plot(dataset$DateTime, as.numeric(as.character(dataset$Sub_metering_1)),  type = 'l', xlab = " ", ylab="Energy sub metering")
#Add the lines
lines(dataset$DateTime, as.numeric(as.character(dataset$Sub_metering_2)),type='l', col='red')
lines(dataset$DateTime, as.numeric(as.character(dataset$Sub_metering_3)), type='l',col='blue')
#Add the legend
legend('topright',legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),  col = c('black', 'red', 'blue'),  lwd = 1)
dev.off()
