### Graph #4 ###

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

## Plot for Question 4 ##

png(file = "plot4.png", width = 480, height = 480) 

par(mfcol = c(2,2))

## Graph #1 (top left hand corner) ##
with(date_time, plot(ymdhms, Global_active_power, type = "l", xlab = "",
                     ylab = "Global Active Power"))

## Graph #2 (bottom left hand corner) ##
with(date_time, { 
     plot(ymdhms, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "") 
     lines(ymdhms, Sub_metering_2, type = "l", col = "red", xlab = "", ylab = "")
     lines(ymdhms, Sub_metering_3, type = "l", col = "blue", xlab = "", ylab = "")
     title(xlab = "", ylab = "Energy sub metering")
     legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        col = c("black", "red", "blue"), lty = 1, bty = "n")
})

## Graph #3 (top right hand corner) ##
with(date_time, plot(ymdhms, Voltage, type = "l", xlab = "datetime"))

## Graph #4 (bottom right hand corner) ##
with(date_time, plot(ymdhms, Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()

## Reproduce graph on screen device ##

par(mfcol = c(2,2), mar = c(4,4,2,1))

with(date_time, plot(ymdhms, Global_active_power, type = "l", xlab = "",
                     ylab = "Global Active Power"))

with(date_time, { 
        plot(ymdhms, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "") 
        lines(ymdhms, Sub_metering_2, type = "l", col = "red", xlab = "", ylab = "")
        lines(ymdhms, Sub_metering_3, type = "l", col = "blue", xlab = "", ylab = "")
        title(xlab = "", ylab = "Energy sub metering")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), lty = 1, bty = "n")
})

with(date_time, plot(ymdhms, Voltage, type = "l", xlab = "datetime"))

with(date_time, plot(ymdhms, Global_reactive_power, type = "l", xlab = "datetime"))


## Reset plot window to default settings ##
par(mfcol = c(1,1), mar = c(5.1,4.1,4.1,2.1))


message ("The graphs have been saved in a file called 'plot4.png' in the working
        directory.  They have also been reproduced on the screen.")