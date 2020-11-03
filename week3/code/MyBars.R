pdf("../results/MyBars.pdf")

p <- ggplot(MyDF, aes(x = log(Predator.mass),
                      y = log(Prey.mass),
                      colour = Type.of.feeding.interaction))
p + geom_point()
q <- p + 
  geom_point(size=I(2), shape=I(10)) +
  theme_bw() + # make the background white
  theme(aspect.ratio=1) # make the plot square
q
plot(q)

q+theme(legend.position = "none") + theme(aspect.ratio = 1)
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density(alpha=0.5)
p
plot(p)
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()+facet_wrap( .~Type.of.feeding.interaction)
p
plot(p)
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass), fill = Type.of.feeding.interaction))+geom_density()+facet_wrap(.~Type.of.feeding.interaction, scales = "free")
p
p <- ggplot(MyDF,aes(x=log(Prey.mass/Predator.mass)))+geom_density()+facet_wrap( .~Location, scales = "free")
p
plot(p)
p <- ggplot(MyDF,aes(x=log(Prey.mass),y=log(Predator.mass)))+geom_point()+facet_wrap( .~Location, scales = "free")
p
plot(p)
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
plot(p)
p + geom_tile(colour = "black") + theme(aspect.ratio = 1)
p + theme(legend.position = "none")
p + scale_fill_continuous(low = "yellow", high = "darkgreen")
p + scale_fill_gradient2()
p + scale_fill_gradientn(colours = grey.colors(10))
p + scale_fill_gradientn(colours = rainbow(10))
p + scale_fill_gradientn(colours = c("red", "white", "blue"))


build_ellipse <- function(hradius, vradius){ # function that returns an ellipse
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)  
  return(data.frame(x = x, y = y))
}
N <- 250 # Assign size of the matrix

M <- matrix(rnorm(N * N), N, N) # Build the matrix

eigvals <- eigen(M)$values # Find the eigenvalues

eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) # Build a dataframe

my_radius <- sqrt(N) # The radius of the circle is sqrt(N)

ellDF <- build_ellipse(my_radius, my_radius) # Dataframe to plot the ellipse

names(ellDF) <- c("Real", "Imaginary") # rename the columns
# plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")

# now add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

# finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p
plot(p)

a <- read.table("../data/Results.txt", header = T)
a$ymin <- rep(0,dim(a)[1])
p <- ggplot(a)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y1, size=(0.5)), colour = "#E69F00", alpha=1/2, show.legend = F)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y2, size=(0.5)), colour = "#56B4E9", alpha=1/2, show.legend = F)
p <- p + geom_linerange(data = a, aes(x=x, ymin=ymin, ymax=y3, size=(0.5)), colour = "#D55E00", alpha=1/2, show.legend = F)
p <- p + geom_text(data = a, aes(x=x, y=-500, label = Label))
p <- p + scale_x_continuous("My x axis", breaks = seq(3,5,by=0.05))+ scale_y_continuous("My y axis") + theme_bw() + theme(legend.position = "none")
p
plot(p)

dev.off()