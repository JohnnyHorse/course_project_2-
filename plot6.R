setwd("D:/course_p2")
if(!file.exists("file.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","file.zip")
  unzip("file.zip")
}
if(!exists("NEI") |!exists("SCC")){
  NEI = readRDS("summarySCC_PM25.rds")
  SCC = readRDS("Source_Classification_Code.rds")
}
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
motor = subset(NEI,(fips=="24510"|fips=="06037") & type=="ON-ROAD")
motor_sum = aggregate(Emissions ~ year+fips, motor, sum)
motor_sum[motor_sum$fips=="24510",]$fips="Baltimore City, Maryland"
motor_sum[motor_sum$fips=="06037",]$fips="Los Angeles County, California"

png("plot6.png")
g <-ggplot(motor_sum, aes(factor(year),Emissions, fill=fips)) + geom_bar(stat="identity") +  facet_grid(fips  ~ ., scales="free") + ylab("total emissions (tons)") +  xlab("year") + ggtitle(expression("Motor vehicle emission variation\nin Baltimore and Los Angeles")) 
print(g) 
dev.off()
