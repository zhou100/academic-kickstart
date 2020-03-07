
require(tidyverse)


#####################################
## Web Time 
#####################################
webtime <- read_csv("content/post/my2018/webtime-tracker-2018-12-31.csv")


webtime["sum_time"] = rowSums(webtime[,2:ncol(webtime)])

webtime["percent"] = webtime["sum_time"]/sum(webtime["sum_time"])

webtime_percent = webtime %>% arrange (desc(percent)) %>% select(Domain,percent) %>% filter(percent>0.001)

# write.csv(webtime_percent,"content/post/my2018/percent.csv")


percent <- read_csv("content/post/my2018/percent.csv")

percent.agg = percent %>% group_by(category) %>% summarise(time=sum(percent)) %>% arrange (desc(time))



ggplot(data=percent.agg,aes(x="",fill=category,y=time)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y",start = 1) +
  geom_text(aes(label = paste0(round(time*100), "%")), position = position_stack(vjust = 0.3),size=3.5,hjust = 0) + 
  xlab('') + ylab('') + 
theme_classic() + 
  theme(axis.line = element_blank(),
                        axis.text = element_blank(),
                        axis.ticks = element_blank(),
                        plot.title = element_text(hjust = 0.5, color = "#666666")) +
ggsave("content/post/my2018/timespent.png", width = 5, height = 5)




#####################################
## logged  Time 
#####################################
time_logger_report <- read_csv("content/post/my2018/time-logger-report.csv")
 
time_logger_report$Duration = as.numeric(time_logger_report$Duration)

colnames(time_logger_report)[1]="category"

time_logger_report$category[time_logger_report$category=="Games"]="Entertainment"


logged.time = time_logger_report %>% group_by(category) %>% 
  dplyr::filter(category!="Sleep") %>%
  dplyr::summarise(time=sum(Duration,na.rm = TRUE)) %>% 
  dplyr::mutate(percent = time/sum(time)) %>% 
  dplyr::arrange (desc(percent)) %>% 
  dplyr::filter(percent>0.01)%>% 
  dplyr::select(-time) 


ggplot(data=logged.time,aes(x="",fill=category,y=percent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", direction =1) +
  geom_text(aes(label = paste0(round(percent*100), "%")), position = position_stack(vjust = 0.5)) + 
  xlab('') + ylab('') + 
  theme_classic() + 
  ggtitle("Breakdown of an average day (17 hours)") + 
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        plot.title = element_text(hjust = 0.5, color = "#666666")) +
  ggsave("content/post/my2018/timelogged.png", width = 5, height = 5)



###############################################################################################################
########  Fitbit data  
###############################################################################################################



#####################################
## resting heart rate 
#####################################

library("rjson")


rest_heart.fitbit.json <- list.files(path="content/post/my2018/fitbit/rest_heart/", 
                               pattern = "json$",
                               full.names=TRUE)

library(jsonlite)
rest_heart17 = read_json(rest_heart.fitbit.json[1], simplifyVector = TRUE)
rest_heart18 = read_json(rest_heart.fitbit.json[2], simplifyVector = TRUE)

colnames(rest_heart17)


rest_heart17.value = as.data.frame(rest_heart17$value) %>% 
  dplyr::filter(value!=0 & !is.na(date) & error<25 ) 

rest_heart18.value = as.data.frame(rest_heart18$value) %>% 
  dplyr::filter(value!=0 & !is.na(date) & error<25) 


rest_heart = dplyr::bind_rows(rest_heart17.value,rest_heart18.value)

rest_heart$date = as.Date(rest_heart$date,"%m/%d/%y")


ggplot(data=rest_heart,aes(x=date,y=value)) +
  geom_line() +
  #geom_errorbar(aes(ymin=value-error, ymax=value+error), width=.2 , position=position_dodge(0.05)) + 
  geom_pointrange(aes(ymin=value-error, ymax=value+error)) +
xlab('Date') + ylab('Resting Heart Rate') + 
  theme_classic() + 
  ggtitle("Resting Heart Rate over time")  +
  geom_hline(yintercept =60,show.legend=TRUE) + 
  geom_hline(yintercept =90,show.legend=TRUE) + 
  geom_hline(yintercept =80,show.legend=TRUE) + 
 theme(legend.position = "bottom") +
  ggsave("content/post/my2018/rest_heart.png", width = 5, height = 5)

  






 
#########################
# Time in heart rate zone 
#########################

# heartzone.fitbit.json <- list.files(path="content/post/my2018/fitbit/heartzone/", 
#                                      pattern = "json$",
#                                      full.names=TRUE)
# 
# library(jsonlite)
# 
# JSONtoDF = function(file_path){
#   json.file = read_json(file_path,simplifyVector = TRUE)
#   df = as.data.frame(json.file$value$valuesInZones)
#   df["date"] = as.Date(json.file$dateTime,"%m/%d/%y")
#   return(df)
# }
# 
# heartzone.df = lapply(heartzone.fitbit.json, JSONtoDF) %>% dplyr::bind_rows()
# 
# ggplot(data=heartzone.df,aes(x=date)) +
  # geom_line(aes(y = IN_DEFAULT_ZONE_1, colour = "IN ZONE 1")) + 
  # geom_line(aes(y = IN_DEFAULT_ZONE_2, colour = "IN ZONE 2")) + 
  # geom_line(aes(y = IN_DEFAULT_ZONE_3, colour = "IN ZONE 3")) + 
  # geom_line(aes(y = BELOW_DEFAULT_ZONE_1, colour = "BELOW ZONE")) +
  #scale_y_continuous(sec.axis = sec_axis(~.*5, name = "seconds below heart zone")) + 

  #geom_errorbar(aes(ymin=value-error, ymax=value+error), width=.2 , position=position_dodge(0.05)) + 
   

  #########################
# heart rate  
#########################

# heart.rate.fitbit.json <- list.files(path="content/post/my2018/fitbit/heartrate/", 
#                                     pattern = "json$",
#                                     full.names=TRUE)
# 
# library(jsonlite)
# 
# JSONtoDF = function(file_path){
#   json.file = read_json(file_path,simplifyVector = TRUE)
#   df = as.data.frame(json.file$value)
#   df["date"] = as.Date(json.file$dateTime,"%m/%d/%y")
#   return(df)
# }
# 
# json.file = read_json(heart.rate.fitbit.json[[1]],simplifyVector = TRUE)
# 
# 
# heart.rate.df = lapply(heart.rate.fitbit.json, JSONtoDF) %>% dplyr::bind_rows()
# 
# 
# heart.rate.df.daily = heart.rate.df %>% group_by(date) %>% summarise_all(mean)
# heart.rate.df.vol = heart.rate.df %>% group_by(date) %>% summarise_all(sd)
# 
# 
# ggplot(data=heart.rate.df.daily,aes(x=date,y=bpm)) +
#   geom_line() +
#   #geom_errorbar(aes(ymin=value-error, ymax=value+error), width=.2 , position=position_dodge(0.05)) + 
#   geom_errorbar(aes(ymin=bpm-confidence, ymax=bpm+confidence), width=.2 , position=position_dodge(0.05)) +
#   xlab('Date') + ylab('average Heart Rate') + 
#   theme_classic() + 
#   ggtitle("Average Heart Rate over time")  +
#   ggsave("content/post/my2018/rest_heart.png", width = 5, height = 5)
# 


#########################
# sleep
#########################

sleep.fitbit.json <- list.files(path="content/post/my2018/fitbit/sleep/", 
                                     pattern = "json$",
                                     full.names=TRUE)

library(jsonlite)
JSONtoDF_sleep = function(file_path){
  json.file = read_json(file_path,simplifyVector = TRUE)
  df = as.data.frame(json.file[,1:13])
  summary = as.data.frame(json.file$levels$summary)
  summary.df = do.call(data.frame,summary)
  df = bind_cols(df,summary.df)
  return(df)
}
# json.file = read_json(sleep.fitbit.json[[1]],simplifyVector = TRUE)
# df = as.data.frame(json.file[,1:13])
# summary = as.data.frame(json.file$levels$summary)
# summary.df = do.call(data.frame,summary)


sleep.df = lapply(sleep.fitbit.json, JSONtoDF_sleep) %>% dplyr::bind_rows()
sleep.df$Date = as.Date.character(sleep.df$dateOfSleep)
sleep.df$weekday  = weekdays(sleep.df$Date)
sleep.df$weekend  = if_else(sleep.df$weekday=="Saturday"|sleep.df$weekday=="Sunday",true = "Weekends",false = "Weekdays")
sleep.df$month = format(sleep.df$Date,"%m")

plota = ggplot(data=sleep.df) +
  geom_boxplot(aes(x=month,y=minutesAsleep),fill="orange") +
  #    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
  xlab('') + ylab('Minutes asleep') +
  theme_classic() +
  ggtitle("Minutes asleep asleep by month") 

plotb = ggplot(data=sleep.df) +
  geom_boxplot(aes(x=month,y=efficiency),fill="light green") +
  #    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
  xlab('') + ylab('Sleep efficiency') +
  theme_classic() +
  ggtitle("Sleep efficiency asleep by month") 

grid.arrange(plota, plotb,ncol=2)





require(gridExtra)

plot1= ggplot(data=sleep.df) +
    geom_boxplot(aes(x=weekend,y=minutesAsleep),fill="light blue") +
#    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
    xlab('') + ylab('Minutes asleep') +
    theme_classic() +
  ggtitle("Minutes asleep by weekday and weekends") 

plot2= ggplot(data=sleep.df) +
  geom_boxplot(aes(x=weekend,y=minutesAwake),fill="light green") +
  #    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
  xlab('') + ylab('Minutes awake') +
  theme_classic() +
  ggtitle("Minutes awake by weekday and weekends") 

plot3 = ggplot(data=sleep.df) +
  geom_boxplot(aes(x=weekend,y=deep.minutes),fill = "black") +
 #  geom_boxplot(aes(x=weekend,y=light.minutes,color="light")) +
  #    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
  xlab('') + ylab('deep sleep') +
  theme_classic() +
  ggtitle("Minutes of deep sleep by weekday and weekends") 

plot4 = ggplot(data=sleep.df) +
  geom_boxplot(aes(x=weekend,y=efficiency),fill = "gray") +
  #    geom_boxplot(aes(x=weekend,y=minutesAsleep)) +
  xlab('') + ylab('Sleep efficiency') +
  theme_classic() +
  ggtitle("Sleep efficiency by weekday and weekends") 

grid.arrange(plot1, plot2, plot3, plot4,ncol=2, nrow=2)

    

#########################
# steps
#########################

steps.fitbit.json <- list.files(path="content/post/my2018/fitbit/steps/", 
                                pattern = "json$",
                                full.names=TRUE)
  
  #  ggsave("content/post/my2018/sleep_weekday.png", width = 5, height = 5)
library(jsonlite)
JSONtoDF_step = function(file_path){
  json.file = read_json(file_path,simplifyVector = TRUE)
  df = as.data.frame(json.file$value)
  df$`json.file$value`=as.numeric( df$`json.file$value`)
  df["date"] = as.Date(json.file$dateTime,"%m/%d/%y")
  return(df)
}

 steps.df = lapply(steps.fitbit.json, JSONtoDF_step) %>% dplyr::bind_rows()

 steps.df.daily = steps.df %>% group_by(date) %>% summarise_all(sum) 
 
 colnames(steps.df.daily)[2] = "steps"

 
 steps.df.daily = steps.df.daily %>% filter(steps > 50)
 
 steps.df.daily["month"] = format(steps.df.daily$date,"%m")
 
steps.df.daily$weekday  = weekdays(steps.df.daily$date)
 
steps.df.daily$weekend  = if_else(steps.df.daily$weekday=="Saturday"|steps.df.daily$weekday=="Sunday",true = "Weekends",false = "Weekdays")
 
 
 
 ggplot(data=steps.df.daily,aes(x=month,y=steps)) +
   geom_boxplot() +
   xlab('') + ylab('Steps') +
   theme_classic() +
   ggtitle("Steps by month") +
   ggsave("content/post/my2018/step_month.png", width = 5, height = 5)
 
 
sum(steps.df.daily$steps<10000)/nrow(steps.df.daily)
sum(steps.df.daily$steps<5000)/nrow(steps.df.daily)

 
 ggplot(data=steps.df.daily,aes(x=date,y=steps)) +
   geom_line() +
   xlab('') + ylab('Steps') +
   theme_classic() +
  annotate("text", x = as.Date("2018-06-01"), y = 25000, label = "80.98% of days are with inadequate steps") +
   annotate("text", x = as.Date("2018-06-01"), y = 20000, label = "34.42% of days are considered inactive") + 
   geom_hline(yintercept =10000) +
   geom_hline(yintercept =5000) +
   ggtitle("Daily steps over time")   +
   ggsave("content/post/my2018/step_daily.png", width = 5, height = 5)
 
   
 
 