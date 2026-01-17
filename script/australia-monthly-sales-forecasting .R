#Australian Retail Sales Forecasting (Monthly)
# Author: Lydia Durunguma
# Description: Seasonal Naive (SNAIVE) benchmark + 2011 holdout backtest

############################################################

# Clear the working space
rm(list = ls())

# Set working directory

getwd()

# Load the packages 
install.packages("fpp")
install.packages("fpp2")
install.packages("fpp3")
install.packages("tsibble")
library(fpp)
library(fpp2)
library(fpp3)
library(tsibble)
install.packages("dplyr")
library(dplyr)
library(tidyverse)
install.packages("seasonal")
library(seasonal)
library(forecast)
library(readxl)
library(ggplot2)
library(forecast)


# turn off scientific notation except for big numbers
options(scipen = 9)

# load dataset from excel file
list.files("data")
retaildata <- read_excel("data/retail.xlsx", skip = 1)

View(retaildata)


#select one of the time series as follows
retaildata_ts <- ts(retaildata$A3349873A,
                    start = c(1982, 4), 
                    frequency = 12)

# Plot the time series
autoplot(retaildata_ts) +
  ggtitle("Retail Data Over Time") +
  ylab("Retailing") +
  xlab("Year")

# Split the retaildata_ts data into a training set and a test set, where the test set starts from year 2011

retaildata.train <- window(retaildata_ts, end=c(2010,12))
retaildata.test <- window(retaildata_ts, start=2011)

#Check that your data have been split appropriately by producing the following plot (Question 2)
autoplot(retaildata_ts) +
  autolayer(retaildata.train, series="Training") +
  autolayer(retaildata.test, series="Test")



# Calculate forecasts using SNAIVE method applied to the training set (Question 3)
retaildata_snaive <- snaive(retaildata.train, h=36)

# Plot the SNAIVE forecasts
autoplot(retaildata_snaive, h=36) +
  autolayer(retaildata.test, series="Test Data") +
  ggtitle("Retail Data Forecast Using Snaive Method") +
  ylab("Retail Data") +
  xlab("Year") +
  guides(colour=guide_legend(title="Series"))

#Compare the accuracy of your forecasts against the actual values stored in retaildata.test(Question 4)
accuracy(retaildata_snaive,retaildata.test)
#RMSE test set is 100.00869

#  To compare the actual and forecasted values using autolayer plot
autoplot(retaildata_ts) +
  autolayer(retaildata_snaive, series="Seasonal Naive Forecast") +
  ggtitle("Snaive Method Comparison on Test Set") +
  xlab("Year") + ylab("Houses Sold") +
  guides(colour=guide_legend(title="Forecast Method"))

# Create a data frame with actual and forecasted values
print(retaildata_snaive)
# Extract forecasted values from the mean component (From Point Forecast)
forecasted_values <- as.numeric(retaildata_snaive$mean)
print(forecasted_values)

#To compare the actual and forecasted values in a table with two columns 
# containing actual and forecasted values
comparison <- data.frame(
  Actual_Values = as.numeric(retaildata.test), # Actual values from the test set
  Forecast_Values = forecasted_values)         # Forecasted values from SNAIVE


# Display the comparison table
print(comparison)



# Check the residuals.
checkresiduals(retaildata_snaive)



