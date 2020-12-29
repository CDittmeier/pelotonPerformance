# copy of the first chunk in the Rmd file in case the user is uninterested in visualization 

library(prettydoc)
library(pelotonR)
library(tidyverse)
library(lubridate)
library(ggthemes)
library(scales)
library(zoo)
library(kableExtra)
library(ggTimeSeries)
library(ggimage)
library(ggrepel)
library(DT)

Sys.setenv("PELOTON_LOGIN" = "Username")
Sys.setenv("PELOTON_PASSWORD" = "Password")

peloton_auth()

# ----------------------- get data about yourself

me <- get_my_info() # peloton_api("api/me")
user_id <- me$id

# ---------------- GET

# pel <- get_all_workouts2(user_id, num_workouts = (me$total_workouts - 9))

pel_workouts <- get_all_workouts(user_id, num_workouts = me$total_workouts - 10, joins = "ride,ride.instructor")



pel_perf <- data.frame() # creating empty df

for (i in 1:nrow(pel_workouts)) {
  one_ride <- pel_workouts[i, ]
  Sys.sleep(.2) # Maxing api calls to 5/sec
  one_ride <- pel_workouts[i, ] %>% bind_cols(get_workouts_data(one_ride$id))
  pel_perf <- rbind(pel_perf, one_ride)  #get_workout_data() only works well one at a time 
  
}


# Correcting names and adding fields to data ----------------------

pel_workouts2 <- pel_perf %>%
  rename(init_ride_id = id...8, workout_name = name...11, ride_user_id = user_id...20) %>%
  tidyr::unnest_wider(ride_instructor) %>%
  mutate(mins_on_bike = total_video_watch_time_seconds...102 / 60) %>%
  mutate(ride_date = lubridate::date(created_at...1), ride_rank = as.numeric(leaderboard_rank), percentile = ride_rank / total_leaderboard_users) %>%
  mutate(ins_image = paste0("<img src='", image_url, "' height='32' ></img>")) %>%
  mutate(type_emoji = case_when(
    str_detect(ride_title, "Cool Down") ~ paste("Cool down ", emo::ji("snow")),
    ride_fitness_discipline == "cycling" ~ paste("Cycling ", emo::ji("bike")),
    ride_fitness_discipline == "strength" ~ paste("Strength ", emo::ji("flex")),
    ride_fitness_discipline == "running" ~ paste("Run ", emo::ji("running")),
    ride_fitness_discipline == "running" ~ paste("Run ", emo::ji("exercise")),
    TRUE ~ ride_fitness_discipline
  )) %>%
  mutate(Duration = as.factor(paste((ride_duration / 60), "mins"))) %>%
  mutate(PR_flag = case_when(
    is_total_work_personal_record...9 == TRUE ~ paste("PR!", emo::ji("award")),
    TRUE ~ ""
  )) %>%
  mutate(average_output = round(total_work...19 / ride_pedaling_duration), total_output = round(total_work...19 / 1000)) %>%
  mutate(weekday = factor(format(as.Date(created_at...1), "%a"), levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")))


# Summarized workout total time by date  ----------------------

workout_plot_data <- pel_workouts2 %>%
  mutate(mins_on_bike = total_video_watch_time_seconds...102 / 60) %>%
  mutate(ride_date = lubridate::date(created_at...1)) %>%
  rename(ride_id2 = init_ride_id, workout_name2 = name) %>%
  group_by(ride_date) %>%
  summarise(total_mins_on_bike = sum(mins_on_bike))


# Data frame grouped by instructor  ----------------------

by_teacher <- pel_workouts2 %>%
  group_by(name, image_url) %>%
  summarise(classes = n(), total_mins = sum(mins_on_bike), avg_rating = mean(ride_difficulty_rating_avg), avg_ouput = mean(average_output, na.rm = TRUE)) %>%
  mutate(ins_image = paste0("<img src='", image_url, "' height='32' ></img>")) %>%
  arrange(desc(classes))

pel_workouts3 <- pel_workouts2 %>%
  filter(ride_fitness_discipline == "cycling", !Duration %in% c("5 mins", "10 mins", "15 mins", "20 mins")) # this is to isolate longer cycling workouts


by_teacher2 <- pel_workouts3 %>%
  group_by(name, image_url) %>%
  summarise(classes = n(), total_mins = sum(mins_on_bike), avg_rating = mean(ride_difficulty_rating_avg), avg_ouput = round(mean(average_output, na.rm = TRUE))) %>%
  mutate(ins_image = paste0("<img src='", image_url, "' height='32' ></img>")) %>%
  arrange(desc(avg_ouput)) # teacher totals for longer cycling workouts
