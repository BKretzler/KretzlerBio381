# ---------------------------------------------------------
# Lecture 20
# batch processing
# 13 Apr 2021
# Bailey M Kretzler
# ---------------------------------------------------------

#----------------------------------------------------------
#FUNCTION: fileBuilder
#Description: creates a set of randome files for regression
#Inputs: fileN = number of data files to create, 
#        fileFold = folder name for random files, 
#        fileSize = c(min, max) min and max number of rows in file,
#        fileNA = average number of NA values per column
#Outputs: creates set of random riles
#----------------------------------------------------------
fileBuilder <- function(fileN = 10,
                        fileFold = "RandomFiles/",
                        fileSize = c(15, 100),
                        fileNA = 3) {
  
  for(i in seq_len(fileN)){
    fileLen <- sample(fileSize[1]:fileSize[2], size = 1)
      #creates a random file length using the rand specified by file size
      #from value 1 to value 2
    xVar <- runif(fileLen)
    yVar <- runif(fileLen)
    df <- data.frame(xVar, yVar)
    badVal <- rpois(n = 1, lambda = fileNA) #determine number of NAs
    df[sample(nrow(df), size = badVal),1] <- NA
    df[sample(nrow(df), size = badVal),2] <- NA
    
    #create label for file name with padded zeros
    
    fileLab <- paste(fileFold, "RanFile",
                     formatC(i,
                             width = 3,
                             format = "d",
                             flag = "0"),
                     ".csv", sep ="")
    # set up data file and incorporate time stamp and minimal metadata
    
  write.table(cat("# Simulated random data file for batch processing", "\n",
                  "# timestamp: ", as.character(Sys.time()), "\n",
                  "# BMK", "\n",
                  "# ------------------------------", "\n",
                  "\n",
                  file = fileLab,
                  row.names = "",
                  col.names = "",
                  sep = ""))
  #add data frame
  
  write.table(x = df, 
              file = fileLab,
              sep = ",",
              row.names = FALSE,
              append = TRUE)
    
    
  }#End loop

  
} #end of fileBuilder
#----------------------------------------------------------
fileBuilder()
#----------------------------------------------------------
#FUNCTION: regStats
#Description: fit linear mode, extract model stats
#Inputs: 2 column data fram (x and y)
#Outputs: slope, p value, and r sq
#----------------------------------------------------------
regStats <- function(d = NULL) {
      if(is.null(d)){
        x <- runif(10)
        y <- runif(10)
        d <- data.frame(x,y)
      }
  . <- lm(data = d, d[,2]~d[,1])
  . <- summary(.)
  statList <- list(slope <- .$coefficients[2,1], 
                   p <- .$coefficients[2,4],
                   rsq <- .$r.squared)
  
  
    
  
  return(statList)
  
} #end of regStats
#----------------------------------------------------------

library(TeachingDemos)

char2seed("Flatpicking Solo")

#---------------------------------------------------------#
#                      global variables
#---------------------------------------------------------#

file <- "RandomFiles/"

nfiles <- 100

fileOut <- "StatsSummary2.csv"

#---------------------------------------------------------#
#               create data frame and sets
#---------------------------------------------------------#

dir.create(file) # IF CHANGED DON'T RE RUN

fileBuilder(fileN = nfiles) #IF CHANGED DON'T RERUN

fileNames <- list.files(path = file)

#data frame

ID <- seq_along(fileNames)
filename <- fileNames
slope <- rep(NA, length(fileNames))
pval <- rep(NA, length(fileNames))
rsq <- rep(NA, length(fileNames))
statOut <- data.frame(ID, filename,slope, pval,rsq)


#---------------------------------------------------------#
#                      Batch Processing
#---------------------------------------------------------#

### loop through the individual filed and process


for(i in seq_along(fileNames)){
  data <- read.table(file = paste(file,fileNames[i],
                     sep = ""), #sep for paste
                     sep = ",",#sep for read.table
                     header = TRUE) 
  dClean <- data[complete.cases(data),] # subset for clean data (no NAs)
  
  . <- regStats(dClean)
  statOut[i,3:5] <- unlist(.)
}


#set up output file with metadata

write.table(cat("# Summary Stats for ",
                "batch processing of regression models",
                "\n",
                "# time stamp:", as.character(Sys.time()),
                "\n",
                file = fileOut,
                row.names ="",
                col.names = "",
                sep = ""))


#add data frame

write.table(x = statOut,
            file = fileOut,
            row.names = FALSE,
            col.names = TRUE,
            sep = ",",
            append = TRUE)
