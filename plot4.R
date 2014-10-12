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
png(filename="plot4.png",height=480,width=480)
# Set up our 2 x 2 grid
par(mfrow=c(2,2))
# Plot line graph of global active power vs time
plot(plotdata$DateTime,plotdata$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
# Plot line graph of voltage vs time
plot(plotdata$DateTime,plotdata$Voltage,xlab="datetime",ylab="Voltage",type="l")
# Create the line plot of sub metering vs time
plot(plotdata$DateTime,plotdata$Sub_metering_1,type="l",col="black",ylab="Energy sub metering",xlab="")
lines(plotdata$DateTime,plotdata$Sub_metering_2, col="red")
lines(plotdata$DateTime,plotdata$Sub_metering_3, col="blue")
legend("topright",bty="n",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
# Create final graph of global reactive power vs time
plot(plotdata$DateTime,plotdata$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
# Close the graphics device
dev.off()