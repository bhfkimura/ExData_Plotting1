library(dplyr)
library(ggplot2)

## Import data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Filter data, considering only data from Baltimore City
NEI_filtered <- filter(NEI, fips == "24510")

## Group data by year and type, and calculate the total emission within each group
Total <- NEI_filtered %>% 
        group_by(year, type) %>% 
        summarize(Total.Emission = sum(Emissions), .groups = "drop") 

## Generate plot
png(filename = "./Plot3.png", width = 480, height = 480)
ggplot(Total, aes(x = year, y = Total.Emission, group = type, color = type)) +
        labs(title = "Emissions from 1999 to 2008 in Baltimore City", y = "Total Emission") +
        geom_line() 
dev.off()