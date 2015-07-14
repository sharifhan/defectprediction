
# Clear cache and environments
rm(list = ls())

# Read input from the file directory
# NOTE: Change the file path according to your computer
cardata <- read.csv("C:/Users/sharifhan/Desktop/inlinemarket-ds-task.csv", quote="\"", stringsAsFactors=FALSE)

task3output <- data.frame(Brand = character(), Share = character(), stringsAsFactors = FALSE)

# Total no. of mentions of brands among their top 3 mentions
total_mentions <- length(which(cardata[,4:6]!=""))

# Total no. of brands in ascending order
brands <- sort(unique(rapply(cardata[,4:6], function(x) unique(x))))
brands <- data.frame(brands[!(brands=="")])

# Calculate no. of times each brand is mentioned within top 3
for (j in 1:nrow(brands))
{
  brand <- sprintf("%s", brands[j,])
  
  # Total no. of specific brand mentioned in top 3 in the survey
  brand_share <- length(which(cardata[,4:6] == brand))
  
  # The share of respondents which mentioned a particular brand 
  # among their top 3 mentions is found by calculating the total
  # no. of occurance this specific brand is mentioned in the first three mentions  
  #       
  
  # lineitem <- sprintf("Log: Brand=%s, Share=%s", brand, brand_share)
  # print(lineitem)
  
  # Generate line item
  task3output[nrow(task3output) + 1, ] <- c(brand, brand_share)  
  
  
}

# Print the list of brand share in ascending order
print(task3output)

# Save as CSV file to disk
write.csv(task3output, file = "C:/Users/sharifhan/Desktop/task3output.csv", quote=FALSE, row.names=FALSE)

# Task 3 complete

