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
power <- filter(
  power, 
  datetime >= "2007-02-01", 
  datetime < "2007-02-03"
)


#open png device
png(file="plot3.png", width=480, height=480)


#draw plot
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



#close png device
dev.off()
