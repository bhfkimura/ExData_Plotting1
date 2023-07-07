## Before running this script, please, download the data set at
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# and extract the .txt file in the same folder as this script is located.

library(plotly)

## Import data set 
household_power_consumption <- read.csv(file = "./household_power_consumption.txt", 
                                        sep = ";")

## Coerce the first column to the date format, filter cases which correspond to dates
# between 2007-02-01 and 2007-02-02.

data <- mutate(household_power_consumption, Date = as.Date(Date, format = "%d/%m/%Y")) %>%
        filter(Date >= "2007-02-01", Date <= "2007-02-02") %>%
        mutate(Date_Time = strptime(paste(Date,Time), format = "%Y-%m-%d %H:%M:%S", tz = "CET"))

## Plot 2 
png(filename = "./Plot2.png", width = 480, height = 480)

plot(x = data$Date_Time,
     y = as.numeric(data$Global_active_power),
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = 'l')

dev.off()