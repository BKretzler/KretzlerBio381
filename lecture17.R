# ---------------------------------------------------------
# Lecture 17
# Control Structure II - for loops  
# 01 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

#for(var in seq){ #start of loop

#r code 
#maybe some calls to functions

#}
# var = variable
# seq = sequence


#bad example

myDogs <- c("shi_tzu", "aus_shep", "golden", "golden", "shi_tzu")


for(i in myDogs){
  print(i)
}


#better way

for (i in 1:length(myDogs)) {
  #print(myDogs[i])
  cat("i=",i,"myDogs[i]=", myDogs[i], "\n")
}


#using seq_along

for (i in seq_along(myDogs)) {
  cat("i=",i,"myDogs[i]=", myDogs[i], "\n")
}

#this works with NULL/empty vectors
myDogs2 <- NULL
for (i in seq_along(myDogs2)) {
  cat("i=",i,"myDogs2[i]=", myDogs2[i], "\n")
}



#tip #1 : do not change object dimesions in a loop
    #avoid cbind(),rbind(),c(), and list()

myDat <- runif(1)

for (i in 2:10) {
  temp<- runif(1)
  myDat<- c(myDat,temp)
  cat("loop #", i,"vector element:",myDat[i],"\n")
  
}
print(myDat)

#tip 2: do not do things in a loop if you don't need to 

for(i in 1:length(myDogs)){
  myDogs[i] <- toupper(myDogs[i])
  cat("i = ", i, "myDogs[i]=", myDogs[i],"\n")
}

z <- c("dog","cat","rat")

toupper(z)


#tip 3: do not use a loop if you can vectorize!


for(i in seq_along(myDat)){
  myDat[i] <- myDat[i] + myDat[i]^2
  cat("myDat:", myDat[i],"\n")
}


z <- 1:10

z<- z+z^2

print(z)

#tip 4 know the diff between i and z[i]

#tip5 use next to skip certain elements

z<- 1:20
for(i in seq_along(z)){
  if(i%%2 == 0) next
  print(i)
}

#another method -> maybe faster
z <- 1:20
zSub<-z[z%%2!=0]
print(zSub)




#---------------------------------------------------------#
#----------------------------------------------------------
#FUNCTION: ranWalk
#Description: stochastic random walk
#Inputs: times = number of time steps
#        n1 = initial pop size
#        lambda = finite rate of increase   
#        noiseSD = stand dev or norm dist with mean 0
#Outputs: vector n with pop size > 0 continuing until extinction
#----------------------------------------------------------
library(tcltk)
library(ggplot2)
ranWalk <- function(times = 100, 
                    n1 = 50,
                    lambda = 1.0,
                    noiseSD = 10) {
  n<- rep(NA, times) # creating out put vector
  n[1]<-n1
  noise<-rnorm(n = times, mean = 0, sd = noiseSD)
  
  for(i in 1:(times-1)){#start of the for loop
    n[i+1]<-n[i]*lambda+noise[i]
    if(n[i+1]<=0){ #start of if
      n[i+1] <-NA
      cat("Population extinct at time",i, "\n")
      tkbell()
      break
    }
  }
  return(n)
} #end of ranWalk
#----------------------------------------------------------


ranWalk()

# ---------------------------------------------------------
# Lecture 18
# Control structures 3
# 06 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

pop <- ranWalk()
qplot(x = 1:100, y = pop, geom = "line")


#check out perfomance with no noise
pop <- ranWalk(noiseSD = 0)
qplot(x = 1:100, y = pop, geom = "line") # we get a straight line
  # population just replaces itself

pop <- ranWalk(noiseSD = 0, lambda = 1.1)
qplot(x = 1:100, y = pop, geom = "line") #exponential curve


pop <- ranWalk(noiseSD = 0, lambda = 0.9)
qplot(x = 1:100, y = pop, geom = "line")

pop <- ranWalk(noiseSD = 0.1, lambda = 0.9)
qplot(x = 1:100, y = pop, geom = "line")

pop <- ranWalk(noiseSD = 1, lambda = 0.9)
qplot(x = 1:100, y = pop, geom = "line")

pop <- ranWalk(noiseSD = 5, lambda = 0.98)
qplot(x = 1:100, y = pop, geom = "line")

#---------------------------------------------------------#
#                      double forloops                     
#---------------------------------------------------------#

m <- matrix(round(runif(20), digits = 2), nrow = 5)

#loop over rows 
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}

print(m)


m <- matrix(round(runif(20), digits = 2), nrow = 5)
#loop over columns
for(j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}

print(m)

#loop over both
m <- matrix(round(runif(20), digits = 2), nrow = 5)
for(i in 1:nrow(m)){
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}

print(m)
