---
title: "README"
author: "Mark Edney"
date: "19/09/2020"
output: pdf_document
---


## R Code
The run_analysis code follows this procedure:

1. Load the dplyr packages
```{r}
library(dplyr)
```
2. Load the different datafiles into the system as dataframes
3. Merge the train and test dataframes together
4. Load the featurelist and activity labels into the system as dataframes
5. Merge the activity list for the train and test data
6. Sort the merged data from for varialbes that only include std and mean
7. Change the variables of the merged data with the featurelist df
8. Amends the activity date to the merged data with mutate and changes
the activity to the describition with the activity label df
9. Amends the subject data to the merged df
10. Creates a second df grouped by activity and then by subject
11. Summarise the second df with the summarise_all by mean



