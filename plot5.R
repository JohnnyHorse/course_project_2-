setwd("D:/course_p2")
if(!file.exists("file.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","file.zip")
  unzip("file.zip")
}
if(!exists("NEI") |!exists("SCC")){
  NEI = readRDS("summarySCC_PM25.rds")
  SCC = readRDS("Source_Classification_Code.rds")
}
#How have emissions from motor vehicle sources changed from 1999¡V2008 in Baltimore City?
motor = subset(NEI,fips=="24510" & type=="ON-ROAD")
motor_sum = aggregate(Emissions ~ year, motor, sum)
png("plot5.png")
g <- ggplot(motor_sum, aes(factor(year), Emissions)) + geom_bar(stat="identity") + xlab("year") + ylab("Total PM2.5 Emissions") + 
ggtitle('Total Emissions from motor vehicle in Baltimore City, Maryland from 1999 to 2008') 
print(g) 
dev.off()