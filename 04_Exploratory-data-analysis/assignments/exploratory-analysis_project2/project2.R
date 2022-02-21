#Download and upzip the data into the subfolder under the R working directory
#the method = "curl" for download.file on Mac os
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
temp <- tempfile()
download.file(URL,temp, method = "curl")
unzip (temp,exdir = "./exploratory-analysis_project2")
rm(URL,temp)
library(dplyr)
library(ggplot2)
#Read the files from the subfolder under the working directory into R
NEI <- readRDS("./exploratory-analysis_project2/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory-analysis_project2/Source_Classification_Code.rds")

####Plot1####
#1 Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from
#all sources for each of the years 1999, 2002, 2005, and 2008.
##Summarize the data by sum of each year using the "dplyr"
NEI.yearsum <- NEI %>% group_by(year) %>% summarize(sum(Emissions))
colnames(NEI.yearsum) <- c("year","sum_emissions")
NEI.yearsum$year <- as.factor(NEI.yearsum$year)
##Plot the total emissions by year
png("./exploratory-analysis_project2/plot1.png")
pl1 <- with(NEI.yearsum, 
            barplot(sum_emissions, main = "Emissions by year in US",
                    xlab = "year", ylab = "emissions"))
axis(1, at = pl1, labels = NEI.yearsum$year)
dev.off()
##Based on the plot, the total emissions did go down from 1999 to 2008

####Plot2####
#2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.
##Subset the data for Baltimore City, Maryland
NEI.BC.year.sum <- NEI %>% filter(fips == "24510") %>% group_by(year) %>%
  summarize(sum(Emissions))
colnames(NEI.BC.year.sum) <- c("year","sum_emissions")
NEI.BC.year.sum$year <- as.factor(NEI.BC.year.sum$year)
##Plot the total emission in Baltimore City
png("./exploratory-analysis_project2/plot2.png")
pl2 <- with(NEI.BC.year.sum, 
            barplot(sum_emissions, main = "Emissions by year in Baltimore City",
                    xlab = "year", ylab = "emissions"))
axis(1, at = pl2, labels = NEI.BC.year.sum$year)
dev.off()
##Based on the plot, in general the total emissions went down from 1999 to 2008,
##with the exception of 2005, which is higher than 2002

####Plot3####
#3 Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
#Which have seen increases in emissions from 1999–2008?
#Use the ggplot2 plotting system to make a plot answer this question.

##Subset the data for Baltimore City, Maryland
NEI.BC.year.sum.type <- NEI %>% filter(fips == "24510") %>% group_by(year,type) %>% 
  summarize(sum(Emissions))
colnames(NEI.BC.year.sum.type) <- c("year", "type","sum_emissions")
##Plot the total emissions by year within each type
png("./exploratory-analysis_project2/plot3.png")
pl3 <- ggplot(NEI.BC.year.sum.type, aes(x = year, y = sum_emissions)) + 
  geom_point(shape = 1) + facet_wrap (~ type, ncol = 2)
pl3
dev.off()
##Based on the plot, the source "POINT" has seen increases in emissions while the rest have seen decreases

####Plot4####
#4 Across the United States, how have emissions from coal combustion-related sources changed?

##Find coal combustion-related sources:in SCC.Level.One contains "combustion"
##and in SCC.Level.Three contains "coal"
SCC_CoalCombustion <- SCC[grepl("[Cc]ombustion",SCC$SCC.Level.One) ==TRUE & grepl("[Cc]oal",SCC$SCC.Level.Three)==TRUE,]
##Filter in  NEI the emissions related to coal combustion
NEI_CoalCombustion <- filter(NEI,SCC %in% SCC_CoalCombustion$SCC)
NEI_CoalCombustion$year <- as.factor(NEI_CoalCombustion$year)
##Plot the sum of emissions by year
png("./exploratory-analysis_project2/plot4.png")
ggplot(NEI_CoalCombustion,aes(x=year, y = Emissions)) + 
  stat_summary(fun.y = sum,geom="bar") + 
  ylab("emissions from coal combustion-related sources")
dev.off()
##Based on the plot, emissions from coal combustion-related sources decreased across the US

####Plot5####
#5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

##Find motor vehicle sources of emissions by searching "[Vv]ehicle" or "[Ee]ngine" in SCC.Level.Two
SCC_MV <- SCC[grepl("[Vv]ehicle",SCC$SCC.Level.Two) ==TRUE | grepl("[Ee]nginel",SCC$SCC.Level.Two)==TRUE,]
##Subset the data for Baltimore City, Maryland and filter
##the emissions related to motor vehicle
NEI.BC.MV <- NEI %>% filter(fips == "24510") %>% filter(SCC %in% SCC_MV$SCC)
NEI.BC.MV$year <- as.factor(NEI.BC.MV$year)
##Plot the sum of emissions by year
png("./exploratory-analysis_project2/plot5.png")
ggplot(NEI.BC.MV,aes(x=year, y = Emissions)) + 
  stat_summary(fun.y = sum,geom="bar") +
  ylab("emissions from motor vehicle sources")
dev.off()
##Based on the plot, emissions from motor vehicle sources decreased in Baltimore City from 1999-2008

####Plot6####
##6 Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California (fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

##Find motor vehicle related sources of emissions by searching "[Vv]ehicle" or "[Ee]ngine" in SCC.Level.Two
SCC_MV <- SCC[grepl("[Vv]ehicle",SCC$SCC.Level.Two) ==TRUE | grepl("[Ee]nginel",SCC$SCC.Level.Two)==TRUE,]

##Subset the emissions from Baltimore City and Los Angeles County and filer 
##the emissions related to motor vehicle
NEI.BC.LA.MV <- NEI %>% filter(fips == "06037" | fips == "24510") %>%
  filter(SCC %in% SCC_MV$SCC) %>% 
  mutate(county = ifelse(fips == "06037", "LA County", "Baltimore City"))
NEI.BC.LA.MV$year <- as.factor(NEI.BC.LA.MV$year)
##Plot the comparison of the two
png("./exploratory-analysis_project2/plot6.png")
ggplot(NEI.BC.LA.MV,aes(x=year, y = Emissions)) + 
  stat_summary(fun.y = sum, geom="bar") + facet_grid(.~ county) +
  ylab("emissions from motor vehicle sources") 
dev.off()
##Based on the plot, Los Angeles has seen greater changes over time