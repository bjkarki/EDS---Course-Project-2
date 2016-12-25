# Assuming current directory is inside the Assignment folder
if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

#Load required packages
library(dplyr)
library(plyr)
library(ggplot2)

# There is no NAs in the file, so we don't have to worry any further

# Data selection with fips = 24510
baltimoreData <- filter(NEI, fips == "24510")

# subsetting total Emissions based on year and type
totalPM2.5ByTypes <- ddply(baltimoreData, .(year,type), summarize, Emissions = sum(Emissions))
rm(baltimoreData)
# Graphing System

# Loading graphing system
png("Plot3.png")

# GGPlot
g <- ggplot(totalPM2.5ByTypes, mapping = aes(year, Emissions, col = type))

g <- g +
        geom_line(lwd = 1) + 
        labs(title = expression('Total PM'[2.5]*' Emission in Baltimore by Type')) + 
        labs(x = "Years") + 
        labs(y = expression('PM'[2.5]*' Emission (tonnes)'))

print(g)

dev.off()

rm(g, totalPM2.5ByTypes)