# assignement
Coursera week 3 assignement

## !! the script will run with all the files loacated in your working directory
## !! this script will remove all of the existing object from your environment

### the Script is heavily commented, pleasse look at the code for a detailed explanation of the logic used.

the script does the following

- empty the console and reads all the necessary files
- merge the dt_train and dt_test as folloW:
  - first the training label from the y_* file
  - second the subject ID
  - the data
- the 2 data frame are then merged into 1 data frame
- get the column names data from the feature file
- add the "Activity" and "Subject_ID" and column 2 of the feature data into a new vector
- apply the column names to the data.frame
- remove the non alphanumeric characters and insure that all the column names are unique (this uses a solution from Lantana on Stackoverflow)
- load dplyr and filter the columns for mean and st_ dev
- get the activity name in the data frame using a for loop which iterates through the datframe
- .. the dataframe created there is part 4 of the assignement (filtered_data)
- create a vector containing the unique activity name
- create a vector containing all the unique subject ID
- create an empty vector of the same number of observation
- use 2 nested loops to run through all the different combination of user_ID/type of exercise
- duplicate the filtered_data df and remove data
- put the data from the matrix into the data frame
- remove the first useless row
- remove the row.names column
- cleaning up

while the scrip is running the console is used to indicate what the script is currently doing.
