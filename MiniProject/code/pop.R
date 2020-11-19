rm(list = ls())
setwd("~/Documents/CMEECourseWork/MiniProject/code/")
require(ggplot2)
require(minpack.lm)
data1 <- read.csv("../data/LogisticGrowthData.csv")
data2 <- read.csv("../data/LogisticGrowthMetaData.csv")
Type <- unique(data1$Species)

current_df <- data1[which(data1$Species==Type[1]),]
plot(current_df$Time, log(current_df$PopBio), xlab = "Time", ylab = "log(PopBio)")
#Using OLS
lm_growth <- lm(log(PopBio)~poly(Time,0.5), current_df)
abline(lm_growth)
r = summary(lm_growth)$coefficients[2] #slope(growth rate)
Intercept = summary(lm_growth)$coefficients[1] #Intercept
R2 = summary(lm_growth)$r.square
#Using NLLS
logistic_model <- function(t,r_max,N_max,N_0){# The classic logistic equation
  return(N_0*N_max*exp(r_max*t)/(N_max+N_0*(exp(r_max*t)-1)))
}
#first we need some starting parameters for the model
N_0_start <- min(current_df$PopBio)
N_max_start <- max(current_df$PopBio)
r_max_start <- 0.62
fit_logistic <- nlsLM(PopBio~logistic_model(t=Time,r_max, N_max, N_0), current_df, 
                      list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))
summary(fit_logistic)
timepoints <- seq(0,800,1)
logistic_points <- logistic_model(t=timepoints,
                                 r_max=coef(fit_logistic)["r_max"],
                                 N_max=coef(fit_logistic)["N_max"],
                                 N_0 = coef(fit_logistic)["N_0"])
df1 <- data.frame(timepoints, logistic_points)
df1$model <- "logistic equation"
names(df1) <- c("Time", "N", "model")
ggplot(current_df, aes(x=Time,y=PopBio))+
  geom_point(size=3)+
  geom_line(data=df1,aes(x=Time,y=N,col=model),size=1)+
  theme(aspect.ratio = 1)+
  labs(x="Time",y="log(PopBio)")
