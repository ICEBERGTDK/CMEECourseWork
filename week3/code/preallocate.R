a <- NA
F1<-function(a) {
    for (i in 1:10) {
        a <- c(a, i)
        print(a)
        print(object.size(a))
    }
}
print(system.time(F1(a)))

b <- rep(NA, 10)
F2<-function(b){
    for (i in 1:10) {
        b[i] <- i
        print(b)
        print(object.size(b))
    }
}
print(system.time(F2(b)))
