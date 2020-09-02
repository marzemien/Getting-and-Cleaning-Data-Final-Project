---
title: "run_analysis_Code_Book"
author: "Michael Rzemien"
date: "9/1/2020"
output:
  pdf_document: default
  html_document: default
---


# Getting and Cleaning Data, Week 4 Peer Review Project

The data for the course project comes from UC Irvine's machine learning laboratory. For a more detailed description of this set can be found at.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Script Overview

The script creates a new directory named “UCI HAR Dataset”.
The script for this assignment was written to be run in its entirety. In the end it should open the mean and standard deviation table and print the head of the cleaned dataset. Each of these should have corresponding objects in the Global Environment named Full_Data and Mean_and_SD
Once downloaded, the zip file from this study contains a training dataset and a test dataset. Both contain the same numerical variables. This script downloads, unzips, and parses these files. It then creates separate dataframe objects for train and test data, before combining the two as an object named Full_Data. Also, a table summarizing the mean and standard deviation of all variables, which is then opened using View( ) . In the interest of keeping the Global Environment clean, and because showing them is not a requirement to complete this assignment, the parsed training and test dataframes are removed from the Global Environment at the very end of the script.  

##Notes about the variables

The variable names were changed to be a more descriptive. With the exception of the parsing, they were kept in their original forms. 
+	"x-axis acceleration
+	"y-axis acceleration"
+	"z-axis acceleration"
+	"x-axis angular velocity"
+	"y-axis angular velocity"
+	"z-axis angular velocity"
+	"total x-axis acceleration"
+	"total y-axis acceleration"
+	"total z-axis acceleration"

##The Script

```{r cars}
install.packages("tidyverse")
install.packages("haven")
library(tidyverse)
library(haven)
library(purrr)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "ziped")
unzip(paste0(getwd(), "/", "ziped"))

TestList <- list.files(paste0(getwd(), "/UCI HAR Dataset/test/Inertial Signals"))
TrainList <- list.files(paste0(getwd(), "/UCI HAR Dataset/train/Inertial Signals"))
TestFiles <- map_chr(TestList, ~ paste0(getwd(), "/UCI HAR Dataset/test/Inertial Signals/", .x))
TrainFiles <- map_chr(TrainList, ~ paste0(getwd(), "/UCI HAR Dataset/train/Inertial Signals/", .x))

varnames <- c("x-axis acceleration", "y-axis acceleration", "z-axis acceleration", 
              "x-axis angular velocity", "y-axis angular velocity", "z-axis angular velocity", 
              "total x-axis acceleration", "total y-axis acceleration", "total z-axis acceleration")

#TestFiles
HoldmatrixTest <- matrix(nrow = 377216, ncol = 9)
for(i in seq_along(TestFiles)){
  HoldmatrixTest[ ,i] <- subset(file <- 
                                  as.character(read.delim(TestFiles[i], header = FALSE)[ ,1]) %>%
                                  str_split(" ") %>%
                                  unlist() %>%
                                  as.numeric(), !is.na(file))
}
#TrainFiles
HoldmatrixTrain <- matrix(nrow = 941056, ncol = 9)
for(i in seq_along(TrainFiles)){
  HoldmatrixTrain[ ,i] <- subset(file <- 
                                   as.character(read.delim(TrainFiles[i], header = FALSE)[ ,1]) %>%
                                   str_split(" ") %>%
                                   unlist() %>%
                                   as.numeric(), !is.na(file))
}

#Putting it all together
Full_Data <- bind_rows(as.data.frame(HoldmatrixTest), as.data.frame(HoldmatrixTrain))
rm(HoldmatrixTrain, HoldmatrixTest)
rm(file, i)
colnames(Full_Data) <- varnames


#Mean and SD data.frame
Mean_and_SD <- rbind(map_dbl(Full_Data, mean),
             map_dbl(Full_Data, sd))
rownames(Mean_and_SD) <- c("mean", "sd")
View(Mean_and_SD)
head(Full_Data)

#Removes extra objects from the global environment. 
rm(URL, varnames, TestFiles, TestList, TrainFiles, TrainList)
```





