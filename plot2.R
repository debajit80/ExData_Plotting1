## Download the data 
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile ="./EDAProjectData.zip",method="curl")
unzip("./EDAProjectData.zip")

## Read the data for 2 days; reformat Date and Time columns
dataToUse1 <- subset(read.table("household_power_consumption.txt",sep=";",header =TRUE,na.strings = "?"), as.Date(Date,"%d/%m/%Y") == "2007-02-01")
dataToUse2 <- subset(read.table("household_power_consumption.txt",sep=";",header =TRUE,na.strings = "?"), as.Date(Date,"%d/%m/%Y") == "2007-02-02")
datafinal <- rbind(dataToUse1,dataToUse2)
datafinal$Date <- as.Date(datafinal$Date,"%d/%m/%Y")
datafinal$DateTime <- paste(datafinal$Date,datafinal$Time,sep=" ",collapse=NULL)
datafinal$DateTime <- as.POSIXlt(strptime(datafinal$DateTime,"%Y-%m-%d %H:%M:%S"))
datafinal$Day <- weekdays(datafinal$DateTime,abbreviate=TRUE)
datafinal <- datafinal[order(datafinal[,10]),]

## Construct the plot as a PNG file 
png(file="./plot2.png",width=480,height=480)
plot(datafinal[,10],datafinal[,3],col="black",xlab="",ylab="Global Active Power (kilowatts)",main=NULL,type="l",lwd=2)
dev.off()
