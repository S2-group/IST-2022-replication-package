  setwd('/Users/gianlucascoccia/Desktop/STJ2022/scripts')
  library(forcats)
  library(stringr)
  library(readxl)
  
  data_ <- read_excel("../data/extracted_data.xlsx")
  
  # name of the X and Y axis labels
  xLabel <- "Year"
  yLabel <- "# of primary studies"
  
  # name of the column of interest
  columnName <- "code_caching"
  
  #years column
  yearsCol <- "Year"
  
  fileName <- paste("../paper/figures/Bubble", "Caching-Year", ".png", sep="")
  
  # one element for each possible year
  yearsInt <- c(min(data_[[yearsCol]]):max(data_[[yearsCol]]))
  
  # possible values for the column
  labels <- c("disabled", "notprovided", "enabled", "both")
  shortLabels <- c("Disabled", "Not\nprovided", "Enabled", "Both")
  
  # size of all text in plot
  textsize = 17
  
  library(stringr)
  
  d <- subset(data_, select = c(yearsCol,columnName))
  yearCounts = matrix(, nrow = length(yearsInt), ncol = length(labels), dimnames = list(yearsInt, labels))
  for (yearIndex in seq_along(yearsInt)) {
      yearValues <- d[columnName][d[yearsCol] == yearsInt[yearIndex]]
      yearC = vector()
      for (valIndex in seq_along(labels)) {
        yearCounts[yearIndex,valIndex] <- c(sum(str_count(yearValues, labels[valIndex])))
      }
  }
  d <- data.frame(yearsInt, yearCounts)
  colnames(d) <- c("Year",  shortLabels)
  
  library(plyr)
  
  names <- c("Year", "Count", "Type")
  grid <- data.frame(matrix(ncol = 3, nrow = 0))
  colnames(grid) <- names
  for (s in shortLabels){
    g <- data.frame(d$Year, c(d[s]), c(s))
    colnames(g) <- names
    grid <- rbind(grid, g)
  }
  
  #grid1 <- data.frame(d$Year, c(d$E), c("E"))
  #colnames(grid1) <- names
  #grid2 <- data.frame(d$Year, c(d$I), c("I"))
  #colnames(grid2) <- names
  #grid <- rbind(grid, grid1)
  #grid <- rbind(grid, grid2)
  #grid <- grid[ order(grid[,1], grid[,2]), ]
  
  # we remove all the rows with 0 value as count
  grid <- grid[grid$Count > 0, ]
  
  # here we start creating the plot
  library(ggplot2)
  library(cowplot)
  bubbleScaler <- 1.05
  grid$radius <- sqrt( grid$Count / pi ) * bubbleScaler
  Var2Label <- ""
  Var1Label <- ""
  
  p <- ggplot(grid,aes(Year,Type))+
    #geom_point(aes(size=radius*10),shape=21,fill="white", alpha=0.8)+
    geom_point(data=grid,aes(fill=Count,size=radius*13),shape=21,color="black", alpha=0.9) +
    scale_fill_gradient2(low="green", high="grey", limit=c(0,max(grid$Count)),name=Var2Label) +
    geom_text(aes(label=Count),size=textsize-10, alpha=1)+
    guides(fill=FALSE)+
    #geom_text(aes(label=count),size=5, alpha=1,vjust=3,hjust=-2)+
    scale_size_identity()+
    theme_cowplot() +
    theme(panel.grid.major = element_line(colour = "grey")) + 
    labs(x=Var1Label, y=Var2Label) +
    theme(axis.text.x = element_text(size=textsize, angle=90, hjust=1, vjust=0), axis.text.y = element_text(size=textsize),
          axis.title.x = element_text(size=textsize), axis.title.y = element_text(size=textsize)) + 
    theme(axis.line = element_line(color = 'black')) +
    scale_x_continuous(breaks = scales::pretty_breaks(n = 13)) 
    # scale_y_discrete(labels = tail(colnames(d),-1))
  
  print(p)
  ggsave(fileName, p, width=3.8, height=1.5, units="in", scale=3)
  
