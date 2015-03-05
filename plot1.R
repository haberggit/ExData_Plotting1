## Plot 1

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

## Need to write this to a PNG file 480x480 pixels
## Need to set up a device, write, then close
png(filename = "./plot1.png", width=480, height=480, units="px", pointsize=12)
hist(tempdfshort$Global_active_power, main="Global Active Power", xlab="Global Active Power(kilowatts)", col="red")
dev.off()

setwd(origdir)
