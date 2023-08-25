library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge the two datasets
NEI_merged <- merge(x = NEI, y = SCC, by = "SCC")

## Select rows related to vehicle emission
NEI_Motor <- NEI_merged[grepl(pattern = "Veh", x = NEI_merged$Short.Name),]

## Filter data considering only data for Baltimore City,
# roup data by year and calculate the total emission within each group
Total <- filter(NEI_Motor, fips == "24510") %>% 
        group_by(year) %>% 
        summarize(Total.Emission = sum(Emissions)) 

## Generate plot
png(filename = "./Plot5.png", width = 480, height = 480)
barplot(Total.Emission ~ year, 
     data = Total,
     xlab = "Year", 
     ylab = "Total Emission",
     main = "Total emission from motor vehicle sources from \n 1999 to 2008 in Baltimore City")
dev.off()

