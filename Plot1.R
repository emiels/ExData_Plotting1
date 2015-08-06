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
# specific code to generate plot 1
# open device png in file plot1.png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# plot the histogram for Global Active Power
hist(epc$Global_active_power, col = 'red', main = "Global active power", xlab = "Globale Active Power (kilowatts)")
# close device
dev.off()


