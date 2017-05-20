library("dplyr")
library("plotly")
library("RColorBrewer")
raw_data<- read.csv("D:/github/2017_data_course/project/eng_class.csv", sep= ",", header= TRUE)

lastsemId = length(raw_data$semester)
firstsem = raw_data$semester[1]
lastsem = raw_data$semester[lastsemId]
n = 18
allType = names(raw_data)
rownames(raw_data) <- 1:nrow(raw_data)

# NerTbale is as follows:
# year, people, type
# 1950, 100, prof.
# ...
# 2010, 50, lecture
typeId = c(2:13)
newTable = data.frame()
for( nid in c(1:n) )
{
  semester = as.matrix(rep(raw_data$semester[nid], length(raw_data[nid,typeId])))
  class_num = as.matrix(as.numeric(raw_data[nid,typeId]))
  type = as.matrix(as.character(allType[typeId]))
  temp = cbind(semester, class_num, type)
  newTable = rbind(newTable, temp)
}
names(newTable) = c('semester', 'class_num', 'pos')
newTable = newTable[with(newTable, order(pos)),]
#newTable<- newTable[0:198, ]
rownames(newTable) <- 1:nrow(newTable)

colourCount = length(unique(mtcars$hp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

p <- plot_ly(data = newTable, x = ~semester, 
             y = ~class_num, color = ~pos, colors= getPalette(colourCount)) %>%
  add_lines( yaxis = list(range = c(0,10)))
p
htmlwidgets::saveWidget(p, "index.html")

