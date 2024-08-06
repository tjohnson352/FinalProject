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