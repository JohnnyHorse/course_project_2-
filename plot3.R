setwd("D:/course_p2")
if(!file.exists("file.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","file.zip")
  unzip("file.zip")
}
if(!exists("NEI") |!exists("SCC")){
  NEI = readRDS("summarySCC_PM25.rds")
  SCC = readRDS("Source_Classification_Code.rds")
}
#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999¡V2008 for Baltimore City? 
#Which have seen increases in emissions from 1999¡V2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
fips24510=subset(NEI,fips=="24510")
fips24510_sum_type <- aggregate(Emissions ~ year+type, fips24510, sum) 

png("plot3.png")
g <- ggplot(fips24510_sum_type , aes(year, Emissions, color = type)) +geom_line() + xlab("year") + ylab("Total PM2.5 Emissions") + ggtitle("Total Emissions in Baltimore City, Maryland from 1999 to 2008") 
print(g) 
dev.off()