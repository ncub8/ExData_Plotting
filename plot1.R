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

lim <- c(0,1200)

#open png graphics device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", 
    bg = "white")

hist(pData$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (Killowats)",col="red",ylim=lim)
dev.off()