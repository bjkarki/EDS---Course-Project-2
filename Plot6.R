# The script assumes current directory is inside the Assignment folder
## RDS data is within the 'Data File' directory

if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

#library
library(ggplot2)

# Subset Baltimore and Los Angeles data
reqVehicleData <- subset(NEI, (fips == "24510"|fips == "06037") & type == "ON-ROAD")

# Total emission per year based on fips
totalPM2.5 <- aggregate(Emissions ~ year + fips, reqVehicleData, sum)
rm(reqVehicleData)

# City names a better factor in GGPlot
totalPM2.5$City[totalPM2.5$fips=="24510"] <- "Baltimore City"
totalPM2.5$City[totalPM2.5$fips=="06037"] <- "Los Angeles County"

# Graphing System

## Loading graphing system
png("Plot6.png")
g <- ggplot(data = totalPM2.5, mapping = aes(x = as.factor(year), y = Emissions))
g <- g + theme_bw() + theme(strip.text.y = element_blank())
g <- g + facet_grid(City~., scales = "free")
g <- g + geom_bar(stat = "identity", aes(fill = City))
g <- g +
        labs(title = expression('Total On-Road (Vehicles) PM'[2.5]*' Emission')) + 
        labs(x = "Years") + 
        labs(y = expression('PM'[2.5]*' Emission (tonnes)'))
print(g)

## Close the graphing device
dev.off()

## remove temp files
rm(totalPM2.5, g)