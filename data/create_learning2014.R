# Thordis Ingadottir
# date: 5. Nov. 2020
# Script file for week 2 project in IODS
#
# start by reading in the data into dataframe 'lrn14':
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# the dim() command explores the size/extent/dimensions of the dataframe, in 
# this case the output shows 183 lines and 60 columns (or vice versa, my understanding
# is that there are 60 variables and 183 observations, and that e.g. 'gender' is a 
# variable, thus a column heading although str(lrn14) displays them horizontally).
dim(lrn14)

# we explore the structure of the dataframe (df) by the str(df) command. It shows the 
# varibles and type of data in each, including the first few data entries:
str(lrn14)

# Create an analysis dataset with the variables gender, age, attitude, deep, 
# stra, surf and points by combining questions in the learning2014 data.
# Like in the Datacamp exercises I will name this 'learning2014':
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
# I will need the dplyr library
# access the dplyr library
# woops, I just learned how to install missing packages/libraries by
# install.packages("dplyr")
library(dplyr)

# before I select the columns from lrn14 I must create the missing columns deep,
# stra and surf, just as in Datacamp:
# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Now I am prepared to select the subset of the data:
learning2014 <- select(lrn14, one_of(keep_columns))

dim(learning2014)
str(learning2014)

# I want all column names to be lowercase ;)
colnames(learning2014)[2] = 'age'
colnames(learning2014)[3] = 'attitude'
colnames(learning2014)[7] = 'points'

# now filter out the data entries with Points == 0
# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)
dim(learning2014)
# the dimensions check out right!

# set the working directory
setwd("C:/Users/thi/Documents/IOCDScourse/IODS-project")

# write data to files, try both .csv and write.table (txt?)
write.csv(learning2014, file = "./data/learning2014.csv")
write.table(learning2014, file = "./data/learning2014.txt")

head(learning2014)
str(learning2014)

# try reading and confirm it works:
dummy <- read.csv("./data/learning2014.csv", header = T, sep = ",")
head(dummy)
str(dummy)
# confirmed! All data present. Overwrite and test the table method
dummy <- read.table("./data/learning2014.txt", header = T, sep = " ")
head(dummy)
str(dummy)
# success again!
