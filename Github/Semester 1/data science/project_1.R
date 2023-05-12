####Assess and clean your data if needed
install.packages("readxl")
library("readxl")
library(dplyr)
data_set <-read_excel("..\\Project_1\\grc.xls")
data_set
###Useadifferent type of Data Visualization tools for each of the following
     ##   install.packages("dplyr")
library(dplyr)
#Compare cash and credit totals.
table(data_set$paymentType)
pie(
    x=table(data_set$paymentType),
      main="Compare cash and credit totals"
)

#Compare each age and sum of total spending.
total_by_age<-group_by(data_set,age)
total_by_age<- summarise(total_by_age,sum_total=sum(total))
barplot(
  height = total_by_age$age,
  name=total_by_age$sum_total ,
  col= "skyblue",
  main="Compare each age and sum of total spending",
  xlab="Age",
  ylab="Totals",
  horiz = TRUE ,
  las = 1,
)
###another sol
total_by_age<-group_by(data_set,age)
total_by_age<- summarise(total_by_age,sum_total=sum(total))
plot(
  x= total_by_age$age,
  y =total_by_age$sum_total ,
  xlab="Age" ,
  ylab="total" ,
  main="Compare each age and sum of total spending",
)

##Show each city total spending and arrange it by total descending.
total_by_city<-group_by(data_set,city)
total_by_city<- summarise(total_by_city,sum_total=sum(total))
total_by_city_arrange<- arrange(total_by_city,desc(sum_total))
barplot(
  height = total_by_city_arrange$sum_total,
  name=total_by_city_arrange$city ,
  col= "orange",
  main="Show each city total spending and arrange it by total descending.",
  xlab="Total",
  ylab="Cities",
  horiz = TRUE ,
 las = 1,
)

###The distribution of total spending
boxplot(
  x=data_set$total,
  xlab="Total",
  main="The distribution of total spending"
  )
#all previous plots in one dashboard
par(mfrow=c(3,2))
pie(
  x=table(data_set$paymentType),
  main="Compare cash and credit totals"
)

barplot(
  height = total_by_age$age,
  name=total_by_age$sum_total ,
  col= "blue",
  main="Compare each age and sum of total spending",
  xlab="Age",
  ylab="Totals",
  horiz = TRUE ,
  las = 1,
)
barplot(
  height = total_by_city_arrange$sum_total,
  name=total_by_city_arrange$city ,
  col= "orange",
  main="Show each city total spending and arrange it by total descending.",
  xlab="Totals",
  ylab="Cities",
  horiz = TRUE ,
  las = 1,
)
boxplot(
  x=data_set$total,
  xlab="Total",
  main="The distribution of total spending"
)
plot(
  x= total_by_age$age,
  y =total_by_age$sum_total ,
  xlab="Age" ,
  ylab="total" ,
  main="Compare each age and sum of total spending",
)

###Split the customers to (n)groupsusing one of the studied methods (n will be user input) according to the sum of total spending and their ages and print a table displayingeach customer name, age, total and the computed cluster number.
### install.packages("dplyr")
library(dplyr)
library(cluster)
clusters <- as.integer(readline("Enter number of clusters(between 2 and 4): "))
if (clusters > 1 & clusters < 5 ) {
  new_data <- select(data_set,total,age)
  final_data <-kmeans(new_data,clusters)
  final_data <- final_data$cluster
  final_data <- data.frame(select(data_set,age,total,customer),group = final_data)
 head(final_data) 
}else
  print("wrong number of cluster")


###Generateassociation  rules  between  item
### install.packages("arules")
library(arules)
min_supp<-as.numeric(readline("Enter Number of min_supp"))
min_conf<-as.numeric(readline("Enter Number of min_conf"))
if((min_supp>0.001 & min_supp<1)&(min_conf>0.001 & min_conf<1)){
  tdata <-read.transactions("..\\Project_1\\new .txt",sep=",")
  apriori_rules <- apriori(tdata,parameter=list(supp= min_supp ,conf= min_conf,minlen=2))
  inspect(apriori_rules) 
}else{
  print("Enter the input correct")
}

