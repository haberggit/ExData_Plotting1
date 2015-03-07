## Plot 4

## This script creates 4 plots to represent power consumption by day/time of week
## y-axis has power consumption for different variables
## x-axis has 2 days of week -- 2007-02-01 and 2007 02-02

## This R script is to be executed from a working directory that has the R files 
## need to produce the plots AND the downloaded and unzipped data.  
## The unzipped datafile is called "household_power_consumption.txt" 

## ------------------------------------------------------------------------
## I am setting my working directory in the R code to: 
## "./Exploring Data Course" -- that is the subdirectory where my files are
## When finished I reset to my normal default directory in the R code
## NOTE:  THIS IS MY SETUP ONLY
##        OTHERS SHOULD COMMENT OUT THE setwd() on line 22
##        TO EXECUTE IN THE CURRENT WORKING DIRECTORY
## -------------------------------------------------------------------------

origdir <- getwd()

setwd("./Exploring Data Course")

filename <- "household_power_consumption.txt"

## Gets the date in the right format
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
##

tempdf <- read.delim(filename, sep=";", na.strings="?", colClasses=c("myDate", "character", rep("numeric",7)))

## Subset the df to only the dates needed:  2007-02-01 and 2007-02-02.
tempdfshort <- subset(tempdf, Date >= "2007-02-01" & Date <= "2007-02-02")

## Convert date/time so can plot the date/time on the x axis
## Since this converts to a date it defaults to the current time zone (ok)
tempdt <- strptime((paste(tempdfshort$Date, tempdfshort$Time)), format="%Y-%m-%d %H:%M:%S")

## Write this to a PNG file 480x480 pixels
## Set up a device, write, then close
png(filename = "./plot4.png", width=480, height=480, units="px", pointsize=12)

par(mfrow=c(2,2))

plot(tempdt, tempdfshort$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(tempdt, tempdfshort$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(tempdt, tempdfshort$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(tempdt, tempdfshort$Sub_metering_2, type="l", col="red")
lines(tempdt, tempdfshort$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

plot(tempdt, tempdfshort$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

dev.off()

setwd(origdir)
