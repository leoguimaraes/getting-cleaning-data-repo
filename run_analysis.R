require(dplyr)

xtest <- read.table("dataset/test/X_test.txt")
ytest <- read.table("dataset/test/Y_test.txt")
xtrain <- read.table("dataset/train/X_train.txt")
ytrain <- read.table("dataset/train/Y_train.txt")
subtest <- read.table("dataset/test/subject_test.txt")
subtrain <- read.table("dataset/train/subject_train.txt")
featureNames <- read.table("dataset/features.txt")
names(xtrain) <- featureNames$V2
names(xtest) <- featureNames$V2

names(ytest) <- c("Activity")
names(ytrain) <- c("Activity")
names(subtest) <- c("IDSubject")
names(subtrain) <- c("IDSubject")


xysubtest <- cbind(xtest, ytest, subtest)
xysubtrain <- cbind(xtrain, ytrain, subtrain)
xysubtraintest <- rbind(xysubtest, xysubtrain)

onlystdmean <- xysubtraintest[,grep("std|mean|Activity|IDSubject", names(xysubtraintest))]

onlystdmean$Activity_Desc <- activitynames[match(onlystdmean$Activity, activitynames$Activity_ID), 2]

tidydata <- aggregate(onlystdmean, by=list(activityid = onlystdmean$Activity, activitydesc = onlystdmean$Activity_Desc, subject=onlystdmean$IDSubject), mean)

write.table(tidydata, "tidydata.txt")