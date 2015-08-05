setwd('C:\\Users\\hliu\\Documents\\R_study\\cleaning data\\project\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset')
home = getwd()

activity = read.table('./activity_labels.txt')
features= read.table('./features.txt')

subject_train = read.table('./train/subject_train.txt')
x_train = read.table('./train/x_train.txt')
y_train = read.table('./train/y_train.txt')


subject_train = rename(subject_train, subject = V1)
colnames(x_train) = features[, 2]
colnames(y_train) = 'activityID'
colnames(activity) = c('activityID', 'activityType')

join_y = merge(y_train, activity, by = 'activityID')
train_set = cbind(subject_train, x_train, join_y)

subject_test = read.table('./test/subject_test.txt')
x_test = read.table('./test/x_test.txt')
y_test = read.table('./test/y_test.txt')


subject_test = rename(subject_test, subject = V1)
colnames(x_test) = features[, 2]
colnames(y_test) = 'activityID'

test_y = merge(y_test, activity, by = 'activityID')
test_set = cbind(subject_test, x_test, test_y)

data_set = rbind(train_set, test_set)


judge = (grepl('activity..', names(data_set)) | 
           grepl('subject', names(data_set)) | 
           grepl('-mean..', names(data_set)) & !grepl('-meanFreq..', names(data_set)) & !grepl('-mean..-', names(data_set))| 
           grepl('-std..', names(data_set)) & !grepl('-std..-', names(data_set))
         )

sub_set = data_set[judge == TRUE]

colNames = names(sub_set)
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};
names(sub_set) = colNames



data_melt = melt(sub_set, id=c('subject', 'activityType'), measure.vars=colNames[2:19])
data_subject = dcast(data_melt, subject ~ variable, mean)
data_activity = dcast(data_melt, activityType ~ variable, mean)
