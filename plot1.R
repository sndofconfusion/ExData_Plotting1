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
png(file="plot1.png", width=480, height=480)


#draw histogram
hist(power$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main="Global Active Power"
)


#close png device
dev.off()
