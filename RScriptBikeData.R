#Install required packages
install.packages("tidyverse")
library("tidyverse")



#Compare column names between files
#Names need to match perfectly in order to join into a single file
colnames(X202109_divvy_tripdata)
colnames(X202110_divvy_tripdata)
colnames(X202111_divvy_tripdata)
colnames(X202112_divvy_tripdata)
colnames(X202201_divvy_tripdata)
colnames(X202202_divvy_tripdata)
colnames(X202203_divvy_tripdata)
colnames(X202204_divvy_tripdata)
colnames(X202205_divvy_tripdata)
colnames(X202206_divvy_tripdata)
colnames(X202207_divvy_tripdata)
colnames(X202208_divvy_tripdata)
#All column names match, no need to make changes

#Inspect dataframes and look for incongruencies
str(X202109_divvy_tripdata)
str(X202110_divvy_tripdata)
str(X202111_divvy_tripdata)
str(X202112_divvy_tripdata)
str(X202201_divvy_tripdata)
str(X202202_divvy_tripdata)
str(X202203_divvy_tripdata)
str(X202204_divvy_tripdata)
str(X202205_divvy_tripdata)
str(X202206_divvy_tripdata)
str(X202207_divvy_tripdata)
str(X202208_divvy_tripdata)

#Convert started_at, ended_at. start_lat, start_lng, end_lat,  and end_lng to character in order to stack correctly
X202109_divvy_tripdata<- mutate(X202109_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202110_divvy_tripdata<- mutate(X202110_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202111_divvy_tripdata<- mutate(X202111_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202112_divvy_tripdata<- mutate(X202112_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202201_divvy_tripdata<- mutate(X202201_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202202_divvy_tripdata<- mutate(X202202_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202203_divvy_tripdata<- mutate(X202203_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202204_divvy_tripdata<- mutate(X202204_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202205_divvy_tripdata<- mutate(X202205_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202206_divvy_tripdata<- mutate(X202206_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202207_divvy_tripdata<- mutate(X202207_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))
X202208_divvy_tripdata<- mutate(X202208_divvy_tripdata,started_at = as.character(started_at),ended_at = as.character(ended_at),start_lat = as.character(start_lat),start_lng = as.character(start_lng),end_lat = as.character(end_lat),end_lng = as.character(end_lng))

#Stack monthly data frames to create one large data frame
bike_data <- rbind(X202109_divvy_tripdata, X202110_divvy_tripdata, 
                   X202111_divvy_tripdata, X202112_divvy_tripdata, 
                   X202201_divvy_tripdata, X202202_divvy_tripdata,
                   X202203_divvy_tripdata, X202204_divvy_tripdata, 
                   X202205_divvy_tripdata, X202206_divvy_tripdata, 
                   X202207_divvy_tripdata, X202208_divvy_tripdata)

#Inspect the newly created data frame
colnames(bike_data) #List of all column names
dim(bike_data) #What are the dimensions of the data frame?
head(bike_data) #View the first six rows of data
str(bike_data) #View a list of columns and data types 
summary(bike_data) #Statistical summary of data

#Add day_of_week, ride_month, ride_year, ride_time, time_start, time_end
bike_data <- bike_data %>% 
  mutate(day_of_week = weekdays(started_at, label = TRUE, abbr = TRUE),
         ride_month = month(started_at, label = TRUE, abbr = TRUE),
         ride_year = year(started_at),
         ride_time = hms::as_hms(ended_at - started_at),
         time_start = hms::as_hms(started_at),
         time_end = hms::as_hms(ended_at))

#View the first six rows of data
head(bike_data) 

#Find missing or null values
bike_data[bike_data == ""] <- NA #replace empty strings with NA
colSums(is.na(bike_data)) # view NA values

#Remove NA values
bike_data <- bike_data %>%
  drop_na(start_lat:end_lng)

colSums(is.na(bike_data))

#Identify rides less than or equal to 0 min
negative_rides <- bike_data %>% 
  filter(ride_time < 0) %>%
  count()

zero_rides <- bike_data %>% 
  filter(ride_time == 0) %>%
  count()

print(paste("There are ", negative_rides, " rides that started after they end time (negative ride time)"))
print(paste("There are ", zero_rides, " rides that lasted 0 seconds"))

#Remove 0 and negative rides
bike_data <- bike_data %>% 
  filter(ride_time >= 0)

#Convert data type for started_at and ended_at to datetime
bike_data$started_at <- as_datetime(bike_data$started_at, tz = NULL, format = NULL)
bike_data$ended_at <- as_datetime(bike_data$ended_at, tz = NULL, format = NULL)

#View the first six rows of data
head(bike_data) 

#Visualize number of rides per weekday
bike_data %>%
  ggplot(mapping = aes(x = day_of_week, fill = member_casual)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Rides per Weekday",
       fill = "Member Type",
       x = "Day of the Week", y = "Number of Rides")

#Visualize average duration by weekday
bike_data %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_time)) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_bar(position = "dodge") + 
  theme_minimal() +
  labs(title = "Average Ride Duration",
       fill = "Member Type",
       x = "Day of the Week", y = "Average Duration")

#Visualize number of rides by month
bike_data %>%
  ggplot(mapping = aes(x = ride_month, fill = member_casual)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Rides per Month",
       fill = "Member Type",
       x = "Ride Month", y = "Number of Rides")


