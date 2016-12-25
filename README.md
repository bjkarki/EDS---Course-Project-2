#Exploratory Data Analysis Course Project 2

###Summary
This repository explores the database released by EPA on Emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the [EPA National Emissions Inventory web site](https://www.epa.gov/air-emissions-inventories).

###Background
The R script files in the repository expects the current directory to have two RDS files `summarySCC_PM25.rds` and `Source_Classification_Code.rds` accessible.

Moreover, files are expected to be loaded as:

```
NEI <- readRDS("Data File/summarySCC_PM25.rds")
SCC <- readRDS("Data File/Source_Classification_Code.rds”)
```

After loading the data, its different aspects are explored.