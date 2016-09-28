setwd("D:/course_p2")
if(!file.exists("file.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","file.zip")
  unzip("file.zip")
}
if(!exists("NEI") |!exists("SCC")){
  NEI = readRDS("summarySCC_PM25.rds")
  SCC = readRDS("Source_Classification_Code.rds")
}
#Across the United States, how have emissions from coal combustion-related sources changed from 1999¡V2008?
selec = as.numeric(as.character(unique(SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector),]$SCC)))
coal=NEI[NEI$SCC %in% selec,]

coal_sum =aggregate(Emissions ~ year, coal, sum) 

png("plot4.png")
g <- ggplot(coal_sum, aes(factor(year), Emissions)) + geom_bar(stat="identity") + xlab("year") + ylab(expression("Total PM2.5 Emissions")) + ggtitle("Total Emissions from coal sources from 1999 to 2008") 
print(g) 
dev.off()