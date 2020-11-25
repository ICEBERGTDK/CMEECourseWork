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
lm_growth <- lm(log(PopBio)~Time, current_df)
abline(lm_growth)
r = summary(lm_growth)$coefficients[2] #slope(growth rate)
Intercept = summary(lm_growth)$coefficients[1] #Intercept
R2 = summary(lm_growth)$r.square
#Using NLLS(logistic model)
logistic_model <- function(t,r_max,N_max,N_0){# The classic logistic equation
  return(N_0*N_max*exp(r_max*t)/(N_max+N_0*(exp(r_max*t)-1)))
}
  #first we need some starting parameters for the model
N_0_start <- min(current_df$PopBio)
N_max_start <- max(current_df$PopBio)
r_max_start <- 0.62
fit_logistic <- nlsLM(PopBio~logistic_model(t=Time,r_max, N_max, N_0), current_df, 
                      list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))

# Gompertz model
gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
}
N_0_start <- min(current_df$PopBio) # lowest population size, note log scale
K_start <- max(current_df$PopBio) # highest population size, note log scale
r_max_start <- 0.62 # use our previous estimate from the OLS fitting from above
t_lag_start <- current_df$Time[which.max(diff(diff(current_df$PopBio)))] # find last timepoint of lag phase
fit_gompertz <- nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), current_df,
                      list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start))
#compare these two models
timepoints <- seq(0, 800, 1)
logistic_points <- logistic_model(t=timepoints,
                                  r_max=coef(fit_logistic)["r_max"],
                                  N_max=coef(fit_logistic)["N_max"],
                                  N_0 = coef(fit_logistic)["N_0"])
gompertz_points <- gompertz_model(t = timepoints, 
                                  r_max = coef(fit_gompertz)["r_max"], 
                                  K = coef(fit_gompertz)["K"], 
                                  N_0 = coef(fit_gompertz)["N_0"], 
                                  t_lag = coef(fit_gompertz)["t_lag"])
df1 <- data.frame(timepoints, logistic_points)
df1$model <- "Logistic model"
names(df1) <- c("Time", "PopBio", "model")
df2 <- data.frame(timepoints, gompertz_points)
df2$model <- "Gompertz model"
names(df2) <- c("Time", "PopBio", "model")
model_frame <- rbind(df1, df2)
ggplot(current_df, aes(x = Time, y = PopBio)) +
  geom_point(size = 3) +
  geom_line(data = model_frame, aes(x = Time, y = PopBio, col = model), size = 1) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1)+ # make the plot square 
  labs(x = "Time", y = "log(PopBio)",title = Type[1])
  # AIC and BIC
AIC(fit_logistic,fit_gompertz)
BIC(fit_logistic,fit_gompertz)



