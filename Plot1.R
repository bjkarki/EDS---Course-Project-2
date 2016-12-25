# Assuming current directory  inside the Assignment folder
if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

# There is no NAs in the file, so we don't have to worry any further

## Total sum of PM 2.5 Emissions for each year
totalPM2.5 <- with(NEI, tapply(Emissions, year, sum))
## Changing the unit to Mega Tons
totalPM2.5 <- round(totalPM2.5/10^6, digits = 2)

# Graphing System

## Loading graphing system
png("Plot1.png")
par(mar = c(5,5,3,1))
## Plot
barplot(totalPM2.5,
        ylim = c(0,8),
        density = 75)
title(main = expression('Total PM'[2.5]*' Emission'),
      xlab = "Years",
      ylab = expression('PM'[2.5]*' Emission (Mega tonnes)'))
points(totalPM2.5)
lines(totalPM2.5)
## Close the graphing system
dev.off()
rm(totalPM2.5)