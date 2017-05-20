library(tmcn)
rm(list=ls(all.names = TRUE))
library(rvest)
#install.packages("tmcn", 
#repos="http://R-Forge.R-project.org")
id<- c(1983:1992)
filename<- paste0(id, ".txt")
URL<- paste0("https://www.ptt.cc/bbs/NTUcourse/index", id, ".html")

url_function<- function(URL, filename){
URL   = "https://www.ptt.cc/bbs/NTUcourse/index.html"
html  = read_html(URL)
title = html_nodes(html, "a")

href  = html_attr(title, "href")
data = data.frame(title = toUTF8(html_text(title)),
                     href = href)
data = data[-c(1:10),]
getContent <- function(x) {
  url  = paste0("https://www.ptt.cc", x)
  tag  = html_node(read_html(url), 'div#main-content.bbs-screen.bbs-content')
  text = toUTF8(html_text(tag))
  }
#getContent(data$href[1])
allText = sapply(data$href, getContent)

write.table(allText, filename)
}
mapply(url_function, URL= URL, filename= filename)

