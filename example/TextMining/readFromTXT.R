rm(list=ls(all.names = TRUE))
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
filenames <- list.files(getwd(), pattern="*.txt")
files <- lapply(filenames, readLines)
#轉換資料結構-> 較容易搜尋
#轉成為10篇文章
docs <- Corpus(VectorSource(files))

#移除可能有問題的符號
#content_transformer->拿出每一個句子
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}
)
docs <- tm_map(docs, toSpace, "※")
docs <- tm_map(docs, toSpace, "◆")
docs <- tm_map(docs, toSpace, "‧")
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "我")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "看板")
docs <- tm_map(docs, toSpace, "作者")
docs <- tm_map(docs, toSpace, "發信站")
docs <- tm_map(docs, toSpace, "批踢踢實業坊")
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
#移除標點符號 (punctuation)
#移除數字 (digits)、空白 (white space)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)
#語詞詞幹化 (stemmization)
#以英文為例
#https://zh.wikipedia.org/wiki/%E8%AF%8D%E5%B9%B2%E6%8F%90%E5%8F%96
#library(SnowballC)
#確保任何形式的單字只會轉換成相同詞性出現一次
#docs <- tm_map(docs, stemDocument)

#unlist->解開list結構
mixseg = worker()
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
#切割詞
#seg 型態：list
seg = lapply(docs, jieba_tokenizer)

#統計：table，型態=factor
freqFrame = as.data.frame(table(unlist(seg)))

#排序
freqFrame<- freqFrame[order(freqFrame$Freq, decreasing = TRUE), ]
head(freqFrame)

#文字雲
#出現頻率大於50，只選擇150個詞
wordcloud(freqFrame$Var1,freqFrame$Freq,
          scale=c(5,0.1),min.freq=50,max.words=150,
          random.order=TRUE, random.color=FALSE, 
          rot.per=.1, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
