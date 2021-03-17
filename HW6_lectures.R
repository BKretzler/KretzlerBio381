###########HW6 LECTURES#############
##---------------------------------
#             Packages            #
##---------------------------------
library(ggplot2)


##---------------------------------
#             Matrices`           #
##---------------------------------

m<- matrix (data = 1:12, nrow = 4, ncol = 3)
print(m)

#same as
m<- matrix (data = 1:12, nrow = 4)
print(m)


#fill by rows
m<- matrix (data = 1:12, nrow = 4, byrow = TRUE)
print(m)


#check dimensions
dim(m)


# change dimesions (consistent size)

dim(m) <- c(6,2)
print(m)
dim(m) <- c(4,3)

#row and col seperata

nrow(m)
ncol(m)
length(m)



colnames(m) <- LETTERS[1:ncol(m)]
rownames(m) <- letters[nrow(m):1]
print(m)

#specify row element

m[1,3]


## if using dim names, has to be a list

dimnames(m) <- list( letters[nrow(m):1], LETTERS[1:ncol(m)])
print(m)


#t() transposes matrix

m_trans <- t(m)
print(m_trans)


##---------------------------------
#             List    `           #
##---------------------------------

#differs from an atomic vector in that it can hold objects
#of differing types


mylist <- list(1:10,matrix(1:8,nrow = 4, byrow = TRUE),
               letters[1:3], pi)

str(mylist)
print(mylist)


# using single bracket does not give contents just item

mylist[4]
#doesn't work mylist[4] - 3
mylist[[4]] - 3


# unlist function
  ##Puts everything into a single atomic vector

unrolled <- unlist(mylist)
print(unrolled)


round(runif(100, min = 1, max = 10)) == round(runif(100, min = 1, max = 10))


## to add a row to a data frame it has to be a list!!!


