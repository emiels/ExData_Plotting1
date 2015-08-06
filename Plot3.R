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
# specific code to generate plot 3
# open device png in file plot3.png
png(filename = "plot3.png", width = 480, height = 480, units = "px")
# plot energy metering over days
# initialize plot area
with(epc, plot(mydatetime, Sub_metering_1, 
        xlab = "", ylab = "Energy sub metering", type = "n"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
        legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
# add data as lines
with(epc, lines(mydatetime, Sub_metering_1, col = "black" ))
with(epc, lines(mydatetime, Sub_metering_2, col = "red"))
with(epc, lines(mydatetime, Sub_metering_3, col = "blue"))
# close device
dev.off()

