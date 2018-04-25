library(dplyr)

df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 header = T, 
                 na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

df <- rbind(filter(df, Date == "1/2/2007"), filter(df, Date == "2/2/2007"))
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df <- select(df, -c(Date, Time))

png(filename = "plot3.png")

par(mfrow = c(1, 1))

plot(df$DateTime, df$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(df$DateTime, df$Sub_metering_1, type = "l")
points(df$DateTime, df$Sub_metering_2, type = "l", col = "red")
points(df$DateTime, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c(par("col"), "red", "blue"), lty=c(1, 1, 1))

dev.off()