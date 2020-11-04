rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF)
head(MyDF)
require(tidyverse)
dplyr::glimpse(MyDF)
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
plot(MyDF$Predator.mass,MyDF$Prey.mass)
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20)
plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20,xlab="Predator Mass",ylab="Prey Mass (g)")
hist(MyDF$Predator.mass)
hist(log10(MyDF$Predator.mass),xlab="log10(Predator Mass", ylab = "Count")
hist(log(MyDF$Predator.mass),xlab="log10(Predator Mass",ylab = "Count",col = "lightblue", border = "pink")


par(mfcol=c(2,1))
par(mfg=c(1,1))
hist(log10(MyDF$Predator.mass),
     xlab = "log10(Predator Mass", ylab = "Count", col = "lightblue",border = "pink",
     main = "Predator")
par(mfg=c(2,1))
hist(log10(MyDF$Prey.mass),xlab = "log10(Prey Mass", ylab = "Count", col = "lightgreen", border = "pink", main = "prey")


hist(log10(MyDF$Predator.mass), xlab = "log10(Body Mass", col = rgb(1,0,0,0.5), main = "Predator-Prey size Overlap")
hist(log10(MyDF$Prey.mass), col = rgb(0,0,1,0.5), add = T)
legend('topleft',c('Predators','Prey'), fill = c(rgb(1,0,0,0.5),rgb(0,0,1,0.5)))


boxplot(log10(MyDF$Predator.mass), xlab = "Location", ylab = "log10(Predator Mass)", main = "Predator mass")
boxplot(log(MyDF$Predator.mass)~MyDF$Location, xlab = "Location", ylab = "Predator Mass", main = "Predator mass by location")
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction, xlab = "Location", ylab = "Predator mass by feeding interaction type")


par(fig=c(0,0.8,0,0.8))
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass), xlab = "Predator Mass (g)", ylab = "Prey Mass (g)")
par(fig=c(0,0.8,0.4,1),new=T)
boxplot(log(MyDF$Predator.mass), horizontal = T, axes = F)
par(fig=c(0.55,1,0,0.8),new=T)
boxplot(log(MyDF$Prey.mass), axes = F)
mtext("Fancy Predator-prey scatterplot", side = 3, outer = T, line = -3)

pdf("../results/Pred_Prey_Overlay.pdf",11.7,8.3)
hist(log(MyDF$Predator.mass),xlab = "Body Mass", ylab = "Count", col = rgb(1,0,0,0.5), main = "Predator-Prey Size Overlap")
hist(log(MyDF$Prey.mass), col = rgb(0,0,1,0.5),add = T)
legend("topleft", c("Predators","Prey"), fill = c(rgb(1,0,0,0.5),rgb(0,0,1,0.5)))
graphics.off()


require(ggplot2)
qplot(Prey.mass, Predator.mass, data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction, asp = 1)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"))
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"))+ geom_smooth(method = "lm")
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"), colour = Type.of.feeding.interaction)+geom_smooth(method = "lm")
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "jitter")
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram")
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction)

qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction, 
      alpha = I(0.5))
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      colour = Type.of.feeding.interaction)
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data = MyDF, geom =  "density")
qplot(log(Prey.mass/Predator.mass), facets =  .~ Type.of.feeding.interaction, data = MyDF, geom =  "density")

qplot(Prey.mass, Predator.mass, data = MyDF, log="xy")
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
      main = "Relation between predator and prey mass", 
      xlab = "log(Prey mass) (g)", 
      ylab = "log(Predator mass) (g)")
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
      main = "Relation between predator and prey mass", 
      xlab = "Prey mass (g)", 
      ylab = "Predator mass (g)") + theme_bw()

pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
            main = "Relation between predator and prey mass", 
            xlab = "log(Prey mass) (g)", 
            ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()

p <- ggplot(MyDF, aes(x = log(Predator.mass),
                      y = log(Prey.mass),
                      colour = Type.of.feeding.interaction))
