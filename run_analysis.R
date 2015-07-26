
#Reading files
xtr <- read.table("./X_train.txt")
xt <- read.table("./X_test.txt")
st <- read.table("./subject_test.txt")
str <- read.table("./subject_train.txt")
yt <- read.table("./Y_test.txt")
ytr <- read.table("./Y_train.txt")
ft <- read.table("./features.txt")



#Data Combination

#Activity Combination
ycd <- rbind(yt,ytr)
#Subject Combination
scd <- rbind(st,str)
#Adding Activity and Subjects Columns
tcd <- cbind(ycd,cd)
tcd <- cbind(scd,tcd)
#Nombrar todas las columnas
for (i in 1:561)
{
  names(tcd)[i+2] <- as.character(ft[i+2,2])
  
}
names(tcd)[1] <- "Subject"
names(tcd)[2] <- "Activity"

##Eliminate duplicates
tcdu <- tcd[ , !duplicated(colnames(tcd))]
##Contains std() and mean()
tcdufstd <- select(tcdu,contains("std()"))
tcduf <- select(tcdu,contains("mean()"))
tcd <- cbind(tcduf,tcdufstd)
tcd <- cbind(ycd,tcd)
tcd <- cbind(scd,tcd)
names(tcd)[1] <- "Subject"
names(tcd)[2] <- "Activity"
#Grouping By
tcd <- group_by(tcd,Subject,Activity)
#Summarizing Average
tidyWideds <- summarise_each(tcd,funs(mean))
#Naming Activities
tidyWideds[tidyWideds$Activity == 1, 2]  <-  "WALKING"
tidyWideds[tidyWideds$Activity == 2, 2]  <-  "WALKING_UPSTAIRS"
tidyWideds[tidyWideds$Activity == 3, 2]  <-  "WALKING_DOWNSTAIRS"
tidyWideds[tidyWideds$Activity == 4, 2]  <-  "SITTING"
tidyWideds[tidyWideds$Activity == 5, 2]  <-  "STANDING"
tidyWideds[tidyWideds$Activity == 6, 2]  <-  "LAYING"
#WritingOutput
write.table(tidyWideds,"./tidyOutput.txt", row.names=FALSE)
