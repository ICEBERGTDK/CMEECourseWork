rm(list = ls())
load("../data/GPDDFiltered.RData")
require(maps)
require(ggplot2)
mp <- NULL
mapworld <- borders('world', colour = "gray 50", fill = "white")
mp <- ggplot() + mapworld + map.axes()
mp <- mp + geom_point(aes(x=gpdd$long, y=gpdd$lat), color = "darkorange", shape = I(3)) + scale_size(range = c(1,1))
mp <- mp + theme(legend.position = "bottom")
mp



mp <- ggplot() + mapworld + map.axes()
mp <- mp + geom_point(aes(x=gpdd$long, y=gpdd$lat), colour = gpdd$common.name) + scale_size(range = c(1,1))
mp <- mp + theme(legend.position = "none")
mp