p + geom_point()
q <- p + 
  geom_point(size=I(2), shape=I(10)) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1) # make the plot square
q
q+theme(legend.position = "none") + theme(aspect.ratio = 1)
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density(alpha=0.5)
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()+facet_wrap( .~Type.of.feeding.interaction)
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()+facet_wrap(.~Type.of.feeding.interaction, scales = "free")
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass)))+geom_density()+facet_wrap( .~Location, scales = "free")
p
p <- ggplot(MyDF,aes(x=log(Prey.mass),y=log(Predator.mass)))+geom_point()+facet_wrap( .~Location, scales = "free")
p
p <- ggplot(MyDF,aes(x=log(Prey.mass),y=log(Predator.mass)))+geom_point()+facet_wrap( .~Location + Type.of.feeding.interaction, scales = "free")
p


require(reshape2)
GenerateMatrix <- function(N){
  M <- matrix(runif(N*N),N,N)
  return(M)
}
M <- GenerateMatrix(10)
Melt <- melt(M)
p <- ggplot(Melt, aes(Var1, Var2, fill = value)) + geom_tile() + theme(aspect.ratio = 1)
p
p + geom_tile(colour = "black") + theme(aspect.ratio = 1)
p + theme(legend.position = "none")
p + scale_fill_continuous(low = "yellow", high = "darkgreen")
p + scale_fill_gradient2()
p + scale_fill_gradientn(colours = grey.colors(10))
p + scale_fill_gradientn(colours = rainbow(10))
p + scale_fill_gradientn(colours = c("red", "white", "blue"))


build_ellipse <- function(hradius, vradius){
  npoints = 250
  a <- seq(0, 2 * pi , length = npoints +1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)
  return(data.frame(x=x,y=y))
}
N <- 250
M <- matrix(rnorm(N*N),N,N)
eigvals <- eigen(M)$values
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals))
my_radius <- sqrt(N)
ellDF <- build_ellipse(my_radius, my_radius)
names(ellDF) <- c("Real", "Imaginary")
p <- ggplot(eigDF,aes(x=Real,y=Imaginary))
p <- p + geom_point(shape = I(3)+ theme(legend.position = "none"))
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))
p <- p + geom_polygon(data = ellDF, aes(x=Real,y=Imaginary,alpha = 1/20, fill = "red"))
p

a <- read.table("../data/Results.txt", header = T)
a$ymin <- rep(0,dim(a)[1])
p <- ggplot(a)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y1, size=(0.5)), colour = "#E69F00", alpha=1/2, show.legend = F)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y2, size=(0.5)), colour = "#56B4E9", alpha=1/2, show.legend = F)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y3, size=(0.5)), colour = "#D55E00", alpha=1/2, show.legend = F)
p <- p + geom_text(data = a, aes(x=x, y=-500, label = Label))
p <- p + scale_x_continuous("My x axis", breaks = seq(3,5,by=0.05))+ scale_y_continuous("My y axis") + theme_bw() + theme(legend.position = "none")
p


x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x +
  rnorm(length(x), mean = 0., sd = 2.5)

# and put them in a dataframe
my_data <- data.frame(x = x, y = y)

# perform a linear regression
my_lm <- summary(lm(y ~ x, data = my_data))

# plot the data
p <-  ggplot(my_data, aes(x = x, y = y,
                          colour = abs(my_lm$residual))
) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(
    expression(alpha^2 * pi / beta * sqrt(Theta)))

# add the regression line
p <- p + geom_abline(
  intercept = my_lm$coefficients[1][1],
  slope = my_lm$coefficients[2][1],
  colour = "red")
# throw some math on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2* pi"), 
                   parse = TRUE, size = 6, 
                   colour = "blue")
p

library(ggthemes)

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass),
                      colour = Type.of.feeding.interaction )) +
  geom_point(size=I(2), shape=I(10)) + theme_bw()

p + geom_rangeframe() + # now fine tune the geom to Tufte's range frame
  theme_tufte() # and theme to Tufte's minimal ink theme    
p
