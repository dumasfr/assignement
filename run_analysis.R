## first lets read all the necessary files
cat("\014")
txt<-"Reading Raw Data"
print(txt)
X_train<-read.table("X_train.txt", quote="\"")
X_test<-read.table("X_test.txt", quote="\"")
y_train<-read.table("y_train.txt", quote="\"")
y_test<-read.table("y_test.txt", quote="\"")
subject_train<-read.table("subject_train.txt", quote="\"")
subject_test<-read.table("subject_test.txt", quote="\"")
cat("\014")
## merge the dt_train and dt_test as folloW:
## first the training label from the y_* file
## second the subject ID
## the data
print("Merging the Train data")
dt_train<-cbind(y_train, subject_train, X_train)
print("Merging the Test data")
dt_test<-cbind(y_test, subject_test, X_test)
## the 2 data frame are then merged into 1 data frame
print("Merging the 2 newly created data frames")
data<-rbind(dt_train,dt_test)
## get the column names data from the feature file
print("extracting the columns name")
features<-read.table("features.txt", quote="\"")
## add the "Activity" and "Subject_ID" and column 2 of the feature data into a new vector
col_names<-c("Activity", "Subject_ID", as.vector(features[,2]))
## apply the column names to the data.frame
names(data)<-col_names
## remove the non alphanumeric characters and insure that all the column names are unique
## this uses a solution from Lantana on Stackoverflow
print("correcting the columns names")
valid_col_name<-make.names(names=names(data), unique=TRUE, allow_ = TRUE)
names(data)<-valid_col_name
## loading dplyr and filtering the columns for mean and st_ dev
print("Loading dplyr and filtering data")
suppressWarnings(library(dplyr))
filtered_data<-select(data, Activity, Subject_ID, contains("mean", ignore.case=TRUE), contains("std", ignore.case=TRUE))
## get the activity name in the data frame
print("Loading the Activity label and applying it to the data")
activity_labels<-read.table("activity_labels.txt", quote="\"")
for (i in 1:dim(filtered_data)[1]){
  if (filtered_data[i,1]==1){filtered_data[i,1]<-as.vector(activity_labels[1,2])}
  if (filtered_data[i,1]==2){filtered_data[i,1]<-as.vector(activity_labels[2,2])}
  if (filtered_data[i,1]==3){filtered_data[i,1]<-as.vector(activity_labels[3,2])}
  if (filtered_data[i,1]==4){filtered_data[i,1]<-as.vector(activity_labels[4,2])}
  if (filtered_data[i,1]==5){filtered_data[i,1]<-as.vector(activity_labels[5,2])}
  if (filtered_data[i,1]==6){filtered_data[i,1]<-as.vector(activity_labels[6,2])}
}
##creating a new data set containing the mean for
## all variables for all the users and all the activities
print("Creating new data frame with the mean per user/activity")
act_name<-unique(filtered_data[,1]) ## create avector containing the unique activity name
sub_name<-sort(unique(filtered_data[,2])) ## create a vector containing all the unique subject ID
vc_2<-numeric(dim(filtered_data)[2]) ## create an empty vecor of the same number of observation
## use 2 nested loops to run through all the different combination of user_ID/type of exercise
for (i in 1:length(sub_name)){
  for (j in 1:length(act_name)){
    df_1<-filtered_data[(filtered_data$Activity == act_name[j] & filtered_data$Subject_ID == sub_name[i]),]
    vc_1<-suppressWarnings(rapply(df_1,mean))
    vc_1[1]<-act_name[j]
    vc_2<-rbind(vc_2,vc_1)
  }
}
final_df<- filtered_data[FALSE,] ## duplicate the filtered_data df and remove data
final_df<-as.data.frame(vc_2) ## put the data from the matrix into the data frame
final_df<-final_df[-1,] ## remove the first useless row
rownames(final_df) <- NULL ## remove the row.names column
## cleaning up
rm(list= ls()[!(ls() %in% c('filtered_data','final_df'))])
