library(dplyr)

df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 header = T, 
                 na.strings = "?", 
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

df <- rbind(filter(df, Date == "1/2/2007"), filter(df, Date == "2/2/2007"))
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df <- select(df, -c(Date, Time))

png(filename = "plot2.png")

par(mfrow = c(1, 1))

plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()