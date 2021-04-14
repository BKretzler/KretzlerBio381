########################################
# Bailey M Kretzler
# Lecture 14
# 03232021
# Bio 381 - Computational Biology
# Sample program to demonstrate
# programming with functions
########################################
#------------------------------------------
#                Source
#------------------------------------------
# this says run the code from here first
# allows us to build up a library of functions
source("my_functions.R")

# should still write program specific functions in the script
# then source old relevant programs


###########################################
#------------------------------------------
#               Preliminaries
#------------------------------------------
library(ggplot2)
library(tidyr)

##set.seed()

###########################################
#------------------------------------------
#           Global Variables
#------------------------------------------
antFile <- "antcountydata.csv"

xCol<- 7 #latitudinal center of each county 
yCol<- 5 #number of recorded ant species

###########################################
#------------------------------------------
#           Run Program
#------------------------------------------

#construct data frame
temp1 <- get_data(fileName = antFile)

#set up x and y variables
x <- temp1[,xCol]
y <- temp1[,yCol]
 
#calculate stuff
temp2 <- calc_stuff(xvar = x, yvar = y)
 
#extract residuals
temp3 <- summarise_out(temp2)
 
#graph the stuff

graph_results(xvar = x, yvar = y) #probably need something for label names too

print(temp3)
print(temp1)
print(temp2)


afun <- function(x=5) {
  z<- x + runif(1)
  return(z)
}
afun()


#---------------------------------------------------------#
#------------------testing snippets-----------------------#
#---------------------------------------------------------#




###########################################################

# Section 1---------------------------------------

# ------------------Section 2---------------------

# #-------------------------------------------------------#

# ---------------------------------------------------------
# Lecture 15
# 25 Mar 2021
# Bailey M Kretzler
# ---------------------------------------------------------

###########################################################

#-------------------------------------------------------#

# ------------------section label---------------------

#                      section label  

#----------------------------------------------------------
#FUNCTION: funA
#Description: practice function
#Inputs: A, b, x
#Outputs: g
#----------------------------------------------------------
funA <- function(x = 5, b = 7, A = x^b) {

  g = x + b + A
  
  return(g)
  
} #end of funA
#----------------------------------------------------------

funA()

#----------------------------------------------------------
#FUNCTION: funB
#Description: testing
#Inputs: none
#Outputs: text
#----------------------------------------------------------
funB <- function(x = 5) {

  #function body
  
  return("checking.... funB")
  
} #end of funB
#----------------------------------------------------------

funB()



#---------------------------------------------------------#
#                      this is my section                 #    
#---------------------------------------------------------#
