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
paste(nrow(df),ncol(df))
colnames(df)
summary(df)
print(table(df$size))

barplot(table(df$size), main="Number of Occurrences for Each Size", xlab="Size", ylab="Count", col=c("skyblue", "salmon", "palegreen", "orchid", "lightcoral", "cornflowerblue", "lightgoldenrodyellow"))

library(ggplot2)


# Age distr
ggplot(df, aes(x=age)) +
  geom_histogram(binwidth=1, fill="skyblue", color="black", alpha=0.7) +
  labs(title="Age Distribution", x="Age", y="Frequency")


#Weight distr 
output_file <- "weight_distribution_plot.png"
png(output_file, width = 800, height = 600)

ggplot(df, aes(x=weight)) +
  geom_histogram(binwidth=1, fill="skyblue", color="black", alpha=0.7) +
  labs(title="Age Distribution", x="Age", y="Frequency")

dev.off()