#------------------------------------------------------------#
###Lecture 11 - distributions
###Bio 381
###B Kretzler
#------------------------------------------------------------#
library(ggplot2)
library(MASS)

#d = gives probability density function, probability of a particular value
#p = gives cumulative distribution function, area under the curve?
#q = give quantile function, what value encompasses some percent of dist
#r = gives random number from distribution


#--------------
#Poisson
#Discrete X >= 0 (integer)
#Random events ("hits") occur at a constant rate
#in a fixed time period or sampling area
#lambda = average rate of the event
#--------------
#"d" function for prob density
hits<- 0:30
my_vec <- dpois(x = hits, lambda = 5)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("salmon3"))
  #if rate is 1 per time then  (lambda = 1) then it is unlikely to see "hits" at high values
  #tells us prob of obtaining certain values

ggplot() + 
  geom_col(aes(x = hits, y = my_vec ), fill = "salmon3", col = "black") + 
  theme_bw() + 
  xlab ("Number of Occurence per Time Unit") + 
  ylab("Proportion observed")


hits<- 0:10
my_vec <- dpois(x = hits, lambda = 2)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

hits<- 0:15
my_vec <- dpois(x = hits, lambda = 6)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

hits<- 0:20
my_vec <- dpois(x = hits, lambda = 10)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

hits<- 0:10
my_vec <- dpois(x = hits, lambda = 0.2)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))

sum(my_vec)

  #can apply for single values (prob of getting some value of hits)
dpois(x = 0, lambda = 2.2)

#"p"function
#generates cummulative probability density 

hits <- 0:10
my_vec <- ppois(q = hits, lambda = 2)
qplot(x=hits,
      y=my_vec,
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))
  #Additive probability
  #bars represent likelihood of getting that values OR LESS

  #probability that a single trial yields a value of <= 1
ppois(q = 1, lambda = 2) # could also define with dpois
ppois(q = 3, lambda = 3)
  #test
p_0 = dpois(0, lambda = 2)
p_1 = dpois(1, lambda = 2)

p_0 + p_1 == ppois(q = 1, lambda = 2) 


#"q" function
#inverse of the p function
#prob of being >= that value?

qpois(p = 0.5, lambda = 2.5)
qplot(x = 0:10, y= dpois(0:10, lambda = 2.5),
      geom="col",
      color=I("black"),
      fill=I("goldenrod"))


#"r" function
#generates random varaibles for the parameters of a dist.

RanP <- rpois(n = 1000, lambda = 2.5)
qplot(x = RanP,
      color=I("black"),
      fill=I("goldenrod"))

#for real or simulated fata we can use the quantile function
quantile(x = RanP, probs = c(0.025, 0.975)) #where to 95% fall

#--------------------
#binomial
# p = probability of dichotomous outcome
#size = number of trials
# x = possible outcomes
# outcome x is bounded (0:size)
#--------------------
#"d"
hits <- 0:10
myVec <- dbinom(x = hits, size = 10, prob = 0.3)
qplot(x = 0:10, y = myVec,
      geom = "col",
      color = I("black"),
      fill = I("goldenrod"))


myCoins <- rbinom(n = 50, size = 100, prob = 0.6)
qplot(x = myCoins,
      color = I("black"),
      fill = I("goldenrod"))

#------------------------
#negative binomial
#number of failures expected before reaching some number of successes in a set of binomial trials
#measure of waiting time
#alternatively, can specify mu = mean and size = dispersion 
#------------------------

hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.5)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

nbiRan <- rnbinom(n=1000,size=10,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))
