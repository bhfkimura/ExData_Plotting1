library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Merge the two datasets
NEI_merged <- merge(x = NEI, y = SCC, by = "SCC")

## Select rows related to vehicle emission
NEI_Motor <- NEI_merged[grepl(pattern = "Veh", x = NEI_merged$Short.Name),]

## Filter data considering only data for Baltimore City and Los Angeles, respectively,
# Group data by year and calculate the total emission within each group
Total_BC <- filter(NEI_Motor, fips == "24510") %>% 
        group_by(year) %>% 
        summarize(Total.Emission = sum(Emissions)) 
Total_LA <- filter(NEI_Motor, fips == "06037") %>% 
        group_by(year) %>% 
        summarize(Total.Emission = sum(Emissions)) 

## Generate plots
png(filename = "./Plot6.png", width = 480, height = 480)
par(mfrow = c(1,2))
barplot(Total.Emission ~ year, 
        data = Total_BC, 
        xlab = "Year", 
        ylab = "Total Emission",
        main = "Baltimore City",
        col = "blue")
barplot(Total.Emission ~ year, 
        data = Total_LA,
        xlab = "Year", 
        ylab = "Total Emission",
        main = "Los Angeles",
        col = "red")
dev.off()

