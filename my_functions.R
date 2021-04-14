########################################
# Bailey M Kretzler
# Lecture 14
# 03232021
# Bio 381 - Computational Biology
# Seperate file for just the functions
# we might want to use in ANY of our code
########################################
require(ggplot2)
########################################
#---------------------------------------
#             FUNCTIONS
#---------------------------------------
###########################################
# FUNCTION: get_data
# read in .csv file
# input: .csv file
# output: data frame
#------------------------------------------

get_data <- function(fileName = NULL){
  if(is.null(fileName)){
    df <- data.frame(ID = 101:110,
                     varA = runif(10),
                     varB = runif(10))
  } else {
    df <- read.table(file = fileName, 
                     header = TRUE, 
                     sep = ",",
                     comment = "#")
  }
  return(df)
}

###########################################
# FUNCTION: calc_stuff
# fit an ordinary least squares regression
# input: x and y vector of numerics of same lenght
# output: entire summary of regression model
#------------------------------------------

calc_stuff <- function(xvar = runif(10),
                       yvar = runif(10)){
  df <- data.frame(xvar,yvar)
  mod <- lm(yvar~xvar)
  return(summary(mod))
}



###########################################
# FUNCTION: summarise_out
# pull some elements from the model summary list
# input: list from summary of model
# output: vector of residuals
#------------------------------------------

summarise_out <- function(z=NULL){
  if(is.null(z)){
    x <- runif(10)
    y <- runif(10)
    z <- summary(lm(y~x))
  }
  return(z$residuals)
}


###########################################
# FUNCTION: graph_results
# one line description
# input: x
# output: x
#------------------------------------------

graph_results <- function(xvar = runif(10),
                          yvar = runif(10)){
  df <- data.frame(xvar,yvar)
  pl <- ggplot2::ggplot(data = df, aes(x = xvar, y = yvar)) + 
    geom_point() + 
    stat_smooth(method = "lm") + 
    theme_bw() #end of plot
  suppressMessages(print(pl)) # SUPRESS SMOOTH MESSAGE
  #message("Regression Graph Created")
}

#pl <- ggplot2::qplot(data = df,
#x = xvar,
#y = yvar,
#geom = c("smooth", "point"))

###########################################