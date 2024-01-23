
# team on building model [kishnu, Aditya  , parnjawal, ritiwik]


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
df <- na.omit(df)

head(df)
print(table(df$size))
paste(nrow(df),ncol(df))
colnames(df)
summary(df)
print(table(df$size))
print(unique(data$size))

#barplot(table(df$size), main="Number of Occurrences for Each Size", xlab="Size", ylab="Count", col=c("skyblue", "salmon", "palegreen", "orchid", "lightcoral", "cornflowerblue", "lightgoldenrodyellow"))

# library(ggplot2)


# Age distr
#ggplot(df, aes(x=age)) +
 # geom_histogram(binwidth=1, fill="skyblue", color="black", alpha=0.7) +
 # labs(title="Age Distribution", x="Age", y="Frequency")


#Weight distr 
#output_file <- "weight_distribution_plot.png"
#png(output_file, width = 800, height = 600)

#ggplot(df, aes(x=weight)) +
 # geom_histogram(binwidth=1, fill="skyblue", color="black", alpha=0.7) +
  #labs(title="Age Distribution", x="Age", y="Frequency")


#dev.off()

#height distr 
#output_file <- "height_distribution_plot.png"
#png(output_file, width = 800, height = 600)

#ggplot(df, aes(x=height)) +
 # geom_histogram(binwidth=1, fill="skyblue", color="black", alpha=0.7) +
  #labs(title="Age Distribution", x="Age", y="Frequency")
#dev.off()
         
         #outliers analysis  before removing
library(ggplot2)
         ggplot(df, aes(x = NULL, y = weight)) +
  geom_boxplot() +
  ggtitle("Boxplot for height")



head(df)
print(nrow(df))

# Define the corrected outlier handling function
remove_outliers_inplace <- function(x) {
  q <- quantile(x, probs = c(0.25, 0.75), na.rm = TRUE)
  iqr <- IQR(x, na.rm = TRUE)
  lower_bound <- q[1] - 1.5 * iqr
  upper_bound <- q[2] + 1.5 * iqr

  # Keep outlier values but mark them as NA
  x[x < lower_bound | x > upper_bound] <- NA

  # Return the modified vector with the same length
  return(x)
}

# Load your data (assuming it's stored in a variable called 'data')
df <- data.frame(height = data$height, weight = data$weight, age = data$age, size = data$size)

# Remove NA values (original code)
df <- na.omit(df)

# Modify outlier values in place for each numerical column
df$weight <- remove_outliers_inplace(df$weight)

df$height <- remove_outliers_inplace(df$height)
# No outliers removal for the 'size' column

# Proceed with your further analysis using the modified df data frame

# outliers after removing 
     ggplot(df, aes(x = NULL, y = height)) +
  geom_boxplot() +
  ggtitle("Boxplot for height")

print(sum(is.na(df)))
    
    #filling the null values  with its median
 
df$age <- ifelse(is.na(df$age), median(df$age, na.rm = TRUE), df$age)
df$height <- ifelse(is.na(df$height), median(df$height, na.rm = TRUE), df$height)
df$weight <- ifelse(is.na(df$weight), median(df$weight, na.rm = TRUE), df$weight)

print(sum(is.na(df)))
print(min(df$age))

df$age <- pmin(pmax(df$age, 1), 100)

summary(df$age)

print(min(df$age))

cor_matrix <- cor(df[c("age", "height", "weight")])

print(cor_matrix)
 
  # visulaize corr

library(reshape2)

ggplot(data = melt(cor_matrix), aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = 0, midpoint = 0, limit = c(-1,1), space = "Lab") +
  theme_minimal() +
  labs(title = "Correlation Matrix")

# mapping interger value to the sizes 
print(table(unique(df$size)))

library(dplyr)

# Mapping clothes size from strings to numeric
df <- df %>%
  mutate(size = case_when(
    size == "XXS" ~ 1,
    size == "S"   ~ 2,
    size == "M"   ~ 3,
    size == "L"   ~ 4,
    size == "XL"  ~ 5,
    size == "XXL" ~ 6,
    size == "XXXL" ~ 7,
    TRUE ~ NA_integer_  # Handles other cases not listed
  ))

  print(unique(df$size))

  head(df)
               #feature engineering 
  df$bmi <- df$weight / ((df$height / 100)^2)
df$weight_squared <- df$weight^2

head(df)

# df
colnames(df)


cor_matrix <- cor(df
)

# Plotting the heatmap with annotations
heatmap(cor_matrix,
        main = "Correlation Matrix",
        xlab = "Variables",
        ylab = "Variables",
        col = colorRampPalette(c("blue", "black", "red"))(50),
        symm = TRUE,  # To ensure the heatmap is symmetric
        margins = c(5, 5),
        keep.dendro = FALSE,  # If you want to keep the hierarchical clustering dendrogram
        cexRow = 0.75,
        cexCol = 0.75
)

# Overlaying the correlation values
text(1:ncol(cor_matrix), 1:nrow(cor_matrix), round(cor_matrix, 2), cex = 0.8, pos = 4, col = "black", srt = 45)


head(df)

file_path <- "/home/krishna/Documents/Cleanfinal1.csv"

# Save the data frame as a CSV file
write.csv(df, file = file_path, row.names = FALSE)

# Print a message indicating successful saving
cat("Data frame saved as CSV:", file_path, "\n")

           
            

