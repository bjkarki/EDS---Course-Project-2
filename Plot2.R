# Assuming current directory is inside the Assignment folder
if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

# There is no NAs in the file, so we don't have to worry any further

# Selecting subset of data with condition fips = 24510 and then the total PM2.5 emission per year
## Data selection with fips = 24510
baltimoreData <- subset(NEI, fips == "24510")
## Calculating totalPM2.5 per year for selected subset of data
totalPM2.5 <- with(baltimoreData, tapply(Emissions, year, sum))
## Changing the unit to Mega Tons
totalPM2.5 <- round(totalPM2.5/10^3, digits = 2)

# Graphing System

## Loading graphing system
png("Plot2.png")
par(mar = c(5,5,3,1))
## Plot
barplot(totalPM2.5,
        ylim = c(0,4),
        density = 75)
title(main = expression('Total PM'[2.5]*' Emission in Baltimore, MD'),
      xlab = "Years",
      ylab = expression('PM'[2.5]*' Emission (Kilo tonnes)'))
points(totalPM2.5)
lines(totalPM2.5)
## Close the graphing system
dev.off()

rm(baltimoreData, totalPM2.5)