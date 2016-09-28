setwd("D:/course_p2")
if(!file.exists("file.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","file.zip")
  unzip("file.zip")
}
if(!exists("NEI") |!exists("SCC")){
  NEI = readRDS("summarySCC_PM25.rds")
  SCC = readRDS("Source_Classification_Code.rds")
}
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
fips24510=subset(NEI,fips=="24510")
fips24510_sum = aggregate(Emissions ~ year, fips24510, sum) 

png("plot2.png")
with(fips24510_sum,barplot(Emissions,names.arg=year, xlab="years", ylab="total PM2.5 emission",main="Total PM2.5 emissions in the Baltimore City from 1999 to 2008")) 
dev.off()