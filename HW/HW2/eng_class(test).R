---
  title: "HW02 台大英語授課課程數變化"
author: "B04202016 物理二 朱文亞"
date: "2017年4月24日"
output: html_document
---
  
  ```{r setup, include=FALSE}
library("dplyr")
library("plotly")
library("RColorBrewer")
require(stats)
knitr::opts_chunk$set(echo = TRUE)
```

## 台大英語授課數量

> 我們專題研究的主題是在台大的國際學生，想藉由不同的數據來描繪出他們在台大的生活。其中的一項指標，就是台大開設以英語來授課的課程數。由於來台大的國際學生有增加的趨勢，假定兩者具有關聯，因此在未分析數據前的預測是英語授課的課程數也會有增加的趨勢。



## 96~104學年度總體/各學院英語授課數量


```{r eng_class, echo=TRUE}
raw_data<- read.csv("eng_class.csv", sep= ",", header= TRUE)

lastsemId = length(raw_data$semester)
firstsem = raw_data$semester[1]
lastsem = raw_data$semester[lastsemId]
n = 18
allType = names(raw_data)
rownames(raw_data) <- 1:nrow(raw_data)
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
rownames(newTable) <- 1:nrow(newTable)

colourCount = length(unique(mtcars$hp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

p <- plot_ly(data = newTable, x = ~semester, 
             y = ~class_num, color = ~pos, colors= getPalette(colourCount)) %>%
  add_lines( yaxis = list(range = c(0,10)))
p

```

> y軸為英語授課的課程；x軸為學期 (ex：1041->104學年度第1學期)

> 由這張圖表來分析，可以看出個學院英語授課的課程總數有明顯增加的趨勢 (約從400增加到約550)，大致上是符合原先的預測。但各學院的英語課程數量卻都沒有明顯的增加趨勢。

##96~104學年度各學院英語授課數量
```{r echo= TRUE}
newTable<- newTable[0:198, ]
rownames(newTable) <- 1:nrow(newTable)

colourCount = length(unique(mtcars$hp))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))

p <- plot_ly(data = newTable, x = ~semester, 
             y = ~class_num, color = ~pos, colors= getPalette(colourCount)) %>%
  add_lines( yaxis = list(range = c(0,10)))
p
```

#

> 去除個學院英語課程總數後，放大檢視各學院間的差異。其中文學院的英語課程數量明顯多於其他學院，有很大的可能性是外文系所導致的結果，因為比起其他學院，文學院的英語課程數量反而有遞減的趨勢，外文系中英語授課的對象主要還是本地的學生，與國際學生較無關聯；而其他學院雖然上升的幅度並不大，但在這幾年中，英語授課的課程數有所增加。

> 雖然並不能以此就斷定以英語授課的課程數與國際學生人數有因果關係 (國際學生人數增加而必須開設更多英語課程，又或是英語課程數的增加吸引了國際學生)，但這次的分析還是可以說明台大開設的英語課程的確有增加，如果能找出更多的數據支持 (例如國際學生修習英語課程與非英語課程的比例，或是在兩種課程中成績的分布)，那這份數據也許就能夠做為一個指標，來略窺國際學生在台大的學習狀況。
