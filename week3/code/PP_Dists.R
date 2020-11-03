rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
head(MyDF)
require(tidyverse)
dplyr::glimpse(MyDF)
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)

TOFI=unique(MyDF$Type.of.feeding.interaction)

pdf("../results/Pred_Subplots.pdf",11.7,8.3)
par(mfrow=c(1,5))
for (n in 1:length(TOFI)) {
  par(mfg=c(1,n))
  boxplot(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction==TOFI[n]]), xlab = TOFI[n],ylab = "log(mass)")
}
mtext("Predator Mass", side = 3, outer = T, line = -3)
graphics.off()

pdf("../results/Prey_Subplots.pdf",11.7,8.3)
par(mfrow=c(1,5))
for (n in 1:length(TOFI)) {
  par(mfg=c(1,n))
  boxplot(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==TOFI[n]]), xlab = TOFI[n],ylab = "log(mass)")
}
mtext("Prey Mass", side = 3, outer = T, line = -3)
graphics.off()

ratio_data = MyDF$Prey.mass/MyDF$Predator.mass
MyDF$ratio = ratio_data
pdf("../results/SizeRatio_Subplots.pdf",11.7,8.3)
par(mfrow=c(1,5))
for (n in 1:length(TOFI)) {
  par(mfg=c(1,n))
  boxplot(log(MyDF$ratio[MyDF$Type.of.feeding.interaction==TOFI[n]]), xlab = TOFI[n],ylab = "ratio")
}
mtext("Ratio", side = 3, outer = T, line = -3)
graphics.off()


df1 <- data.frame()
df2 <- data.frame()
df_final <- data.frame()
mean_pred <- c()
mean_prey <- c()
mean_ratio <- c()
median_pred <- c()
median_prey <- c()
median_ratio <- c()
for (i in 1:length(TOFI)){
  a1 <- mean(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  mean_pred <- c(mean_pred, a1)
  b1 <- median(log(MyDF$Predator.mass[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  median_pred <- c(median_pred, b1)
  a2 <- mean(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  mean_prey <- c(mean_prey, a2)
  b2 <- median(log(MyDF$Prey.mass[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  median_prey <- c(median_prey, b2)
  a3 <- mean(log(MyDF$ratio[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  mean_ratio <- c(mean_ratio, a3)
  b3 <- median(log(MyDF$ratio[MyDF$Type.of.feeding.interaction==TOFI[i]]))
  median_ratio <- c(median_ratio, b3)
}
df1=data.frame(mean_pred,mean_prey,mean_ratio)
df2=data.frame(median_pred,median_prey,median_ratio)
names(df1)[names(df1) == 'mean_pred'] <- 'Predator'
names(df1)[names(df1) == 'mean_prey'] <- 'Prey'
names(df1)[names(df1) == 'mean_ratio'] <- 'Ratio'
names(df2)[names(df2) == 'median_pred'] <- 'Predator'
names(df2)[names(df2) == 'median_prey'] <- 'Prey'
names(df2)[names(df2) == 'median_ratio'] <- 'Ratio'
df1$MeanOrMedian <- c("Mean","Mean","Mean","Mean","Mean")
df1$Type.of.feeding.interaction <- TOFI
df2$MeanOrMedian <- c("Median","Median","Median","Median","Median")
df2$Type.of.feeding.interaction <- TOFI
df_final <- rbind(df1,df2)
df_final = write.csv(df_final,"../results/PP_Results.csv")
