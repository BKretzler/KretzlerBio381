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
                             flag = "O"),
                     ".csv", 
                     sep ="")
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