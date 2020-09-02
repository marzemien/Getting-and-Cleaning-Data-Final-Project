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
write.table(Full_Data,paste0(getwd(), "/UCI HAR Dataset/Full_Data.txt", col.names = FALSE))

#Removes extra objects from the global environment. 
rm(URL, varnames, TestFiles, TestList, TrainFiles, TrainList)







