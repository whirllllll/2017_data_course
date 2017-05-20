library(Hmisc)
library(ggplot2)
cor_data<- cor(data_final[, -5])

#anova
anova(m_year<- lm(in_student~ year, data= data_final))

anova(m_total <- update(m_year, . ~ . + out_student, data = data_final))


#同年份下的來台大交換學生人數平均數，加上信賴區間
ggplot(data = data_final,
       aes(x = year, y = in_student)) +
  stat_summary(fun.data = 'mean_cl_boot', size = 1) +
  scale_y_continuous(breaks = seq(0, 320, by = 20)) +
  geom_hline(yintercept = mean(data_final$in_student) ,
             linetype = 'dotted') +
  labs(x = '年份', y = '交換學生平均人數') +
  coord_flip()

#不同年份下，來台大交換學生與台大出國交換學生關係
ggplot(data = data_final,
       aes(group = year,
           y = in_student, x = out_student)) +
  geom_point() +
  stat_smooth(method = 'lm', se = F) +
  stat_smooth(aes(group = year,
                  y = in_student, x = out_student),
              method = 'lm', se = F) +
  facet_grid( . ~  year) +
  labs(x = '出國交換學生人數', y = '來台大交換學生人數')
