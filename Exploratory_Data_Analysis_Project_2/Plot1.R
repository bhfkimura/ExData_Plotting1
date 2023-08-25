library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Group data by year and calculate the total emission within each group
Total <- NEI %>% 
        group_by(year) %>% 
        summarize(Total.Emission = sum(Emissions)) 

# Generate plot
png(filename = "./Plot1.png", width = 480, height = 480)
barplot(Total.Emission ~ year, 
        data = Total,
        xlab = "Year", 
        ylab = "Total Emission",
        main = "Total emission from 1999 to 2008")
dev.off()