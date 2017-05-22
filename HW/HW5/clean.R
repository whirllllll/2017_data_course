rm(list=ls(all.names = TRUE))
library(tm)
library(NLP)

#取出檔案
filenames<- list.files(getwd(), pattern= "*.txt")
file<- lapply(filenames, readLines)
docs<- Corpus(VectorSource(file))

#清理檔案
#移除有問題符號
clean_symbol<- content_transformer(function(x, pattern){
  return(gsub(pattern, " ",  x))
})

docs <- tm_map(docs, clean_symbol, "※")
docs <- tm_map(docs, clean_symbol, "◆")
docs <- tm_map(docs, clean_symbol, "‧")
docs <- tm_map(docs, clean_symbol, "的")
docs <- tm_map(docs, clean_symbol, "我")
docs <- tm_map(docs, clean_symbol, "是")
docs <- tm_map(docs, clean_symbol, "看板")
docs <- tm_map(docs, clean_symbol, "作者")
docs <- tm_map(docs, clean_symbol, "發信站")
docs <- tm_map(docs, clean_symbol, "批踢踢實業坊")
docs <- tm_map(docs, clean_symbol, "[a-zA-Z]")
docs <- tm_map(docs, clean_symbol, "推")
docs <- tm_map(docs, clean_symbol, "有")
docs <- tm_map(docs, clean_symbol, "了")
docs <- tm_map(docs, clean_symbol, "在")
docs <- tm_map(docs, clean_symbol, "也")
docs <- tm_map(docs, clean_symbol, "可以")
docs <- tm_map(docs, clean_symbol, "要")
docs <- tm_map(docs, clean_symbol, "就")
docs <- tm_map(docs, clean_symbol, "標題")
docs <- tm_map(docs, clean_symbol, "不")
docs <- tm_map(docs, clean_symbol, "都")
docs <- tm_map(docs, clean_symbol, "但")
docs <- tm_map(docs, clean_symbol, "沒")
docs <- tm_map(docs, clean_symbol, "會")
docs <- tm_map(docs, clean_symbol, "所以")
docs <- tm_map(docs, clean_symbol, "嗎")
docs <- tm_map(docs, clean_symbol, "想")
docs <- tm_map(docs, clean_symbol, "說")
docs <- tm_map(docs, clean_symbol, "或")
docs <- tm_map(docs, clean_symbol, "很")
docs <- tm_map(docs, clean_symbol, "只")
docs <- tm_map(docs, clean_symbol, "和")
docs <- tm_map(docs, clean_symbol, "還")
docs <- tm_map(docs, clean_symbol, "因為")










#移除標點符號 (punctuation)
#移除數字 (digits)、空白 (white space)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)



