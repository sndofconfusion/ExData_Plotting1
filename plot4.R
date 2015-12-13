#load libraries
library(data.table)
library(dplyr)


#load file
power <- fread("./household_power_consumption.txt", na.strings = "?")


#add datetime column
power <- mutate(
  power, 
  datetime = as.POSIXct(
    paste(power$Date,power$Time), 
    format="%d/%m/%Y %H:%M:%S"
  )
)


#filter for data between "2007-02-01" and "2007-02-03"
power <- filter(power, 
                datetime >= "2007-02-01", 
                datetime < "2007-02-03"
)


#open png device
png(file="plot4.png", width=480, height=480)


par(mfrow=c(2,2), mar=c(4,4,1,1))


#draw plot 1
plot(
  power$datetime, 
  power$Global_active_power, 
  xlab="", 
  ylab="Global Active Power", 
  type="l"
)


#draw plot 2
plot(
  power$datetime, 
  power$Voltage, 
  xlab="datetime", 
  ylab="Voltage", 
  type="l"
)


#draw plot 3
plot(
  power$datetime, 
  power$Sub_metering_1, 
  type="n", 
  xlab="", 
  ylab="Energy sub metering"
)
points(power$datetime, power$Sub_metering_1, col="black", type="l")
points(power$datetime, power$Sub_metering_2, col="red", type="l")
points(power$datetime, power$Sub_metering_3, col="blue", type="l")
legend(
  "topright", 
  lty=1, 
  col=c("black","red","blue"), 
  legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)


#draw plot 4
plot(
  power$datetime, 
  power$Global_reactive_power, 
  xlab="datetime", 
  ylab="Global_reactive_power", 
  type="l"
)


#close png device
dev.off()
