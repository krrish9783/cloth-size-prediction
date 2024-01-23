# Load the dataset
data <- read.csv("/home/krishna/Git-Workshop/clsz.csv")

# Display a summary of the dataset
summary(data)

# Display column names
names(data)

# Display the first few rows of the dataset
head(data)

# Print the 5th element of the 'weight' column
print(data$weight[5])

# Create a line plot of the first 50 observations for 'weight' vs 'height'
plot(data$weight[1:50], data$height[1:50], type="l", main="Weight vs Height Dist", xlab="Weight", ylab="Height", col="green")

# Create a histogram for the 'age' column
hist(data$age, main="Histogram", xlab="Values", ylab="Frequency", col="lightblue")

# Print the number of missing values in the dataset
print(sum(is.na(data)))

# Remove rows with missing values
data <- na.omit(data)

# Print the number of missing values after removal
print(sum(is.na(data)))

# Print the number of rows and columns in the cleaned dataset
print(nrow(data))
print(ncol(data))

# Display column names after cleaning
colnames(data)

# Display the first few rows of the cleaned dataset
head(data)

# Print whether there are missing values in the 'age' column
print(is.na(data$age))

# Print summary statistics for the 'age' column
print(max(data$age))
print(min(data$age))
print(median(data$age))

# Create a bar plot for 'weight' and 'age'
 #barplot(cbind(data$weight, data$age), beside=TRUE, col=c("yellow", "red"), main="Bar Plot", xlab="Categories", ylab="Values", names.arg=data$name)

#pie distr

print(unique(data$size))

# EDA NOW .....................................

df <- data.frame(height=data$height,weight=data$weight,age=data$age,size=data$size)
 
head(df)
print(table(df$size))

