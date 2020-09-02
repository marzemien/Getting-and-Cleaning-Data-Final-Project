# Getting-and-Cleaning-Data-Final-Project
Peer Graded Assignment for Hopkins Online Course "Getting and Cleaning Data". 

Getting and Cleaning Data, Week 4 Peer Review Project

The data for the course project comes from UC Irvine's machine learning laboratory. For a more detailed description of this set can be found at.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Script Overview
The script creates a new directory named “UCI HAR Dataset”.
The script for this assignment was written to be run in its entirety. In the end it should open the mean and standard deviation table and print the head of the cleaned dataset. Each of these should have corresponding objects in the Global Environment named Full_Data and Mean_and_SD
Once downloaded, the zip file from this study contains a training dataset and a test dataset. Both contain the same numerical variables. This script downloads, unzips, and parses these files. It then creates separate dataframe objects for train and test data, before combining the two as an object named Full_Data. Also, a table summarizing the mean and standard deviation of all variables, which is then opened using View( ) . In the interest of keeping the Global Environment clean, and because showing them is not a requirement to complete this assignment, the parsed training and test dataframes are removed from the Global Environment at the very end of the script.  

Notes about the variables
The variable names were changed to be a more descriptive. With the exception of the parsing, they were kept in their original forms. 


+	"y-axis acceleration"
+	"z-axis acceleration"
+	"x-axis angular velocity"
+	"y-axis angular velocity"
+	"z-axis angular velocity"
+	"total x-axis acceleration"
+	"total y-axis acceleration"
+	"total z-axis acceleration"
+"x-axis acceleration
