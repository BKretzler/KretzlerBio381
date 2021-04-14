#Bailey Kretzler
#Bio 381 - Computational Biology 
#Lecture 13 - Functions
#---------------------------------
#---------------------------------
library(ggplot2)


sum(3,2) #prefix function
3+ 2 # this is also a function called an infix funtion
`+`(3,2) # also an infix function

#practical example
y <- 3 # infix function
print(y) #prefix function

`<-`(yy,3)# another "infix" function
print(yy)

# we can print a function to see it's contents
#----------this is pretty complex
#----------valuable when we write out own functions
print(read.table)

#--------can also just call witout parenthesis
sd

#this actually gives us the output
sd(c(3,2)) #we supplied input

sd() #call function with default values
#---------this function does not have default values




#############################################
#-------------------------------------------#
#Function h_weinberg
#calculates hardy weinberg equilibrium
#input = an allele frequency p (0 to 1)
#out put = p and the frequencies of the 3 genotypes
#-------------------------------------------#

h_weinberg <- function(p = runif(1)){
  q <- 1 - p
  f_AA <- p^2
  f_AB = 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA = f_AA, AB = f_AB, BB = f_BB), digits = 3)
  return(vec_out)
}

#--------------------------------------------#

####TESTING FUNCTION####

h_weinberg() # with defaults
h_weinberg(p = 0.5) #actual use
print(p) #doesn't work because p doesn't exist
         # it is a local variable

p <- 0.7
h_weinberg(p = p) #assigns global variable to a parameter


#--------------------------------------------#
####  Function with multiple return values####
#--------------------------------------------#
#Function h_weinberg2
#calculates hardy weinberg equilibrium
#input = an allele frequency p (0 to 1)
#out put = p and the frequencies of the 3 genotypes
#second one
#-------------------------------------------#

h_weinberg2 <- function(p = runif(1)){
  if(p  > 1.0 | p < 0.0){
    return("function failure: p must be >= 0 and <= 1.0")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB = 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA = f_AA, AB = f_AB, BB = f_BB), digits = 3)
  return(vec_out)
}

#--------------------------------------------#
#######   test the fucntion   ################
#--------------------------------------------#

h_weinberg2()

h_weinberg2(p = 1.3) # gives us a message
z <- h_weinberg2(p = 1.3) # no error, odd
print(z) #because it was stored in the object as a character string!!!



#--------------------------------------------#
####  Function with multiple return values####
#--------------------------------------------#
#Function h_weinberg3
#calculates hardy weinberg equilibrium
#input = an allele frequency p (0 to 1)
#out put = p and the frequencies of the 3 genotypes
#third --- learning to put in stops
#return true errors
#-------------------------------------------#

h_weinberg3 <- function(p = runif(1)){
  if(p  > 1.0 | p < 0.0){
    stop("function failure: p must be >= 0 and <= 1.0")
  } # end of if statement
  q <- 1 - p
  f_AA <- p^2
  f_AB = 2*p*q
  f_BB <- q^2
  vec_out <- signif(c(p=p, AA = f_AA, AB = f_AB, BB = f_BB), digits = 3)
  return(vec_out)
}

#--------------------------------------------#
#######   test the fucntion   ################
#--------------------------------------------#

h_weinberg3()

h_weinberg3(p = 1.3) # gives us a message
zz <- h_weinberg3(p = 1.3) # still gives us a message! Yay!
print(zz) # doesn't exist because the program was stopped




################################################
#-----------------------------------------------
#       Scoping                                 #
#-----------------------------------------------

my_f <- function(a =3,b=4) {
 z <- a + b
  return(z)
}


my_f()


bad_f<-  function(a =3) {
    z <- a + b
    return(z)
  }

bad_f() # has no context for b

b <- 9
bad_f() # calculates because is now in the global env.


# ok to create variables locally

ok_f<-  function(a =3) {
  bb <- 9
  z <- a + bb
  return(z)
}


ok_f()

print(bb)#does not exist outside the function




###################################################
# FUNCTION: fit_linear
#fits a simple linear regression line
#inputs: numeric vector of predictor (x) and response (y)
#outputs: slope and p-value
#--------------------------------------------------
fit_linear <- function(x = runif(20), y = runif(20)){
  my_model <- lm(y~x)
  my_out <- c(slope = summary(my_model)$coefficients[2,],pval = summary(my_model)$coefficients[2,4]) 
  #extract slope [2,1] and p-value [2,4] from summary 
  plot(x = x, y = y) 
  # if you use ggplot it has to be stored and then plotted
  #g <- ggplot2::qplot(x=x,y=y)
  #plot(g)
  return(my_out)
}

fit_linear()
fit_linear(x = c(245,386,173,346,209,234,867,978,450,372),
           y = c(1,4,7,12,3,4,7,8,11,9))

###################################################
# FUNCTION: fit_linear2
#fits a simple linear regression line with more complex default
#inputs: numeric vector of predictor (x) and response (y)
#outputs: slope and p-value
#--------------------------------------------------
fit_linear2 <- function(p = NULL){ #then build a fork
  if(is.null(p)){
    p <- list(x = runif(20), y = runif(20))
  } #end of input null case
  my_model <- lm(p$y~p$x)
  my_out <- c(slope = summary(my_model)$coefficients[2,],pval = summary(my_model)$coefficients[2,4]) 
  #extract slope [2,1] and p-value [2,4] from summary 
  plot(x = p$x, y = p$y) 
  # if you use ggplot it has to be stored and then plotted
  #g <- ggplot2::qplot(x=x,y=y)
  #plot(g)
  return(my_out)
}

fit_linear2()
my_pars <- list(x = 1:10, y = runif(10))
fit_linear2(p = my_pars)

z <- c(runif(99), NA)
mean(z) #NA
mean(z, na.rm = TRUE) 
mean(z, na.rm = TRUE, trim = 0.05) #throw out extreme values
p <- list(x = z, na.rm = TRUE, trim = 0.05)
do.call(mean,p)
