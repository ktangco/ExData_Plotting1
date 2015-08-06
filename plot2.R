### Graph #2 ###

## This section is the same across all of the R codes for Project 1 ##

## Read in original data set, character vectors are NOT converted to factors
rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

## Change the format of the Date variable to be day/month/year
date <- dmy(rawdata$Date)
chg_dates <- mutate (rawdata, Date = date)

## Filter data to only those on 1 Feb 2007 & 2 Feb 2007
reqd_dates <- filter (chg_dates, Date == dmy("01/02/2007") | Date == dmy("02/02/2007"))

## Change characters as numeric variables
reqd_data <- reqd_dates %>% mutate(
                    Global_active_power = as.numeric(Global_active_power),
                    Global_reactive_power = as.numeric(Global_reactive_power),
                    Voltage = as.numeric(Voltage),
                    Global_intensity = as.numeric(Global_intensity),
                    Sub_metering_1 = as.numeric(Sub_metering_1),
                    Sub_metering_2 = as.numeric(Sub_metering_2),
                    Sub_metering_3 = as.numeric(Sub_metering_3))

## ----- End of common section across all of the R codes ----- ##

## Combine date & time variables ##
time <- gsub(":","-",reqd_data$Time)
date_time <- reqd_data %>% mutate(date_time = paste(Date, time, sep = "-"),
                                  ymdhms = ymd_hms(date_time))

## Plot for Question 2 ##

par(mfcol = c(1,1))

with(date_time, plot(ymdhms, Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot2.png", width = 480, height = 480) 

dev.off()