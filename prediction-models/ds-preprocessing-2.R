
# NOTE: Rows with missing values of gender are excluded

# Clear cache and environments
rm(list = ls())

# Read input from the file directory
# NOTE: Change the file path according to your computer
cardata <- read.csv("C:/Users/sharifhan/Desktop/inlinemarket-ds-task.csv", quote="\"", stringsAsFactors=FALSE)
cardata<-cardata[!(cardata$gender==""),]
rownames(cardata) <- NULL

# Total no. of mentioned brands by male
total_males <- length(which(cardata$gender == "Male")) 

# Total no. of mentioned brands by female
total_females <- length(which(cardata$gender == "Female"))

# Total no. of males in the survey
total_male_brands <- length(which(cardata$gender == "Male" & cardata[,4:13] != ""))

# Total no. of females in the survey
total_female_brands <- length(which(cardata$gender == "Female" & cardata[,4:13] != ""))


# The average number of mentioned brands by gender is calculated as follows:
#   
#   average no. of mentioned brands by males = (Total no. of mentioned brands by male / Total no. of males in the survey)
#   
#   average no. of mentioned brands by females = (Total no. of mentioned brands by female / Total no. of females in the survey)


# Average no. of mentioned brands by males (in nearest integer)
ave_brands_male <- round(total_male_brands / total_males, digits = 0)

# Average no. of mentioned brands by females (in nearest integer)
ave_brands_female <- round(total_female_brands / total_females, digits = 0)


# Generate result in the console panel

result <- sprintf("Average no. of mentioned brands by male is %s. And, average no. of mentioned brands by female is %s.", ave_brands_male, ave_brands_female)

print(result)

write(result, file = "C:/Users/sharifhan/Desktop/task2output.txt")

# Task 2 complete


