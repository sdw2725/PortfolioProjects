#View first 6 rows
head(diamonds)

#Visualize Diamond Price by Cut
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) +
  geom_point() +
  facet_wrap(~cut) + 
  labs(title = "Diamond Price by Cut")


#Visualize Diamond Cut & Clarity
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=clarity)) +
  labs(title = "Diamond Cut & Clarity")


#Visualize Diamond Color & Cut
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=color,fill=cut))+
  facet_wrap(~cut)+
  labs(title = "Diamond Color & Cut")


  
