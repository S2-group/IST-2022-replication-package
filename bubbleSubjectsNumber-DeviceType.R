  setwd('/Users/gianlucascoccia/Desktop/STJ2022/scripts')
  library(forcats)
  library(stringr)
  library(readxl)
  library(purrr)
    
  data_ <- read_excel("../data/extracted_data.xlsx")
  
  Var1ColumnName <- "code_nrsites_grouped"
  Var2ColumnName <- "code_platform"
  fileName <- paste("../paper/figures/Bubble", "SubjectsNumber-DeviceType", ".png", sep="")
  Var1Label <- ""
  Var2Label <- ""
  bubbleScaler <- 1.25
  
  Var1OldValues = c("<= 10", "<= 50", "<= 100",  "<= 1000",  "> 1000",  "not provided")
  
  Var2ColumnOldValues <- c("smartphone", "tablet", "emulation")
  Var2ColumnNewValues <- c("Smartphone", "Tablet", "Emulation")
  
  # name of the X and Y axis labels
  xLabel <- "Number of subjects"
  yLabel <- "Device type"
  
  # size of all text in plot
  textsize = 17
  
  #######################################################################
  
  countOccurrences <- function(el1, el2) {
    sum <- 0
    for(i in 1:length(Elements1)) {
      
      if((el1 == Elements1[i]) && (el2 == Elements2[i])) {
        
        sum <- sum + 1
      }
    }
    return(sum)
  }
  
  ##### Load data ####
  
  Elements1 <- as.character(data_[[Var1ColumnName]])
  Elements1 <- Elements1[!is.na(Elements1)]
  
  Elements2 <- as.character(data_[[Var2ColumnName]])
  Elements2 <- Elements2[!is.na(Elements2)]
  
  #### Split Elements 1 rows with multiple values into multiple rows ####
  
  Elements1toAdd = c()
  Elements2toAdd = c()
  indexes_to_remove = c()
  
  for(i in 1:length(Elements1)) {
    if(grepl(",", Elements1[i], fixed = TRUE)){
      splitted_elems = flatten_chr(strsplit(str_replace_all(Elements1[i], fixed(" "), ""), ",", perl = T))
      
      for(j in 1:length(splitted_elems)){
        Elements1toAdd = c(Elements1toAdd, splitted_elems[j])
        Elements2toAdd = c(Elements2toAdd, Elements2[i])
      }
      
      if(length(splitted_elems > 1)){
        indexes_to_remove = c(indexes_to_remove, i)
      }
    }  
  }
  
  if(!is.null(indexes_to_remove)){
    Elements1 = Elements1[-indexes_to_remove]
  }
  Elements1 = c(Elements1, Elements1toAdd)
  
  if(!is.null(indexes_to_remove)){
    Elements2 = Elements2[-indexes_to_remove]
  }
  Elements2 = c(Elements2, Elements2toAdd)
  
  #### Split Elements 2 rows with multiple values into multiple rows ####
  
  Elements1toAdd = c()
  Elements2toAdd = c()
  indexes_to_remove = c()

  for(i in 1:length(Elements2)) {
    if(grepl(",", Elements2[i], fixed = TRUE)){
      splitted_elems = flatten_chr(strsplit(str_replace_all(Elements2[i], fixed(" "), ""), ",", perl = T))

      for(j in 1:length(splitted_elems)){
        Elements1toAdd = c(Elements1toAdd, Elements1[i])
        Elements2toAdd = c(Elements2toAdd, splitted_elems[j])
      }

      if(length(splitted_elems > 1)){
        indexes_to_remove = c(indexes_to_remove, i)
      }
    }
  }

  if(!is.null(indexes_to_remove)){
    Elements2 = Elements2[-indexes_to_remove]
  }
  Elements2 = c(Elements2, Elements2toAdd)

  if(!is.null(indexes_to_remove)){
    Elements1 = Elements1[-indexes_to_remove]
  }
  Elements1 = c(Elements1, Elements1toAdd)


  
  for(i in 1:length(Elements2)) {
    for(j in 1:length(Var2ColumnOldValues)) {
      if(Elements2[i] == Var2ColumnOldValues[j]) {
        Elements2[i] <- Var2ColumnNewValues[j]
      }
    }
  }
  
  Var1 <- unique(Elements1)
  Var2 <- unique(Elements2)
  
  count <- vector("integer", length(Var1) * length(Var2))
  
  grid <- expand.grid(Var1, Var2)
  grid$count <- count
  grid <- grid[ order(grid[,1], grid[,2]), ]
  
  index <- 0
  for(i in 0:(length(Var1) - 1)) {
    
    index <- length(Var2) * i
    for(j in 1:length(Var2)) {
      
      if(!is.na(grid[index + j, 1])) {
        grid[index + j, 3] <- countOccurrences(grid[index + j, 1], grid[index + j, 2])
      }
    }
  }
  
  # we remove all the rows with 0 value as count
  grid <- grid[grid$count > 0, ]
  
  # here we start creating the plot
  
  library(ggplot2)
  library(cowplot)
  grid$radius <- sqrt( grid$count / pi ) * bubbleScaler
  
  #Reorder factors
  grid$Var1 <- factor(grid$Var1, levels = c("<= 10", "<= 50", "<= 100", "<= 1000", "> 1000", "not provided"))
  grid$Var2 <- factor(grid$Var2, levels = c("Emulation", "Tablet", "Smartphone"))
  
  p <- ggplot(grid,aes(Var1,Var2))+
    #geom_point(aes(size=radius*10),shape=21,fill="white", alpha=0.8)+
    geom_point(data=grid,aes(fill=count,size=radius*13),shape=21,color="black", alpha=0.9) +
    scale_fill_gradient2(low="green", high="grey", limit=c(0,max(grid$count)),name=Var2Label) +
    geom_text(aes(label=count),size=textsize-10, alpha=1)+
    guides(fill=FALSE)+
    #geom_text(aes(label=count),size=5, alpha=1,vjust=3,hjust=-2)+
    scale_size_identity()+
    theme_cowplot() +
    theme(panel.grid.major = element_line(colour = "grey")) + 
    labs(x=Var1Label, y=Var2Label) +
    theme(axis.text.x = element_text(size=textsize, angle=90, hjust=1, vjust=0), axis.text.y = element_text(size=textsize),
          axis.title.x = element_text(size=textsize), axis.title.y = element_text(size=textsize)) + 
    theme(axis.line = element_line(color = 'black')) + 
    scale_x_discrete(labels = c("<= 10", "<= 50", "<= 100", "<= 1000", "> 1000", "Not\nprovided")) + 
    theme(axis.text.x = element_text(vjust = 0.35))

    # + scale_y_discrete(labels = Var2ColumnNewValues)
  
  
  print(p)
  ggsave(fileName, p, width=2.5, height=1.5, units="in", scale=3.5)
  
  