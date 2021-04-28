# ---------------------------------------------------------
# Dplyr
# 28 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

library(dplyr)
data(starwars)
class(starwars)


glimpse(starwars)


starwarsClean <- starwars[complete.cases(starwars[,1:10]),]


unique(starwarsClean$gender)


a <- arrange(starwarsClean, by = height)

View(a)
