# Code Book

Code book describes the variables, the data, and any transformations or work that were performed to clean up the data.

##Variables of the R program

Data frames of raw data before processing, all names corresponds to data file names without ".txt" syffix:

    y_train, subject_train, X_train, y_test, subject_test, X_test, features, activity_labels

Processed names of features (data columns in main data table), names were converted to be complied with R names standard:     
    
    fnames

Merged data from corresponding test and train data sets:
     
    y, subject, X 
	
Note: X is main data frame which was additionally transformed as per requirements, filtered and binded.
	
Result tidy data frame:

    tidy_data


##Source Data

Download Link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

General Info:

Data describes the results of experimental measurements of different mechanical parameters of subjects during different activities using of smartphones Samsung Galaxy S II.

Data description:

Data files contains 10299 records in each files, splitted into 2 groups - test (30%) and train (70%).
Raw data in "Inertial Signals" sub-folders were pre-processed already with wide set of statistics.
Our task was to perform further processing of data in the following files:

	X_*.txt, y_*.txt, subject_*.txt, activity_labels.txt, features.txt
	
Also data descriptions were provided in files:

  README.txt, features_info.txt, features.txt, activity_labels.txt


##Data transformations scripted to get a tidy data set as required

  Loading data into R from the data files
  
  Merge training and test data
  
  Conversion variable names taken features.txt to R-compliant format
  
  Renaming variables with names got at previous step
  
  Filter the data remaining only variables related to means and standards deviations
  
  Bind the subject, activity code and activity label description to the main dataset
  
  Generate a new tidy data set as requested with averages by activity and sublect, and write it in a txt file
  
