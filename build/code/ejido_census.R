# Run all code to create the final dataframe with the fraction of ejidos activated by state and year (1993 to 2007).
# The final dataframe is called ejido_census_dataframe (line 88)

#  install.packages("haven")
#  install.packages("dplyr")
library(haven) #to read .dta file
library(dplyr) #to clean dataset more easily
library(foreign) #to export to Stata .dta format

#Set current working directory to access dataset file
setwd("C:/Users/bmccully/Documents/nafta-migration/build/input/ejido_AER2015/replication_data")

#reads STATA file into R and saves dataset
ejido_census <- read_dta("ejido_census.dta")
#Previews dataset
ejido_census

#Makes list of state names from dataset
state_names <- dimnames(table(ejido_census$ESTADO))
#Displays list of state names from dataset
state_names

#Makes data frame of NAs with a column for state name, certification year, and fraction of ejidos activated in row's specific state/year
# dataframe needs each column to have 31*15 = 465 rows since there are 31 states and each state will have 15 rows (15 year range from 1993 to 2007)
ejido_census_dataframe <- data.frame(state = rep(NA, 31*15), year = rep(NA, 31*15), fraction_activated = rep(NA, 31*15))

#Increases the maximum number of rows printed
options(max.print = 10000)

#The following for loops put the state names from the dataset into the data frame
j <- 1 #Starts row index at 1
for(i in 1:31) { #Repeats cycle 31 times since there are 31 states. i will cycle from 1 to 31.
  for(j in j:(j+14)) { # j is the row of the data frame
                       # Repeats cycle 15 times since the data frame will have sets of 15 rows per state
                       # since the dataset contains a time period of 15 years, from 1993 to 2007.
    ejido_census_dataframe$state[j] <- state_names[[1]][i] #Assigns state name from list of state names to first column of data frame
  }
  j <- (j+1) #increases j by 1 to begin next state's set of 15 rows
}

#Puts years from 1993 to 2007 into the data frame so that each state has a row specific to each year in that range
#Creates vector with years from 1993 to 2007
the_year <- 1993:2007
#Displays vector with years 1993 to 2007, as observed in the original dataset
the_year
b <- 1 # Starts row index at 1
for(i in 1:31) { #Repeats cycle 31 times so that each state has a row for each year in the range of years from 1993 to 2007
  ejido_census_dataframe$year[b:(b+14)] <- the_year[1:15] # Assigns sets of 15 rows of the data frame to the years 1993 to 2007, in the respective "year"
                                                          # column so that each state has a row for each year in the range of years from 1993 to 2007
  b <- (b+15) #Increases b by 15 to begin next state's year assignments
}

# Creates vector of NAs to store total number of ejidos activated in each state
total_ejidos_activated_by_state <- rep(NA, 31)

# Calculates and saves total number of ejidos activated in each state by summing 
# the number of rows that correspond to each state since each row represents one ejido in a specific state
for(i in 1:31) {
  total_ejidos_activated_by_state[i] <- sum(ejido_census$ESTADO == state_names[[1]][i]) # R looks at all the rows of the original dataset and creates a
  # logical vector of TRUEs and FALSEs based on if the row's ESTADO column matches the state name from the list of state names relevant to this specific
  # iteration of the for loop. By summing the vector of TRUEs and FALSEs, R returns the number of rows in the orignal dataset 
}

#Creates vector to store number of ejidos that have been activated by each state by a specific year
number_of_ejidos_activated_by_year_and_state <- rep(NA, 31*15)
#Calculates number of ejidos that have been activated by each state and by a specific year (1993 - 2007)
j <- 1
for(i in 1:31) { #Repeats cycle 31 times, once for each state
  for(k in 1:15){ #Repeats cycle 15 times, once for each year in the range of years from 1993 to 2007
    a <- ejido_census %>% select(ESTADO, PROCEDEYEA) %>% filter(ESTADO == state_names[[1]][i], PROCEDEYEA <= the_year[k]) %>% summarise(n = n()) 
                           # selects columns from original dataset for state and certification year. Filters resulting table
                           # by state name and year, with year varying according to the current iteration of the for loop.
                           # The filter captures all rows of a specific state that represent ejidos that were activated before or in the specified year.
                           # Creates a summary of the number of ejidos that have been activated by year and state.
    number_of_ejidos_activated_by_year_and_state[j] <- a$n
    j <- (j+1) #increases j by 1 to fill next spot in the vector
  }
}

#Creates vector of total number of ejidos activated by state with each value being repeated 15 times. Vector serves as
#denominator when calculating fraction of ejidos activated by state and year.
total_ejidos_activated_by_state_vector <- rep(total_ejidos_activated_by_state, rep(15,31))

#Inputs fraction of activated ejidos by state and year into ejido_census_dataframe by dividing the number of ejidos activated by 
# a specific year/state, by the total number of ejidos activated by a specific state across the original dataset.
for(i in 1:465) {
  ejido_census_dataframe$fraction_activated[i] <- round(number_of_ejidos_activated_by_year_and_state[i] / total_ejidos_activated_by_state_vector[i], digits = 4)
}

#Displays final dataframe that contains the fraction of ejidos activated in each state by the year specified in the row
ejido_census_dataframe

# Extracts fraction of ejidos activated per state based on a specific year. In this case, the year is set to 1993.
ejido_census_dataframe[ejido_census_dataframe$year==1993,]

#Output to Stata .dta format
write.dta(ejido_census_dataframe,"C:/Users/bmccully/Documents/nafta-migration/build/temp/ejido_activation.dta")


