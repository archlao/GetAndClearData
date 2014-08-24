This Repo contains:
- This Readme file
- run_analysis -> script that creates SensorMean.txt
- SensorMean.txt -> Summary file with average mensuraments form subjects that did activities wearing sensors in their body 
- Codebook -> description of SensorMean Variables


First Step:

you need to download the file from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After you have the zip file on you computer, you will need to unzip it to a folder call "Samsung" on your working directory (WD) on R.
Put run_analysis.R in your WD and run on you R Console:
> source("run_analysis.R")

this will create a file called SensorMean.txt on you WD.

The run_analysis.R does this following steps:

- load files test form Samsung Directory.
	- Variable names
	- test subjects measurements file (X_test)
	- test subjects Activity file (Y_test)
	- test subjects IDs file (subject_test)
- put name on columns

- load files Train form Samsung Directory.
	- Train subjects measurements file (X_test)
	- Train subjects Activity file (Y_test)
	- Train subjects IDs file (subject_test)
- put name on columns
- merge dataframes (test and train)
- select only measurements on the mean and standard deviation to a data frame called DataSel, using function "grep"
	this is done by listing id of variables that contains "mean" and std on their names.
	we insert important id´s variables (subject and activity) that will be important when creating summary file.
	as matter we put variables in order so we can study variables in blocks.
- put activity description using merge.
	to do it we need to make sure ID´s are form the same format and that they have the same name.
- drop unnecessary variables (those with "meanFreq" name) using outFreq list
- create a summary data frame using aggregate function
	it is necessary to let only numeric variables to be aggregated, that why we need to drop variables (1,2,82)
- save the final file using write.table as requested


If you have any problem during this procedure, send me a message using GITHub.

Tks
