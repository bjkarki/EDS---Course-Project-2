# The script assumes current directory is inside the Assignment folder
## RDS data is within the 'Data File' directory

if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
        SCC <- readRDS("Data File/Source_Classification_Code.rds")
}

## subsetting only coal matches
matchesForCoal <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
reqSCC <- SCC[matchesForCoal,]
rm(matchesForCoal)
## merginge to get NEISCC
NEISCC <- merge(NEI, reqSCC, by = "SCC")
rm(reqSCC)

# There is no NAs in the file, so we don't have to worry any further

# Total PM2.5 emission per year due to coal related agents
totalPM2.5 <- with(NEISCC, tapply(Emissions, year, sum))
rm(NEISCC)
## Changing the unit to Mega Tons
totalPM2.5 <- round(totalPM2.5/10^3, digits = 0)

# Graphing System

## Loading graphing system
png("Plot4.png")
par(mar = c(5,5,3,1))
## Plot
barplot(totalPM2.5,
        density = 75,
        ylim = c(0,650))
title(main = expression('Total PM'[2.5]*' Emission from Coal Sources'),
      xlab = "Years",
      ylab = expression('PM'[2.5]*' Emission (Kilo tonnes)'))
points(totalPM2.5)
lines(totalPM2.5)
## Close the graphing system
dev.off()
rm(totalPM2.5)