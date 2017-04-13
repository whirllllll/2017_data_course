library("dplyr")
library("plotly")
raw_data<- read.csv("D:/github/2017_data_course/HW/HW2/hw2.csv", sep= ",", header= TRUE)
del_na<- which(is.na(raw_data$year)== TRUE)
raw_data<- raw_data[-del_na, ] 
raw_data[is.na(raw_data)]<- 0
p <- plot_ly(raw_data, x = ~year, y = ~prof, name = 'Prof.', type = 'scatter', mode = 'lines')
# %>%
#   add_trace(y = ~assprof, name = 'assProf.', mode = 'lines') %>%
#   add_trace(y = ~asstprof, name = 'asstProf.', mode = 'lines')
chart<- plotly_POST(p, filename="line/mode1")
