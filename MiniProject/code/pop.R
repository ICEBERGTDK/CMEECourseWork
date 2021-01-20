rm(list = ls())
setwd("~/Documents/CMEECourseWork/MiniProject/code/")
require(ggplot2)
require(minpack.lm)
data1 <- read.csv("../data/GrowthData.csv")
data2 <- read.csv("../data/LogisticGrowthMetaData.csv")
la <- 0
ga <- 0
lb <- 0
gb <- 0
Type <- unique(data1$ID)
pdf("../results/PopBio.pdf")
for (i in 1:length(Type)){
  print(i)
  current_df <- data1[which(data1$ID==Type[i]),]
  #Using OLS
  #plot(current_df$Time, log(current_df$PopBio), xlab = "Time", ylab = "log(PopBio)")
  #title(Type[i])
  tryCatch({
    lm_growth <- lm(log(PopBio)~Time, current_df)
  },
  error=function(e){})
  #abline(lm_growth)
  r = summary(lm_growth)$coefficients[2] #slope(growth rate)
  Intercept = summary(lm_growth)$coefficients[1] #Intercept
  R2 = summary(lm_growth)$r.square #R square
  #Using NLLS(logistic model)
  logistic_model <- function(t,r_max,N_max,N_0){# The classic logistic equation
    return(N_0*N_max*exp(r_max*t)/(N_max+N_0*(exp(r_max*t)-1)))
  }
  #first we need some starting parameters for the model
  N_0_start <- min(current_df$PopBio)
  N_max_start <- max(current_df$PopBio)
  r_max_start <- r
  tryCatch({
    fit_logistic <- nlsLM(PopBio~logistic_model(t=Time,r_max, N_max, N_0), current_df, 
                          list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))
  },
  error=function(e){})
  
  # Gompertz model
  gompertz_model <- function(t, r_max, K, N_0, t_lag){ # Modified gompertz growth model (Zwietering 1990)
    return(N_0 + (K - N_0) * exp(-exp(r_max * exp(1) * (t_lag - t)/((K - N_0) * log(10)) + 1)))
  }
  N_0_start <- min(current_df$PopBio) # lowest population size, note log scale
  K_start <- max(current_df$PopBio) # highest population size, note log scale
  r_max_start <- r # use our previous estimate from the OLS fitting from above
  t_lag_start <- current_df$Time[which.max(diff(diff(current_df$PopBio)))] # find last timepoint of lag phase
  tryCatch({
    fit_gompertz <- nlsLM(PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), current_df,
                          list(t_lag=t_lag_start, r_max=r_max_start, N_0 = N_0_start, K = K_start))
  },
  error=function(e){})
  
  # Baranyi model
  #Baranyi_model <- function(t, r_max, N_0, t_lag, N_max){
  #  h_0 = 1 / (exp(t_lag * r_max) - 1)
  #  A_t = t + 1 / r_max * log((exp(-r_max * t) + h_0) / (1 + h_0))
  #  model = N_0 * A_t - log(1 + (exp(r_max * A_t) - 1) / exp(N_max - N_0))
  #}
  #N_0_start <- min(current_df$PopBio) # lowest population size, note log scale
  #N_max_start <- max(current_df$PopBio) # highest population size, note log scale
  #r_max_start <- 0.395 # use our previous estimate from the OLS fitting from above
  #t_lag_start <- current_df$Time[which.max(diff(diff(current_df$PopBio)))] # find last timepoint of lag phase
  #fit_Baranyi <- nlsLM(PopBio~Baranyi_model(t=Time,r_max, N_max, N_0, t_lag), current_df, 
  #                     list(r_max=r_max_start, N_0=N_0_start, N_max=N_max_start, t_lag=t_lag_start))
  
  #compare these models
  timepoints <- seq(min(current_df$Time), max(current_df$Time), (max(current_df$Time)-min(current_df$Time))/100)
  logistic_points <- logistic_model(t=timepoints,
                                    r_max=coef(fit_logistic)["r_max"],
                                    N_max=coef(fit_logistic)["N_max"],
                                    N_0 = coef(fit_logistic)["N_0"])
  gompertz_points <- gompertz_model(t = timepoints, 
                                    r_max = coef(fit_gompertz)["r_max"], 
                                    K = coef(fit_gompertz)["K"], 
                                    N_0 = coef(fit_gompertz)["N_0"], 
                                    t_lag = coef(fit_gompertz)["t_lag"])
  #Baranyi_points <- Baranyi_model(t=timepoints,
  #                                r_max=coef(fit_Baranyi)["r_max"],
  #                               N_max=coef(fit_Baranyi)["N_max"],
  #                                N_0 = coef(fit_Baranyi)["N_0"],
  #                                t_lag=coef(fit_Baranyi)["t_lag"])
  df1 <- data.frame(timepoints, logistic_points)
  df1$model <- "Logistic model"
  names(df1) <- c("Time", "PopBio", "model")
  df2 <- data.frame(timepoints, gompertz_points)
  df2$model <- "Gompertz model"
  names(df2) <- c("Time", "PopBio", "model")
  #df3 <- data.frame(timepoints, Baranyi_points)
  #df3$model <- "Baranyi model"
  #names(df3) <- c("Time", "PopBio", "model")
  model_frame <- rbind(df1, df2)
  
  # AIC and BIC
  AIC <- AIC(fit_logistic,fit_gompertz)
  AIC$model <- c("Logistic","Gompertz")
  minAIC <- AIC$model[AIC$AIC==min(AIC$AIC)]
  if (minAIC == "Logistic"){
    la <- la + 1
  }else{
    ga <- ga +1
  }
  BIC <- BIC(fit_logistic,fit_gompertz)
  BIC$model <- c("Logistic","Gompertz")
  minBIC <- BIC$model[BIC$BIC==min(BIC$BIC)]
  if (minBIC == "Logistic"){
    lb <- lb + 1
  }else{
    gb <- gb +1
  }
  
  print(ggplot(current_df, aes(x = Time, y = PopBio)) +
    geom_point(size = 3) +
    geom_line(data = model_frame, aes(x = Time, y = PopBio, col = model), size = 1) +
    geom_smooth(method = "lm", formula = y~x) +
    annotate("text",x=max(current_df$Time)*3/4,y=max(current_df$PopBio)/10,label=paste("minAIC=",min(AIC$AIC)," ",minAIC)) +
    annotate("text",x=max(current_df$Time)*3/4,y=max(current_df$PopBio)/20,label=paste("minBIC=",min(BIC$BIC)," ",minBIC)) +
    theme_bw() + # make the background white
    theme(aspect.ratio=1)+ # make the plot square 
    labs(x = "Time", y = "PopBio",title = Type[i]))
  
}
graphics.off()

if (la > ga){
  print("Logistic is better in AIC.")
}else{
  print("Gompertz is better in AIC.")
}
if (lb > gb){
  print("Logistic is better in BIC.")
}else{
  print("Gompertz is better in BIC.")
}




