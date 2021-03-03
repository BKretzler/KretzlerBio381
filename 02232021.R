#Bailey Kretzler
#Data Types and Atomic vectors
# 23 February 2021
#########################################
#########################################

#Using the assignment operator

x<- 3 #assign x as the value of 3


#conventions for naming

z <- 1241 #start with lowercase letter

firstSecond <- seq(2,46,2) # camel case
first.second <- 12543 #should be avoided
first_second <- 25:176 #snakecase - preferred
. <- 5.6743 #can use . as variable name, becomes a generic holding variable


#one dimensional atomic vector

#combine/concatenate function

s <- c(2,5,3.3, 5.7, 4.2, 12, 19,15.1)
print(s)
typeof(s) #query what type it is
is.numeric(s) #asks is this numeric
is.character(s)


#c always flattens to atomic vector


#character strings
#bracketed by single or double quotes

d <- c("apple", "orange", "strawberry", "bean", "almond")
print (d)


# logical 
#boolean, all caps, no quotes

ft <- c(T,F,T,T,F,T,F,F)


#length
length(ft)
typeof(ft)


#type
typeof(s)
is.character(d)
as.character(ft)


store_z <- as.character(ft)
typeof(store_z)


#names

names(ft)

print(ft)
length(ft)
names(ft) <- c("a","b","c","d","e","f","g","h")

##can be added when we build variable

c <- c(a=3.4, b = 5.7, c = 9.0, d = 8.8)
print(c)


#reset names
names(c) <- NULL
print(c)


##we can have names for just some elements
##and the names don't have to be distinct


#use brackets to specify element of bracket

c[2]
c[3] = 10001
c


#special elements in a vector

###NA = missing value

####retains type in a vector with other elements

c[3] <- NA
typeof(c)
typeof(c[3])


z1 <- NA
typeof(z1)


is.na(c)
mean(c) #can't calculate
!is.na(c) #tells us what is not missing
mean(!is.na(c)) #wrong bc calculates mean of Trues and falses
##instead
mean(c[!is.na(c)])


#NaN, -Inf and Inf from numeric division

z <- 0/0
print(z) #NaN = not a number
typeof(z) #still a double

x <- 1/0
print(x) # infinity
typeof(x) #still a double

y = -1/0
print(y) #negative infinity
typeof(y) #still a double

#NULL is nothing
#reserved word in R
w = NULL
typeof(w)
length(w)



#Coercion

#all elements in an atomic vector must be the same type
#what if they are not

a <- c(2,2.0)
typeof(a)

#if elements within a vector are different data types, r forces (coerces) them to a common type

#heirarchy logical > integer > double > character
# > = gets converted to 

g <- c(2,3,"4")
print(g)
typeof(g)


#use mistake as powerful computing

e <- runif(10)
print(a)

##comparison opertors yield a logical result
e>0.50


#math with this 
sum(e>0.50) #uses boolean of T/F

sum(e>0.50)/length(e)

mean(e>0.5)


mean(rnorm(10000) > 2.0)
mean(rnorm(10000) < -2.0)


#vectorization

## corresponding elements in each vector are combined
v <- c(10,20,30)
k <- c(1,2,3)
v + k

k^2

(50 + k *5)/v^4


#recycling

##what if vector length are not equal to each other 
i = c(4,5,6)
l = c(5,6,7,8)

i + l #goes back to the first element 


############### set seed / subscripting with missing values

set.seed(90)
z <- runif(10)
print(z)


z < 0.5
z[z<0.5]
which(z<0.5)
z[which(z<0.5)]

####which behave diff w/ NAs
zd <- c(z,NA,NA)
zd[zd<0.5] ##carries missing values (NAs)
which(zd<0.5)
zd[which(zd<0.5)] ## does not carry NAs


