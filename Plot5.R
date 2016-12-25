# The script assumes current directory is inside the Assignment folder
## RDS data is within the 'Data File' directory

if (!exists("NEI")) {
        NEI <- readRDS("Data File/summarySCC_PM25.rds")
}

# Only select Baltimore data with type "ON-ROAD"
baltimoreVehicleData <- subset(NEI, fips == "24510" & type == "ON-ROAD")

# Summing the total PM2.5 emission for each year
totalPM2.5 <- with(baltimoreVehicleData, tapply(Emissions, year, sum))
rm(baltimoreVehicleData)

# Graphing System

## Loading graphing system
png("Plot5.png")
par(mar = c(5,5,3,1))

## Plot
barplot(totalPM2.5,
        ylim = c(0,400),
        density = 75)

title(main = expression('Total On-Road (Vehicle) PM'[2.5]*' Emission in Baltimore, MD'),
      xlab = "Years",
      ylab = expression('PM'[2.5]*' Emission (tonnes)'))
points(totalPM2.5)
lines(totalPM2.5)
## Close the graphing system
dev.off()

rm(totalPM2.5)
