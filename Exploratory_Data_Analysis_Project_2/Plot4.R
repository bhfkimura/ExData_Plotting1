library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge the two datasets
NEI_merged <- merge(x = NEI, y = SCC, by = "SCC")

## Select rows related to coal combustion-related emission
NEI_Coal <- NEI_merged[grepl(pattern = "Coal", x = NEI_merged$Short.Name),]

## Group data by year and calculate the total emission within each group
Total <- NEI_Coal %>% 
        group_by(year) %>% 
        summarize(Total.Emission = sum(Emissions)) 

## Generate plot
png(filename = "./Plot4.png", width = 480, height = 480)
barplot(Total.Emission ~ year, 
     data = Total,
     xlab = "Year", 
     ylab = "Total Emission",
     main = "Total coal combustion-related emission \n from 1999 to 2008")
dev.off()

