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
png(file="plot3.png", width = 480, height = 480, units = "px")

# Plot the first graph and add subsequent lines for the meter readings and close the device upon completion
plot(selecteddata$datetime, selecteddata$Sub_metering_1,type="l",xlab = "", ylab="Energy sub metering", col="black")
lines(selecteddata$datetime, selecteddata$Sub_metering_2, col="red")
lines(selecteddata$datetime, selecteddata$Sub_metering_3, col="blue")
legend("topright",names(selecteddata[7:9]), col=c("black","red","blue"),lty=c(1,1,1))
dev.off()