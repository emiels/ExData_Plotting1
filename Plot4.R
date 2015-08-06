# ______________________________
# generic load dataset into R
epc <- read.csv("household_power_consumption.txt", header = TRUE, sep=";", 
                na.strings = "?", stringsAsFactors = FALSE)
# convert date 
epc$Date <- as.Date(epc$Date,"%d/%m/%Y")
# filter for 2007-02-01 and 2007-02-02
epc <-subset(epc , Date >="2007-02-01" & Date <= "2007-02-02")
# convert date and time to posix 
epc$mydatetime <- as.POSIXct(paste(as.Date(epc$Date),epc$Time))
# set locale to US name of days (my windows' pc works in different enviroment)
Sys.setlocale("LC_TIME", "C")
#_________________________________
# specific code to generate plot 4
# open device png in file plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# set 2 by 2 frames
par(mfrow = c(2,2))

# first plot global active (= plot 2) left top
with(epc, plot(mydatetime, Global_active_power,
               xlab = "", ylab = "Global Active Power", type = "n"))
with(epc, lines(mydatetime, Global_active_power))

# second: plot Voltage right top
with(epc, plot(mydatetime, Voltage,
               xlab = "datetime", ylab = "Voltage", type = "n"))
with(epc, lines(mydatetime, Voltage))

#third plot sub_metering1/2/3 (plot 3)
with(epc, plot(mydatetime, Sub_metering_1, 
        xlab = "", ylab = "Energy sub metering", type = "n"))
legend("topright", bty = "n", lty = 1, cex = 0.9,
        col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
with(epc, lines(mydatetime, Sub_metering_1, col = "black" ))
with(epc, lines(mydatetime, Sub_metering_2, col = "red"))
with(epc, lines(mydatetime, Sub_metering_3, col = "blue"))

# fourth plot Global Reactive power
with(epc, plot(mydatetime, Global_reactive_power,
               xlab = "datetime", ylab = "Global_reactive_power", type = "n"))
with(epc, lines(mydatetime, Global_reactive_power))

# close device
dev.off()

