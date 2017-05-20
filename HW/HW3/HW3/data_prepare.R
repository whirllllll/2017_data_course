#分學院交換學生人數，變數：姊妹校、國際訪問教師人數，年份作圖
#不分學院，不分時間，交換學生人數與姐妹校數目、國際訪問教師人數關係
data<- data.frame()
data_final<- data.frame()

# college_name<- colnames(in_student)[3:13]
# college_func<- function(x){
#   x<- rep(as.factor(college_name[x]), max_year-min_year+1)
# }

for(i in c(1:11)){

  data_raw<- data.frame(year= in_student[, 1], in_student= in_student[, 2+i])%>% mutate(out_student= out_student[, 2+i])%>%
    mutate(ex_teacher= ex_teacher[, 2+i])%>% mutate(interview= interview_teacher[, 2+i])
  #%>%mutate(college= college_func(i))
  data<- rbind(data, data_raw)
}


data_final<- mutate(as.data.frame(as.integer(data$in_student)), as.numeric(data$out_student))%>%mutate(as.numeric(data$ex_teacher))%>%
  mutate(as.numeric(data$interview))%>% mutate(as.factor(data$year))
#%>% mutate(as.factor(data$college))
colnames(data_final)<- c("in_student", "out_student", "ex_teacher", "interview", "year")

kable(head(data_final), row.names= FALSE, col.names = colnames(data_final), align= "c")

