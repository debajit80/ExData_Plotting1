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
png(file="./plot3.png",width=480,height=480)
plot(datafinal[,10],datafinal[,7],main=NULL,xlab="",ylab="Energy sub metering",col="black",type="l",lty=1,lwd=1,ylim=c(0,max(datafinal[,7:9])))
par(new=TRUE)
plot(datafinal[,10],datafinal[,8],main=NULL,xlab="",ylab="Energy sub metering",col="red",type="l",lty=1,lwd=1,ylim=c(0,max(datafinal[,7:9])))
par(new=TRUE)
plot(datafinal[,10],datafinal[,9],main=NULL,xlab="",ylab="Energy sub metering",col="blue",type="l",lty=1,lwd=1,ylim=c(0,max(datafinal[,7:9])))
par(new=FALSE)
legend('topright',legend=names(datafinal[7:9]),col=c("black","red","blue"),border="black",lty=1,lwd=2)
dev.off()