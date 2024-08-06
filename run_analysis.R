source("C:/Users/tjohn/Desktop/wd/scripts/clearall.R")
clearall()

# Load required libraries
if (!requireNamespace("dplyr", quietly = TRUE)) install.packages("dplyr")
if (!requireNamespace("tidyr", quietly = TRUE)) install.packages("tidyr")
library(dplyr)
library(tidyr)

dir2 <- "C:/Users/tjohn/Desktop/wd/Final/data/test"
dir3 <- "C:/Users/tjohn/Desktop/wd/Final/data/test/Inertial_Signals"
dir4 <- "C:/Users/tjohn/Desktop/wd/Final/data/train"
dir5 <- "C:/Users/tjohn/Desktop/wd/Final/data/train/Inertial_Signals"

# List all text files in the directories
test_list1 <- list.files(path = dir2, pattern = "*.txt", full.names = TRUE)
test_list2 <- list.files(path = dir3, pattern = "*.txt", full.names = TRUE)
train_list1 <- list.files(path = dir4, pattern = "*.txt", full.names = TRUE)
train_list2 <- list.files(path = dir5, pattern = "*.txt", full.names = TRUE)

test_list <- c(test_list1, test_list2)
train_list <- c(train_list1, train_list2)

test_list_df <- data.frame(Files = test_list)
train_list_df <- data.frame(Files = train_list)

# Extract file names without the extension from the test list and create a data frame
test_colnames_df <- data.frame(test_colnames = sapply(test_list_df$Files, function(x) tools::file_path_sans_ext(basename(x))))

# Extract file names without the extension from the train list and create a data frame
train_colnames_df <- data.frame(train_colnames = sapply(train_list_df$Files, function(x) tools::file_path_sans_ext(basename(x))))

# Initialize an empty data frame for the test data
test_data <- data.frame()

# Loop through each file in the test list, read the data, and add it as a new column
for (i in 1:length(test_list)) {
  # Read data from the current file. Assuming each file contains a single column of numeric data.
  file_data <- read.table(test_list[i], header = FALSE, colClasses = "numeric", fill = TRUE, strip.white = TRUE)
  
  # Extract the column
  single_column <- file_data$V1
  
  # Check if the data frame is empty and initialize it if it is
  if (ncol(test_data) == 0) {
    test_data <- data.frame(single_column)
    colnames(test_data) <- as.character(test_colnames_df$test_colnames[i])
  } else {
    # Add the data as a new column in the test data frame
    # Column name is taken from test_colnames_df
    test_data[[as.character(test_colnames_df$test_colnames[i])]] <- single_column
  }
}
# Initialize an empty data frame for the train data
train_data <- data.frame()

# Loop through each file in the train list, read the data, and add it as a new column
for (i in 1:length(train_list)) {
  # Read data from the current file.
  file_data <- read.table(train_list[i], header = FALSE, colClasses = "numeric", fill = TRUE, strip.white = TRUE)
  
  # Extract the column (assuming single-column data files)
  single_column <- file_data$V1
  
  # Check if the data frame is empty and initialize it if it is
  if (ncol(train_data) == 0) {
    train_data <- data.frame(single_column)
    colnames(train_data) <- as.character(train_colnames_df$train_colnames[i])
  } else {
    # Add the data as a new column in the train data frame
    # Column name is taken from train_colnames_df
    train_data[[as.character(train_colnames_df$train_colnames[i])]] <- single_column
  }
}

# Specify the path for the activity labels file
labels_path <- "C:/Users/tjohn/Desktop/wd/Final/data/activity_labels.txt"

# Rename columns in both data frames
new_column_names <- c("subject", "feature", "activity", 
                      "body_acc_x", "body_acc_y", "body_acc_z", 
                      "body_gyro_x", "body_gyro_y", "body_gyro_z", 
                      "total_acc_x", "total_acc_y", "total_acc_z")

colnames(train_data) <- new_column_names
colnames(test_data) <- new_column_names


# Ensure the first two columns are text labels
train_data[, 1] <- as.character(train_data[, 1])
train_data[, 3] <- as.character(train_data[, 3])

test_data[, 1] <- as.character(test_data[, 1])
test_data[, 3] <- as.character(test_data[, 3])

# Ensure all other columns are numeric
train_data[, -c(1, 3)] <- lapply(train_data[, -c(1, 3)], as.numeric)
test_data[, -c(1, 3)] <- lapply(test_data[, -c(1, 3)], as.numeric)

# Add a new column to identify the data source
train_data$source <- "train"
test_data$source <- "test"

# Combine the data frames
combined_data <- rbind(train_data, test_data)

# Reorder columns 
combined_data <- combined_data %>% select(1, 13, 3, 2, everything())


# Read the file into a dataframe
labels_df <- read.table(labels_path, header = FALSE, col.names = c("ID", "Activity"))

# Update the activity column in combined_data using labels_df
combined_data$activity <- factor(combined_data$activity, levels = labels_df$ID, labels = labels_df$Activity)

# Summarize mean and standard deviation for the feature column by source
summary_feature <- combined_data %>%
  group_by(source) %>%
  summarise(mean_feature = mean(as.numeric(feature), na.rm = TRUE),
            sd_feature = sd(as.numeric(feature), na.rm = TRUE))

# Summarize mean for each variable by subject and activity
summary_means <- combined_data %>%
  group_by(subject, activity) %>%
  summarise(across(feature:total_acc_z, mean, .names = "mean_{col}"))

# Pivot longer to create tidy data with columns: subject, activity, mean
tidy_data <- summary_means %>%
  pivot_longer(cols = starts_with("mean_"), names_to = "variable", values_to = "mean") %>%
  select(subject, activity, variable, mean)

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
View(tidy_data)
View(summary_means)
View(combined_data)