library(ggplot2)
library(dplyr)

out_student<- read.csv("data/out_ex_student.csv")
in_student<- read.csv("data/in_ex_student.csv")

col_name<- function(file, file_name){
  url<- paste0("data/", file_name, ".csv")
  x<- read.csv(url, header= F)
  colnames(x)<- as.matrix(x[2, ])
  x<- as.data.frame(x[c(-1, -2), ])
}

ex_teacher<- col_name(out_ex_teacher, "out_ex_teacher")
interview_teacher<- col_name(interview_teacher, "interview_teacher")

min_year<- max(min(in_student$Year), 2003)
max_year<- as.numeric(min(max(in_student$Year), max(out_student$Year), max(as.matrix(ex_teacher$Year))))
year_func<- function(x){x<- filter(x, Year>= min_year&Year<= max_year)}
in_student<- year_func(in_student)
out_student<- year_func(out_student)
ex_teacher<- as.data.frame(ex_teacher)[11:21, ]
interview_teacher<- as.data.frame(interview_teacher)[11:21, ]
in_student<- as.data.frame(in_student)

