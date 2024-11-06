# creating a linear regression 
x <- c(1,2,3,4,8)
y <- c(4,3,5,7,9)
model1 <- (lm(y~x))
model1
summary(model1)
anova(model1)
resid(model1)
cov(x,y)
var(x,y)
plot(y~x)
abline(model1, col = "blue")




y<-c(5,3,6,11,0)
x<-c(3,1,4,8,2)
model2<-lm(y~x)
predict(model2)
help(predict)









#ho6, week5
#install.packages("WebPower")
require(WebPower)
y<-rnorm(51,mean=1,sd=1.3)
x=seq(from=0, to=5, by=0.1)
length(x)
plot(hist(y, breaks = 10), col="lightblue")
mean(y)
sd(y)
# add a line to the plot at the mean value
segments(x0=(mean(y)), y0=(0), x1=(mean(y)), y1=40, lty = 1, lwd = 5, col="pink")
# add a ine at 0.25 sd left of the mean
segments(x0=(mean(y)+0.25*sd(y)), y0=0, x1=(mean(y)+0.25*sd(y)), y1=40, lty = 1, lwd = 3, col="pink")
# add a ine at 0.25 sd right of the mean
segments(x0=(mean(y)-0.25*sd(y)), y0=0, x1=(mean(y)-0.25*sd(y)), y1=40, lty = 1, lwd = 3, col="pink")

# two tailed ttest
wp.t(d=0.11, power=0.8, type="two.sample", alternative="two.sided")

# power curve
res.1<-wp.t(n1=seq(20,300,20), n2=seq(20,300,20), d=0.25, type="two.sample.2n", alternative = "two.sided")
res.1
plot(res.1, xvar="n1", yvar="power")

x<-seq(0,15,0.2)
y=-1+2*x-0.15*x^2
plot(y~x)
max(y)
