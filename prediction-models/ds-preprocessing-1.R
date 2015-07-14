
# NOTE: Rows with missing values of gender or age are excluded

# Clear cache and environments
rm(list = ls())

# Read input from the file directory
# NOTE: Change the file path according to your computer
cardata <- read.csv("C:/Users/sharifhan/Desktop/inlinemarket-ds-task.csv", quote="\"", stringsAsFactors=FALSE)

# Data preprocessing: removing null or missing values from age and gender
cardata$age <- sapply(cardata$age, as.character)
cardata$respondent_id <- sapply(cardata$respondent_id, as.character)
cardata<-cardata[!(cardata$gender==""),]
cardata<-na.omit(cardata)
rownames(cardata) <- NULL

# Output data structure for printing the final result
task1output <- data.frame(respondent_id = character(), gender = character(), age = character(), brand = character(), position = character(), stringsAsFactors = FALSE)

# Data processing

brands <- sort(unique(rapply(cardata[,4:13], function(x) unique(x))))

brands <- data.frame(brands[!(brands=="")], stringsAsFactors = FALSE)

for (i in 1:nrow(cardata))
  
{
  
  id <- cardata[i,1]
  gender <- cardata[i,2]
  age <- cardata[i,3]
  
  carmentions <- cardata[i,4:ncol(cardata[i,])]
  carmentions <- data.frame(carmentions[!(carmentions=="")], stringsAsFactors = FALSE)
  
  for (j in 1:nrow(brands))
    
  {     
    
    brand <- brands[j,]
    position <- "not mentioned"
    
    for (k in 1:nrow(carmentions))
      
    {       
      
      carmention <- carmentions[k,]      
      
      if(grepl(brand, carmention)){
        
        position <- k
        
      }
      
      
    }
    
    newrow <- sprintf("Log: id=%s, gender=%s, age=%s, brand=%s, position=%s", id, gender, age, brand, position)
    print(newrow)
    
    # Generate line item
    task1output[nrow(task1output) + 1, ] <- c(id, gender, age, brand, position)    
  }
  
} 

# Save as CSV file to disk
write.csv(task1output, file = "C:/Users/sharifhan/Desktop/task1output.csv", quote=FALSE, row.names=FALSE)

# Task 1 complete
