## Plot 2

## This plot presents power consumption by day of week -- Thrs, Fri, and Saturday
## y-axis has power consumption (kilowatts) -- Global Active Power
## x-axis has 3 days of week -- Thursday, Friday, and Saturday

## This R script is to be executed from a working directory that has the R files 
## need to produce the plots AND the downloaded and unzipped data.  
## The unzipped datafile is called "household_power_consumption.txt" 

## I am setting my working directory to: 
## "./Exploring Data Course" 
## When finished I will reset to my normal default directory

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

## Data already in correct sort sequence -- no sort needed

## Convert date/time so can plot the date/time on the x axis
## Since this converts to a date it defaults to the current time zone (ok)
## Can truncate later to remove time zone for printing a character string
tempdt <- strptime((paste(tempdfshort$Date, tempdfshort$Time)), format="%Y-%m-%d %H:%M:%S")

## Need to write this to a PNG file 480x480 pixels
## Need to set up a device, write, then close
png(filename = "./plot2.png", width=480, height=480, units="px", pointsize=12)
plot(tempdt, tempdfshort$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

setwd(origdir)
