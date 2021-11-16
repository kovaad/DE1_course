# CEU Data Engineering 1 Paris team term project
### Created by Ghazal Ayobi, Shah Ali Gardezi, Ádám József Kovács and Abigail Chen

This project was created  for the Data Engineering 2: Different Shapes of Data course of Central European University’s MSc in Business Analytics program. 

# Content of the repository
* [Report of the project](link_to_report)
* [PPT](link_to_ppt)
* [Knime Workflow](link_to_knime_workflow) 
* [Code folder](link_to_codes) - contains the SQL script for creating our Kaggle inequality database and an R script dowloading WDI data
* [Data folder](link_to_data_folder) - in which you can find ...
* [Graphs](link_to_graphs) - which contains all the graphs we created for our project

# Reproducability of the workflow
We made our project reproducable with slight modifications required by the user:

*Steps required for reproduction:*
1. Open Knime Workflow and run File Reader section (saves required files to the users MySQL upload folder (path may need to be changed to users 
2. Open MySQL on users computer and run provided dataloading.sql script
3. Configure MySQL Connector node in Knime with the username and password of the user
4. User needs to have R installed with the Rserve package. The users R root folder location in KNIME should be set like: File>Preferences>KNIME>R>Path to R home
5. To save output images, change "Output Location" for all "Input Nodes" (output images also available [here](link_to_graphs).
6. The workflow can now be run by the user

The overview of the workflow is the following:
![Workflow image](project_workflow_image)

For further details prease read our [report](link_to_report).
