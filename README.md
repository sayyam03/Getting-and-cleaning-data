# Getting-and-cleaning-data
Final project from course 3
First the script recognizes if the person running the program has the dataset or not.
Then it downloads and unzips it in the current directory.
The script then reads features, activities for labeling
Following this, the script reads through the features for mean and sd variables only.
Then we load the dataset, merge it and turn variables into factors, and label the dataset, before melting it and creating the required text file.

Subjects- is the subject id variable for the subject carrying out the activity

activity- it is one of 6 activities
Walking, Walking-upstairs, Walking- downstairs, Standing, Sitiing and laying   
