pdf("../results/MyLinReg.pdf")

x <- seq(0, 100, by = 0.5)
y <- -4. + 0.25 * x + rnorm(length(x), mean = 10., sd = 2)
my_data <- data.frame(x = x, y = y)
my_lm <- summary(lm(y ~ x, data = my_data))

p <-  ggplot(my_data, aes(x = x, y = y, colour = abs(my_lm$residual))) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(expression(alpha^2 * pi / beta * sqrt(Theta)))

p <- p + geom_abline(intercept = my_lm$coefficients[1][1], slope = my_lm$coefficients[2][1], colour = "blue")
p <- p + geom_text(aes(x = 60, y = 0, label = "sqrt(alpha) * 2* pi"), parse = TRUE, size = 6, colour = "green")
p
plot(p)

library(ggthemes)

p <- ggplot(MyDF, aes(x = log(Predator.mass), y = log(Prey.mass), colour = Type.of.feeding.interaction )) + 
  geom_point(size=I(2), shape=I(10)) + theme_bw()
p <- p + geom_rangeframe() + theme_tufte()
p
plot(p)

dev.off()
