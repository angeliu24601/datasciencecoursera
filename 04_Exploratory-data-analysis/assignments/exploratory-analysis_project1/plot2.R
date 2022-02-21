## Download and upzip the data into the R working directory
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(URL,temp)
unzip (temp,exdir = "./")
rm(URL,temp)

## Load the data into R, transform date/time, and subset the data for the plots
library(dplyr)
hpc <- read.table("./household_power_consumption.txt", 
                  sep=";", na.strings="?", header=TRUE, 
                  colClasses=c(rep("character",2), rep("numeric",7)))
hpc <- mutate(hpc, Date = as.Date(Date,"%d/%m/%Y"), 
              Time = as.POSIXct(strptime(paste(Date,Time),"%Y-%m-%d %H:%M:%S")))
plot_data <- filter(hpc, Date == "2007-02-01" | Date == "2007-02-02")

## Plot 2
png("./plot2.png", width = 480, height = 480)
with(plot_data, plot(Time, Global_active_power,"l", 
                     xlab ="", ylab = "Global Active Power (kilowatts)"))
dev.off()