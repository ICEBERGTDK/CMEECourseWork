rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
require(ggplot2)
require(ggthemes)
pdf("../results/PP_Regress.pdf")
p <- ggplot(MyDF,aes(x=log(Prey.mass), y=log(Predator.mass), colour = Predator.lifestage))+
  labs(x="Predator mass in grams",y="Prey mass in grams")+
  geom_point(shape = 3)+
  facet_grid(Type.of.feeding.interaction ~.)+
  geom_smooth(method = "lm", fullrange = T)+
  theme(legend.position = "bottom")+
  guides(col = guide_legend(nrow=1))
p
graphics.off()

Lifestage <- unique(MyDF$Predator.lifestage)
df <- data.frame()


for (l in 1:length(Lifestage)){
  sub_L <- subset(MyDF, Predator.lifestage == Lifestage[l])
  TOFI <- unique(sub_L$Type.of.feeding.interaction)
  for (t in 1:length(TOFI)) {
    sub_T <- subset(sub_L, Type.of.feeding.interaction == TOFI[t])
    if (length(unique(sub_T$Prey.mass))==1||length(unique(sub_T$Predator.mass))==1) {
      out <- summary(lm(log(Predator.mass)~log(Prey.mass), sub_T))
      df1 <- data.frame(R2 = out$r.squared,
                        f.value = NA,
                        p.value = NA,
                        Slope = out$coefficients[2],
                        Intercept = out$coefficients[1],
                        predator.lifestage = Lifestage[l],
                        Type.of.feeding.interaction = TOFI[t])
      df <- rbind(df,df1)
    }else{
      out <- summary(lm(log(Predator.mass)~log(Prey.mass), sub_T))
      df1 <- data.frame(R2 = out$r.squared,
                        f.value = as.numeric(out$fstatistic[1]),
                        p.value = out$coefficients[8],
                        Slope = out$coefficients[2],
                        Intercept = out$coefficients[1],
                        predator.lifestage = Lifestage[l],
                        Type.of.feeding.interaction = TOFI[t])
      df <- rbind(df,df1)
    }
    
    
    #if (nrow(sub_T)>2){
     # out <- summary(lm(log(Predator.mass)~log(Prey.mass), sub_T))
      #df1 <- data.frame(R2 = out$r.squared,
       #               f.value = as.numeric(out$fstatistic[1]),
        #              p.value = out$coefficients[8],
         #             Slope = out$coefficients[2],
          #            Intercept = out$coefficients[1],
           #           predator.lifestage = Lifestage[l],
            #          Type.of.feeding.interaction = TOFI[t])
      #df <- rbind(df,df1)
    #}
  }
}

df = write.csv(df, "../results/PP_Regress_Results.csv")


#sub_L <- subset(MyDF, Predator.lifestage == Lifestage[6])
#TOFI <- unique(sub_L$Type.of.feeding.interaction)
#sub_T <- subset(sub_L, Type.of.feeding.interaction == TOFI[6])
#out <- summary(lm(log(Predator.mass)~log(Prey.mass), sub_T))
#df1 <- data.frame(R2 = out$r.squared,
#                  f.value = as.numeric(out$fstatistic[1]),
#                  p.value = out$coefficients[8],
#                  Slope = out$coefficients[2],
#                  Intercept = out$coefficients[1],
#                  predator.lifestage = Lifestage[l],
#                  Type.of.feeding.interaction = TOFI[t])
#df1