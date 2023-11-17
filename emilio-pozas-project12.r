library(data.table)
options(jupyter.rich_display = F)
options(repr.matrix.max.cols = 30, repr.matrix.max.rows = 200)
orders <- fread("/anvil/projects/tdm/data/restaurant/orders.csv")

head(orders$created_at)
table(year(orders$created_at))
table(month(orders$created_at))
table(wday(orders$created_at))
table(substr(orders$created_at,1,7))
table(paste(year(orders$created_at),month(orders$created_at),sep="-"))
table(format(orders$created_at, "%m-%Y"))

tail(sort(table(orders$customer_id)))
sort(table(format(orders$created_at[orders$customer_id == "XW90EAP"],"%m-%Y")), decreasing =TRUE)

table(orders$payment_mode)
table(orders$payment_mode[orders$customer_id == "XW90EAP"])

ordersJan2020 <- subset(orders, format(created_at,  "%m-%Y") == "01-2020") 
head(ordersJan2020)
ordersJan2020$day_of_week <- weekdays(ordersJan2020$created_at)
sum_grand_total <- aggregate(grand_total ~ day_of_week, ordersJan2020, sum)
sum_grand_total$day_of_week <- factor(sum_grand_total$day_of_week, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
plot(sum_grand_total$day_of_week, sum_grand_total$grand_total, col = "blue", 
     xlab = "Day of the Week", ylab = "Sum of Grand Total",
     main = "Sum of Grand Total for Each Day of the Week")