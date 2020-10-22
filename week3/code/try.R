doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x))>30){
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))
    }else{
        stop("Couldn't calculate mean: too few unique values!")
    }
}

popn <- rnorm(50)
hist(popn)
result <- lapply(1:15, function(i) try(doit(popn), FALSE))
