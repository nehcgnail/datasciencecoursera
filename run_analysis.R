### this is R solution for Getting and Cleaning Data assignment 

## read data

subject_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
names(x_test) <- features[,2]
names(x_train) <- features[,2]


## extracts mean and std.

mstd <- grepl("mean\\(\\)|std\\(\\)", features[,2])
x_test.mstd <- x_test[, mstd]
x_train.mstd <- x_train[, mstd]


## merging

sub <- rbind(subject_test, subject_train)
x <- rbind(x_test.mstd, x_train.mstd)
y <- rbind(y_test, y_train)
df <- cbind(sub, y, x)


## subset & aggregate 

names(df)[1] <- "subID"
names(df)[2] <- "act"
df.aggr <- aggregate(. ~ subID + act, data=df, FUN = mean)


## generate table

write.table(df.aggr, "tidytable.txt")

