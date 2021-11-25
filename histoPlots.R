setwd('/Users/gianlucascoccia/Desktop/STJ2022/scripts')

library(forcats)
library(stringr)
library(readxl)

data <- read_excel("../data/extracted_data.xlsx")

figuresPath <- "../paper/figures/"


createPlot <- function(columnName, tagsToConsider, prettyPrintedTags, othersSupported, leftMargin, fileName, otherString, width, height) {
  
  filePath <- paste(figuresPath, fileName, ".pdf", sep="")
  print(filePath)
  
  pdf(filePath, width=width, height=height)
  par(mar=c(3, leftMargin, 1, 1))
  par(mfrow=c(1, 1))
  par(las=1)
  
  idColumnName <- "Paper_ID"
  
  # DO NOT CHANGE ANYTHING BELOW THIS LINE
  
  separator <- ", "
  
  tagsToConsider <- unlist(unique(as.list(strsplit(paste(tagsToConsider, sep=separator, collapse=separator), separator)[[1]])))
  
  addOther <- function(x){
    if(is.factor(x)) return(factor(x, levels=c(levels(x), otherString)))
    return(x)
  }
  
  createTable <- function(tbName,tags) {
    apply <- ""
    cleanName <-gsub("\\.", " ", tbName) 
    caption <<- paste(apply,cleanName, sep=" ")
    column <<- tbName
    columnName <<- cleanName
    tags <<- tags
    cleanTags <<- tags
    for(i in 1:length(tags)) {
      if(tags[i] %in% names(prettyPrintedTags)) {
        #print(prettyPrintedTags[[tags[i]]])
        cleanTags[i] <- prettyPrintedTags[[tags[i]]]
      }
    }
    cleanTags <<- gsub("\\_", " ", tags)
    tagNames <<- cleanTags
  }
  
  createTable(columnName,tagsToConsider)
  
  getPrimaryOccurrences <- function(currentTag) {
    assigned <- subset(data, grepl(currentTag, data[[column]]))[[idColumnName]]
    
    unassigned <<- setdiff(unassigned, assigned)
    
    #print("ctag")
    #print(currentTag)
    
    #print("datacol")
    #print(data[[column]])
    
    #print(sum(sapply(data[[column]], function(x) str_count(x, currentTag))))
    
    # OLD CODE
    #print(length(subset(data, grepl(currentTag, data[[column]]))[[idColumnName]]))
    
    return(sum(sapply(data[[column]], function(x) str_count(x, currentTag))))
  }
  
  combinedAddOthersRow <- function(df1) {
    otherList <- unassigned
    df1 <- as.data.frame(lapply(df1, addOther))
    df1 <- rbind(df1, c(otherString, otherString, length(otherList)))
    return(df1)
  }
  
  rerolledAddOthersRow <- function(df2) {
    otherList <- unassigned
    df2 <- unlist(lapply(df2, addOther))
    df2 <- as.character(df2)
    df2 <- append(df2, rep(otherString, length(otherList)))
    df2 <- as.factor(df2)
    return(df2)
  }
  
  reroll <- function(df) {
    rerolled <- c()
    for(i in 1:nrow(df)) {
      for(j in 1:df[i,][["occurrences"]]) {
        rerolled <- append(rerolled, toString(df[i,][["tagNames"]]))
      }
    }
    result <- data.frame(rerolled)
  }
  
  occurrences <- c()
  unassigned <- data[[idColumnName]]
  
  for(i in 1:length(tags)) {
    occurrences[i] <- getPrimaryOccurrences(tags[i])
  }
  
  combined <- data.frame(tags, tagNames, occurrences)
  
  rerolled <- reroll(combined)
  
  if(othersSupported && length(unassigned != 0)) {
    combined <- combinedAddOthersRow(combined)
    rerolled <- rerolledAddOthersRow(rerolled)
  }
  
  combined <- combined[order(combined$occurrences, decreasing=F),]
  if(othersSupported && length(unassigned != 0)) {
    rerolled <- fct_rev(fct_infreq(rerolled))
  } else {
    rerolled <- fct_rev(fct_infreq(rerolled$rerolled))
  }
  
  labels = sort(as.numeric(combined$occurrences), decreasing = FALSE) 
  
  plot <- plot(rerolled, main="", cex.main=1, xlim=c(0, nrow(data) + 15), cex=2, cex.names=1.9, las=1, horiz=TRUE)
  text(x=labels + 1.75, y = plot, label = labels, cex = 2, col = "black")
  
  dev.off()
}

######## Characteristics 
columnName <- "code_measured"
tagsToConsider <- levels(as.factor(data[[columnName]]))
prettyPrintedTags <- c("speed" = "PF",
                       "memconsum" = "MC",
                       "enerconsum" = "EC",
                       "cacheperform" = "C",
                       "bandwidth" = "BW")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 5, "characteristics", "Other", 10, 3)


######## Data analysis technique
columnName <- "code_dataanalysis"
tagsToConsider <- levels(as.factor(data[[columnName]]))
prettyPrintedTags <- c("descstats" = "DS",
                       "hyptest" = "HT",
                       "predmod" = "PM",
                       "correlana" = "CA",
                       "effsize" = "ESE")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 5, "data_analysis", "Other", 10, 3)



######## Data analysis technique
columnName <- "code_reppackage"
tagsToConsider <- levels(as.factor(data[[columnName]]))
prettyPrintedTags <- c("no" = "None",
                       "yes/only_data" = "D",
                       "yes/only_code" = "C",
                       "yes/data_code" = "CD",
                       "yes/instructions_data_code" = "ICD")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 5, "reppackage", "Other", 10, 3)


######## Device type
columnName <- "code_platform"
tagsToConsider <- levels(as.factor(data[[columnName]]))
prettyPrintedTags <- c("smartphone" = "Smartphone",
                       "emulation" = "Emulation",
                       "tablet" = "Tablet")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 12, "devicetype", "Other", 10, 3)

######## Operating System
columnName <- "code_os_no_emu"
tagsToConsider <- c("adroid","ios","mixed", "other")
prettyPrintedTags <- c("adroid" = "Android",
                       "ios" = "iOS",
                       "mixed" = "Mixed",
                       "other" = "Other")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 12, "os", "Other", 10, 3)

######## Browser
columnName <- "code_browser_simple"
tagsToConsider <- c("chrome", "firefox", "modified", "safari", "not provided", "other")
prettyPrintedTags <- c("chrome" = "Chrome",
                       "firefox" = "FireFox",
                       "safari" = "Safari",
                       "modified" = "Modified",
                       "not provided" = "Not provided",
                       "other" = "Other")
createPlot(columnName, tagsToConsider, prettyPrintedTags, FALSE, 10, "browser", "Other", 8, 4)
