# Set your local working directory
setwd("C:/GitHub/coursera_exdata-007_Assignment_Plotting1/")
# Read in the raw data provided for the course
# Ensure data is in the same directory as this R script
rawdata <- read.table(file="household_power_consumption.txt"
                      ,sep=";",header=TRUE,na.strings="?")

# Convert the string dates and times into a single date/time column
rawdata$DateTime <- strptime(paste(rawdata$Date,rawdata$Time),"%d/%m/%Y %H:%M:%S",tz="UTC")

# Create a logical vector to subset our data
plotsubset <- rawdata$DateTime >= strptime("01/02/2007","%d/%m/%Y",tz="UTC") & rawdata$DateTime < strptime("03/02/2007","%d/%m/%Y",tz="UTC")
# Subset the data to extract the two days we want
plotdata <- rawdata[plotsubset,]

# Clean up the workspace for performance
rm(rawdata)
rm(plotsubset)

# Set up our grapics device
png(filename="plot3.png",height=480,width=480)
# Create the line plot of sub metering vs time
plot(plotdata$DateTime,plotdata$Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="")
lines(plotdata$DateTime,plotdata$Sub_metering_2, col="red")
lines(plotdata$DateTime,plotdata$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
# Close the graphics device
dev.off()