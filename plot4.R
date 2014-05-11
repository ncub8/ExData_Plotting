#set up getting and cleaning data as a function
getData <- function(){
  # file to get data
  f <- "household_power_consumption.txt"
  
  # use a sql select to get correct dates
  selector <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  
  #read the table the selector
  powerData <- read.csv.sql(f, sql=selector, sep=";")
  
  #read in data convert date and time columns
  #powerData <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?",stringsAsFactors=FALSE)
  powerData$DateTime <- as.POSIXct(strptime(paste(powerData$Date,powerData$Time), "%d/%m/%Y %H:%M:%S"))
  
  return(powerData)
}

pData <- getData()

png(filename = "plot4.png",
    width = 480, height = 480, units = "px", 
    bg = "white")
par(mfrow=c(2,2))

#plot 1

#plot 2
plot(pData$DateTime,pData$Global_active_power,type="l",
     xlab="",ylab="Global Active Power")

#plot 2
plot(pData$DateTime,pData$Voltage,type="l",
     xlab="datetime",ylab="Voltage")


#plot 3 
plot(x=pData$DateTime,y=pData$Sub_metering_1,type="l",
     xlab="",ylab="Energy Sub Meetering")
lines(x=pData$DateTime,y=pData$Sub_metering_2, type="l",col="red")
lines(x=pData$DateTime,y=pData$Sub_metering_3, type="l",col="blue")
legendTxt <-c("Sub Meetering 1","Sub Meetering 2", "Sub Meetering 3")
legend("topright",c("Sub Metering 1","Sub Metering 2", "Sub Metering 3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))

#plot 2 again
plot(pData$DateTime,pData$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")

dev.off()