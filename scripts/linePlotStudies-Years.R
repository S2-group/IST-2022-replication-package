  setwd('/Users/gianlucascoccia/Desktop/STJ2022/scripts')
  library(forcats)
  library(stringr)
  library(readxl)
  library(purrr)
    
  data_ <- read_excel("../data/extracted_data.xlsx")
  
  Var1ColumnName <- "Year"
  
  fileName <- paste("../paper/figures/linePlot", "Studies-Years", ".png", sep="")
  
  # name of the X and Y axis labels
  yLabel <- "Number of studies"
  xLabel <- "Year"
  
  # size of all text in plot
  textsize = 17
  
  #######################################################################
  
  ##### Load data ####
  
  Elements1 <- as.character(data_[[Var1ColumnName]])
  Elements1 <- Elements1[!is.na(Elements1)]
  
  data <- as.data.frame(table(factor(Elements1, levels = 2008:2021)))
  
  # here we start creating the plot
  library(ggplot2)
  library(cowplot)
  
  p <- ggplot(data, aes(Var1, Freq, group = 1)) +
    geom_line(color="#0b0ec1", size=1, alpha=0.9) +
    #geom_point(data=data,shape=21,color="black", alpha=0.9) +
    guides(fill=FALSE) +
    #geom_text(aes(label=count),size=5, alpha=1,vjust=3,hjust=-2)+
    scale_size_identity() +
    theme_cowplot() +
    theme(panel.grid.major = element_line(colour = "grey")) + 
    labs(x="", y="") +
    
    theme(axis.text.x = element_text(size=textsize, angle=90, hjust=1, vjust=0), axis.text.y = element_text(size=textsize),
          axis.title.x = element_text(size=textsize), axis.title.y = element_text(size=textsize)) + 
    theme(axis.line = element_line(color = 'black')) + 
    theme(axis.text.x = element_text(vjust = 0.35))

    # + scale_y_discrete(labels = Var2ColumnNewValues)
  
  
  print(p)
  ggsave(fileName, p, width=3, height=1.5, units="in", scale=3.5)
  
  