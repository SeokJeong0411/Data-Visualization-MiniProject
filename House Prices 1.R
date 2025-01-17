library('ggplot2')
library('ggthemes') 
library('scales')
library('dplyr') 
library('mice')
library('randomForest') 
library('data.table')
library('gridExtra')
library('corrplot') 
library('GGally')
library('e1071')
library(corrplot)

getwd()
train <-read.csv('./house-prices-advanced-regression-techniques/train.csv', stringsAsFactors = F)
test  <-read.csv('./house-prices-advanced-regression-techniques/test.csv', stringsAsFactors = F)



#test ?°?΄?°?? ?? SalePrice μ»¬λΌ λ§λ€?΄μ£ΌκΈ°
test$SalePrice<-rep(NA,1459)

#?? ? Έ ?? train ,test??Ό? ??λ‘? ?©μΉ?
house<-bind_rows(train,test)

dim(test)
dim(train)
dim(house)

#?©μΉ? ?°?΄?°? integerκ°λ€? summary ??Έ
summary(house[,sapply(house[,1:81], typeof) == "integer"])
house.describe().T

# hose κ°κ²? λΆ?¬
p1 = ggplot(house, aes(x = SalePrice)) +
    geom_histogram(aes(x = SalePrice, stat(density)),
                   bins = 100,
                   fill = "orange",
                   alpha = 0.7) +
    geom_density(color = "blue") +
    scale_x_continuous(breaks= seq(0, 800000, by=100000),
                       labels = scales::comma) +
    labs(x = "?λ§? κ°κ²?", y = "λΉμ¨", title = "μ§κ° κ±°λκ° λΆν¬?")
p1

# μ£Όκ±°?© μ§?κ³΅κ°? ??΄?? κ°κ²?
p2 = ggplot(house,aes(x = GrLivArea, y = SalePrice)) +
    geom_point(color = "orange", alpha = 0.75, size = 2) +
    geom_smooth(mapping=aes(x=GrLivArea, y=SalePrice), data=house) +
    scale_y_continuous(breaks= seq(0, 800000, by=200000), 
                       labels = scales::comma) +
    labs(x = "μ£Όκ±°?© μ§?κ³΅κ°? ??΄", y = "?λ§? κ°κ²?", 
         title = "Sale Price by Above Ground Living Area")
p2


##?«?κ°? ?? ?΄λ§? ?°λ‘λ½κΈ? 
house_p = house[c(2,4,5,18,19,20,21,27,35,37,38,39,44,45,46,47,48,49,50,
                  51,52,53,55,57,60,62,63,67,68,69,70,71,72,76,77,78)]
cor1 = cor(house_p)

#κ²°μΈ‘μΉ? ? κ±?
corr1 = cor(na.omit(house_p))

corrplot(corr1 , method = "square")


##pκ°? κ΄κ³? ?°?΄ λ§? ?°λ‘? λ½κΈ°
house_r = house[c(2,4,5,18,27,35,39,44,45,48,50,51,52,
                  53,55,57,60,62,63,67,68,71,72)]
cor2 = cor(house_r)

corr2 = cor(na.omit(house_r))

corrplot(corr2, method ="square", type ="lower")
corrplot(corr2, order = "hclust", addrect = 2, col = c("white", "black") , bg="gold2")























