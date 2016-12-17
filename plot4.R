#Download the file from the location path

sourcedata_link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(sourcedata_link, destfile = "household_power_consumption.zip")

#Unzip the file and place it in the working directory for further processing
sourcefile_raw <- unzip("household_power_consumption.zip")

#Read the text file in its entirety
sourcedata <- read.table(sourcefile_raw, header=TRUE, sep=";",stringsAsFactors = FALSE)

#Initiatizes the dplyr package, which is used to filter the data based on conditions

library(dplyr)
selecteddata <- filter(sourcedata, (as.Date(Date, format = '%d/%m/%Y')) == "2007-02-01" 
                       | (as.Date(Date, format = '%d/%m/%Y')) == "2007-02-02" )

# Create the datetime column by combining the date and time column and converting it to POSIXlt
selecteddata$datetime <- strptime(paste(selecteddata$Date,selecteddata$Time),"%d/%m/%Y %H:%M:%S")

# Create the emptry png file to be loaded with the graphs
png(file="plot4.png", width = 480, height = 480, units = "px")

#Initialize the width and margin of the device
par(mfrow = c(2,2), mar=c(4,4,2,1))

#Plot the 4 graphs row wise, print this to the png file and close the device upon completion

plot(selecteddata$datetime, selecteddata$Global_active_power, type ="l",xlab="",ylab="Global Active Power")
plot(selecteddata$datetime, selecteddata$Voltage, type="l", xlab="datatime",ylab="Voltage")
plot(selecteddata$datetime, selecteddata$Sub_metering_1,type="l", xlab="",ylab="Energy sub metering", col="black")
lines(selecteddata$datetime, selecteddata$Sub_metering_2,type="l",col="red")
lines(selecteddata$datetime, selecteddata$Sub_metering_3,type="l",col="blue")
legend("topright",names(selecteddata[7:9]), lty=c(1,1,1), col=c("black","red","blue"))
plot(selecteddata$datetime,selecteddata$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()