library(dplyr)

df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 header = T, 
                 na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

df <- rbind(filter(df, Date == "1/2/2007"), filter(df, Date == "2/2/2007"))
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df <- select(df, -c(Date, Time))

png(filename = "plot4.png")

par(mfrow = c(2, 2))

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

plot(df$DateTime, df$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(df$DateTime, df$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
points(df$DateTime, df$Sub_metering_1, type = "l")
points(df$DateTime, df$Sub_metering_2, type = "l", col = "red")
points(df$DateTime, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c(par("col"), "red", "blue"), lty=c(1, 1, 1), box.lty = 0, inset = 0.01, cex = 0.9)

plot(df$DateTime, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_rective_power")

dev.off()