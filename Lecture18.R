# ---------------------------------------------------------
# Lecture 18 continued
# Parameter sweeping
# 06 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

library(ggplot2)

#S = cA ^z describes species area relationship

#                      functions

#----------------------------------------------------------
#FUNCTION: SpeciesArea
#Description: create a power function for S and A
#Inputs: A = vector of island areas, 
#        c = intercept constant, 
#         z = slope constant
#Outputs: S is a vector of species richness
#----------------------------------------------------------
SpeciesArea <- function(A = 1:5000,
                        c = 0.5,
                        z = 0.26) {
S <- c*(A^z)
  return(S)
  
} #end of SpeciesArea
#----------------------------------------------------------


head(SpeciesArea())

#----------------------------------------------------------
#FUNCTION: SAplotter
#Description: plots species area curves with parameter values
#Inputs: A = vector of areas, c = intercept, z = slope
#Outputs: smoothed curve with parameters printed in graph
#----------------------------------------------------------
SAplotter <- function(A = 1:5000,
                      c = 0.5,
                      z = 0.26) {
plot(x = A, y = SpeciesArea(A,c,z), 
     type = "l", 
     xlab = "Island Area",
     ylab = "S",
     ylim = c(0, 2500))
  mtext(paste("c =", c, "z = ", z), cex = 0.7)
#  return("checking.... SAplotter")
  
} #end of SAplotter
#----------------------------------------------------------

SAplotter()


#build grid of plots 
#use for homework 8 and 9

#global variables
cPars <- c(100,150,175)
zPars <- c(0.1, 0.16, 0.26, 0.3)
#par(mfrow = c(3,4))


for(i in seq_along(cPars)){
  for(j in seq_along(zPars)) {
    SAplotter(c = cPars[i], z = zPars[j])
  }
}


#---------------------------------------------------------#
#                      expand grid
#---------------------------------------------------------#


expand.grid(cPars, zPars) #generates a dataframe 
  #each column corresponds to a parameter
  #each row corresponds to a combo of the parameters


#----------------------------------------------------------
#FUNCTION: SAoutput
#Description: summary of stats for species area power function
#Inputs: vector of predicted specie richness values
#Outputs: list of max - min coefficient of variation
#----------------------------------------------------------
SAoutput <- function(s = runif(1:10)) {
  
  sumStats <- list(sGain = max(s) - min(s),
                   sCV = sd(s)/mean(s))
  return(sumStats)
  
} #end of SAoutput
#----------------------------------------------------------

SAoutput()

#global variables
Area <- 1:5000
cPars <- c(100,150,175)
zPars <- c(0.1, 0.16, 0.26, 0.3)

#set up model data frame
modelFrame <- expand.grid(c = cPars, z = zPars)

str(modelFrame)
modelFrame$sGain <- NA
modelFrame$sCV <- NA

head(modelFrame)

#cycle through model calculations
for(i in 1:nrow(modelFrame)){
  #generate Svector
  temp1<- SpeciesArea(A = Area, 
                      c = modelFrame[i,1], 
                      z = modelFrame[i,2])
  #calc output stat
  temp2 <- SAoutput(temp1)
  
  #pass results to columns in data frame
  modelFrame[i,c(3,4)]<-temp2
  
}

print(modelFrame)


#parameter sweep redux with ggplot graphics

area <- 1:5
cPars <- c(100,150,175)
zPars <- c(0.1, 0.16, 0.26, 0.3)

#set up model frame
mf <- expand.grid(c = cPars, 
                  z = zPars,
                  A = area)
head(mf)
str(mf)
mf$S

#loop through parameters and fill with SA function

for(i in 1:length(cPars)){
  for(j in 1:length(zPars)){
  mf[mf$c == cPars[i] & mf$z ==zPars[j],"S"] <- SpeciesArea(A = area,
                                                            c = cPars[i],
                                                            z = zPars[j])
  }
}

head(mf)


library(ggplot2)

ggplot()+ geom_line(data = mf,aes(x=A,y=S)) + 
  facet_grid(c~z)

ggplot()+ geom_line(data = mf,aes(x=A,y=S, group = z)) + 
  facet_grid(.~c)

ggplot()+ geom_line(data = mf,aes(x=A,y=S, group = c)) + 
  facet_grid(z~.)
