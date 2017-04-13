library(dplyr)
library(plotly)

raw_in_student<- read.csv("D:/github/2017_data_course/project/in_student.csv", sep= ",")

#plotly table
#College col
typeId<- c(3: 11)
yearId<- length(raw_in_student$year)
all_type<- colnames(raw_in_student[,typeId])

final_table<- data.frame() 
for (i in c(1: yearId)){
  year<- rep(raw_in_student$year[i], times= length(typeId))

  plot_table<- data.frame(year= year, people= as.numeric(raw_in_student[i, typeId]), type= all_type)
  final_table<- rbind(final_table, plot_table)
}
#plotly
p<- plot_ly(final_table, x= ~year, y= ~people, color= ~type)%>%
  add_lines()%>%
  layout(title = "1993~2015",
         xaxis = list(title = "year"),
         yaxis = list(title = "people"))
p

htmlwidgets::saveWidget(p, "index.html")





