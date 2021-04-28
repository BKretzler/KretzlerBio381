# ---------------------------------------------------------
# Lecture 21
# ggplot 1
# 20 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------


#---------------------------------------------------------#
#                      prelims
#---------------------------------------------------------#

library(ggplot2)
library(ggthemes)
library(patchwork)
library(TeachingDemos)
char2seed("10th Avenue Freeze-Out")
d <- mpg # use built in mpg data frame
str(d)

#---------------------------------------------------------#
#                      qplot
#---------------------------------------------------------#

qplot(x = d$hwy)
qplot(x = d$hwy, fill = I("tan"), colour = I("black"))

myHisto <- function(xVar,filCol="goldenrod"){
  qplot(x=xVar,color=I("black"),fill=I(filCol))}
myHisto(d$hwy)

myHisto(d$hwy, "thistle")

qplot(x = d$hwy, geom = "density")

qplot(x = d$displ, y = d$hwy, geom = c("smooth", "point"))

qplot(x = d$displ, y = d$hwy, geom = c("smooth", "point"), method = "lm")













