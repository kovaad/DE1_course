# CEU Data Engineering 1 Paris team term project
### Created by Ghazal Ayobi, Shah Ali Gardezi, Ádám József Kovács and Abigail Chen

This project was created  for the Data Engineering 2: Different Shapes of Data course of Central European University’s MSc in Business Analytics program. 

# Content of the repository
* [Report of the project](https://github.com/kovaad/DE1_course/blob/main/Term2/Paris_team_term_project2_report.pdf)
* [PPT](https://github.com/kovaad/DE1_course/blob/main/Term2/DE1_Term2_Paris_presentation.pptx)
* [Knime Workflow](https://github.com/kovaad/DE1_course/blob/main/Term2/DE1_Term2_Paris_workflow.knwf) 
* [Code folder](https://github.com/kovaad/DE1_course/tree/main/Term2/code) - contains the SQL scripts for creating the databases
* [Data folder](https://github.com/kovaad/DE1_course/tree/main/Term2/raw_data) - in which you can find our raw csv files
* [Graphs](https://github.com/kovaad/DE1_course/tree/main/Term2/graphs) - which contains all the graphs we created for our project

# Reproducability of the workflow
We made our project reproducable with slight modifications required by the user:

*Steps required for reproduction:*
1. Open Knime Workflow and run File Reader section (saves required files to folder from where MySQL reads in - path needs to be changed to users)
2. Open MySQL on users computer and run provided sql scripts
3. Configure MySQL Connector node in Knime with the username and password of the user
4. To save output images, change “Output Location” for all “Input Nodes”, output images also available [here](https://github.com/ghazalayobi/de1/tree/main/Term2/graph).
5. The workflow can now be run by the user

For further details prease read our [report](https://github.com/kovaad/DE1_course/blob/main/Term2/Paris_team_term_project2_report.pdf).
