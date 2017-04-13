rawdata = read.csv('teacher.csv',
                   header = TRUE)
delId = which(is.na(rawdata$Year) == TRUE)
rawdata = rawdata[-delId,]
rawdata[is.na(rawdata)] = 0
lastyearId = length(rawdata$Year)
firstYear = rawdata$Year[1]
lastYear = rawdata$Year[lastyearId]
n = lastYear - firstYear + 1

library(plotly)
allType = names(rawdata)

# NerTbale is as follows:
# year, people, type
# 1950, 100, prof.
# ...
# 2010, 50, lecture
typeId = c(3:11)
newTable = data.frame()
for( nid in c(1:n) )
{
  year = as.matrix(rep(rawdata$Year[nid], length(rawdata[nid,typeId])))
  people = as.matrix(as.numeric(rawdata[nid,typeId]))
  type = as.matrix(as.character(allType[typeId]))
  temp = cbind(year, people, type)
  newTable = rbind(newTable, temp)
}
names(newTable) = c('year', 'people', 'type')
p <- plot_ly(newTable, x=~year, y=~people, color=~type) %>%
  add_lines() %>%
  layout(title = "1950 ~ 2013",
         xaxis = list(title = "year"),
         yaxis = list(title = "people"))
p
htmlwidgets::saveWidget(p, "index.html")