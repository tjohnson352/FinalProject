Human Activity Recognition Using Smartphones Dataset Analysis

Script Overview

\---------------

The script processes the Human Activity Recognition Using Smartphones Dataset by merging the training and test datasets, labeling the activities, and creating a tidy dataset with the average of each variable for each activity and each subject. Finally, it exports this tidy dataset to a text file.

The script begins by loading the required \`dplyr\` and \`tidyr\` libraries, installing them if they are not already available. It sets the working directory and defines paths for the train and test datasets. The script then reads the data from the specified paths and merges the training and test datasets into a single data frame. While combining the datasets, a new column \`source\` is added to distinguish between the test and train data. Descriptive column names are assigned to the combined data, ensuring that the first two columns (\`subject\` and \`feature\`) are text, while the rest are numeric.

Next, the script reads the activity labels and updates the \`activity\` column in the combined data with descriptive activity names. It then calculates the mean and standard deviation for the \`feature\` column by \`source\` (train or test). The mean for each variable by \`subject\` and \`activity\` is also calculated. The script pivots the summarized data to create a tidy dataset with columns \`subject\`, \`activity\`, and \`mean\`. Finally, the tidy dataset is exported to \`tidy\_data.txt\`, and the tidy dataset, the summary of means, and the combined data are displayed for verification.

Output Explanation

\------------------

View(tidy\_data)

Displays the tidy dataset with columns \`subject\`, \`activity\`, \`variable\`, and \`mean\`. Each row represents the mean value of a variable for a specific subject and activity.

View(summary\_means)

Displays the summarized means for each variable by subject and activity. Each row represents the mean values of all variables for a specific subject and activity.

View(combined\_data)

Displays the combined dataset with subject, activity, and measurement variables, along with the data source (\`train\` or \`test\`).

CodeBook

\--------

Variables in \`tidy\_data.txt\`

1\. subject: Identifier of the subject who performed the activity (integer).

2\. activity: Descriptive activity name (factor with levels: \`WALKING\`, \`WALKING\_UPSTAIRS\`, \`WALKING\_DOWNSTAIRS\`, \`SITTING\`, \`STANDING\`, \`LAYING\`).

3\. variable: The measurement variable for which the mean is calculated (e.g., \`mean\_body\_acc\_x\`).

4\. mean: The mean value of the variable for the specific subject and activity (numeric).

5\. source: Specifies whether the measurement was from the train or test set (factor with levels: \`train\`, \`test\`).

Measurement Variables

1\. body\_acc\_x: Body acceleration in the X direction (numeric).

2\. body\_acc\_y: Body acceleration in the Y direction (numeric).

3\. body\_acc\_z: Body acceleration in the Z direction (numeric).

4\. body\_gyro\_x: Body gyroscope in the X direction (numeric).

5\. body\_gyro\_y: Body gyroscope in the Y direction (numeric).

6\. body\_gyro\_z: Body gyroscope in the Z direction (numeric).

7\. total\_acc\_x: Total acceleration in the X direction (numeric).

8\. total\_acc\_y: Total acceleration in the Y direction (numeric).

9\. total\_acc\_z: Total acceleration in the Z direction (numeric).

10\. feature: A variable processed from the other 9 variables to summarize their means and standard deviations.

Reference

\-------

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012\.

