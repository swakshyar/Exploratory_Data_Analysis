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
png(file="plot1.png", width = 480, height = 480, units = "px")

#Create the historgram based on the assignment and close the device after the activity
hist(as.numeric(selecteddata$Global_active_power), col="red", 
     xlab="Global Active Power(kilowatts)", main="Global Active Power")
dev.off()