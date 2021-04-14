# ---------------------------------------------------------
# Lecture 19
# Randomization tests
# 13 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

#statistical p is prob of obtaining observed results 
#or something more extreme if null hypothesis is true
# null = no effect
#variation caused by measure error or other unspecified sources


#two advantages of randomization test
#relaxes assumptions of usual parametric tests
  #normalist, variance, sample size
# give more intuitive understanding of statistical probability


#---------------------------------------------------------#
#                      Steps in randomization test         
#---------------------------------------------------------#


#1. define X as a single number to represent pattern
#2. calculate X(obs) - x observed. Metric for observed data we start with
#3. Randomize or reshuffle data in a way that uncouples from assignment to treatment groups.
      #randomization should only affect the pattern of treatment effect
      #other aspects are preserved (ex. mean, sample size)
#4. for this randomization, calculate X(sim) - psuedodata. If Null hypothesis is true X(sim) ~=~ X(obs). If Null is false then X(obs) =\= X(sim)
#5. repeat steps 3 and 4 many times (1000 ususally)
#6. Estimate tail probability of observed metirc or something more extreme given Null dist. Prob(X(obs))|H0



#---------------------------------------------------------#
#                      prelims
#---------------------------------------------------------#

library(ggplot2)
library(TeachingDemos)

set.seed(100)
#teaching demos gives us another way to do it

char2seed("croissant with almonds")
#or
char2seed("croissant with almonds", set = FALSE)

#otherwise computer will use this
Sys.time()
  #as a numeric
as.numeric(Sys.time()) #time as total seconds

#for keeping track of seed
mySeed <- as.numeric(Sys.time())
set.seed(mySeed)


#setting for this lecture
char2seed("espresso withdrawal")

#create treatment groups

tmt <- c(rep("control",4), rep("treatment",5))
print(tmt)

#create response variable

z<- c(runif(4)+ 1, runif(5) + 10) 

#combine into data fram

df <- data.frame(tmt = tmt, resp = z)

print(df)


# look at means

obs <- tapply(df$resp, df$tmt, FUN = mean)
print(obs)


#create simulated data set
#set up new dat frame

dfSim <- df

dfSim$resp <- sample(dfSim$resp) #reorders the data 
print(dfSim)

# look at means again in randomized data

obsSim <- tapply(dfSim$resp, dfSim$tmt, mean)
print(obsSim) #smaller treatment effect

#compare this to our actual data

#---------------------------------------------------------#
#                      building functions
#---------------------------------------------------------#


#----------------------------------------------------------
#FUNCTION: readDat
#Description: Read in or generate data set 
#Inputs: file name or nothing (as here)
#Outputs: 3 column data fram of observed data
#----------------------------------------------------------
readDat <- function(z = NULL) {
  if(is.null((z))){
      xVal <- 1:20
      yVal <- xVal +10*rnorm(20)
      df <- data.frame(ID = seq_along(xVal),
                       x = xVal,
                       y = yVal)
  } else
  
  df <- read.table( file = z,
                    header = TRUE,
                    stringsAsFactors = FALSE)
  
  return(df)
  
} #end of readDat
#----------------------------------------------------------

#readDat()


#----------------------------------------------------------
#FUNCTION: getMet
#Description: calculate metric for randomization test
#Inputs: 2 column data frame for regression
#Outputs: regression slope
#----------------------------------------------------------
getMet <- function(z = NULL) {
  if(is.null(z)){
        xVal <- 1:20
        yVal <- xVal +10*rnorm(20)
        z <- data.frame(ID = seq_along(xVal),
                          x = xVal,
                          y = yVal)
  } 
  . <- lm(z[,3]~z[,2])
  . <- summary(.)
  . <- .$coefficients[2,1]
  slope <- .
  
 
  
  return(slope)
  
} #end of getMet
#----------------------------------------------------------

#getMet()


#----------------------------------------------------------
#FUNCTION: shuffleDat
#Description: randomize data for a regression
#Inputs: 3 column data frame (ID, x, y)
#Outputs: 3 column data frame (ID, x, y) - reshuffled
#----------------------------------------------------------
shuffleDat <- function(z = NULL) {
            if(is.null(z)){
                  xVal <- 1:20
                  yVal <- xVal +10*rnorm(20)
                  z <- data.frame(ID = seq_along(xVal),
                                  x = xVal,
                                  y = yVal)} 
  
    z[,3] <- sample(z[,3])
 
  
  return(z)
  
} #end of shuffleDat
#----------------------------------------------------------

#shuffleDat()

#----------------------------------------------------------
#FUNCTION: getP
#Description: obtain p value from simulation
#Inputs: list of observed metric and vector of simulated metrics
#Outputs: upper and lower tail prob value
#----------------------------------------------------------
getP <- function(z = NULL) {
  if(is.null(z)){
    z <- list(rnorm(1), rnorm(1000))}
    
  plower <- mean(z[[2]] <= z[[1]]) # calculated the proportion when simulated value is less than or equal to observed value
  pupper <-  mean(z[[2]] >= z[[1]]) # calculated the prop when sim is greater than or equal to obs
  
  
  
  return(c(pL = plower, pU = pupper))
  
} #end of getP
#----------------------------------------------------------

#getP()

#----------------------------------------------------------
#FUNCTION: plotRan  
#Description: create ggplot of histogram of simulated values  
#Inputs: liat of observed metric and vector of simulated metrics
#Outputs: saved ggplot histogram
#----------------------------------------------------------
plotRan  <- function(z = NULL) {
    if(is.null(z)){
      z<- list(rnorm(1), rnorm(1000))
    }
  df <- data.frame(ID = seq_along(z[[2]]), simX = z[[2]])
  p1 <- ggplot(data = df, mapping = aes(x=simX))+ 
    geom_histogram(mapping = aes(fill = I("goldenrod"),
                                 colour = I("black")))+ 
    geom_vline(aes(xintercept = z[[1]], col = "blue"))
  print(p1)
  
} #end of plotRan 
#----------------------------------------------------------

#plotRan()


###########################################################

nSim <- 1000 # #of data sets to simulate
xSim <- rep(NA,nSim) #set up empty vector for simdata
df <- readDat() #get fake data from our function

xObs <- getMet(df) #get slope of observed data

for(i in seq_len(nSim)){ # loop this 1000 times
  xSim[i] <- getMet(shuffleDat(df)) #create a metric for a shuffled data set
}

slopes <- list(xObs,xSim) # create a list of the two object we created

getP(slopes) # get p values
plotRan(slopes) #plot histogram
