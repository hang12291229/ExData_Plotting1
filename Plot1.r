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

#Build plot 1
#Use the graphic device to extract the data
png(filename = 'plot1.png', width = 480, height = 480, units='px')
hist(as.numeric(as.character(dataset$Global_active_power)),main="Global Active Power",xlab="Global Active Power (kilowatts)", col="red")
dev.off()
 
