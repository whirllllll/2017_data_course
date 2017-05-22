library(dplyr)
library(rvest)
library(tmcn)
rm(list= ls(all.names= T))

id<- c(1:19)
file_name<- paste0(id, ".txt")
URL<- paste0("https://www.ptt.cc/bbs/Exchange/index", id, ".html")

content_function<- function(x){
  url<- paste0("https://www.ptt.cc", x)
  html<- read_html(url)
  tag<- html_node(html, "div#main-content.bbs-screen.bbs-content")
  toUTF8(html_text(tag))
}

txt_function<- function(URL, file_name){
  html<- read_html(URL)
  title<- html_nodes(html, "a")
  href<- html_attr(title, "href")
  
  data<- data.frame(title= toUTF8(html_text(title)), href= href)
  data<- data[-c(1:10), ]
  
  all_text<- sapply(data$href, content_function)
  write.table(all_text, file_name)
  }

mapply(txt_function, URL= URL, file_name= file_name)


