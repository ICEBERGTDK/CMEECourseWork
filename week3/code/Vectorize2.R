# Runs the stochastic Ricker equation with gaussian fluctuations

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)){#loop through the populations
    
    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr,pop] <- N[yr-1,pop] * exp(r * (1 - N[yr - 1,pop] / K) + rnorm(1,0,sigma))
    
    }
  
  }
 return(N)

}

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
    for (yr in 2:numyears){ #for each pop, loop through the years
      N[yr,] <- N[yr-1,] * exp(r * (1 - N[yr - 1,] / K) + rnorm(1,0,sigma))
    }
 return(N)
}

# pop
stochrick1<-function(p0=runif(100,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,1000)
  N[1,]<-p0
  for (pop in 2:1000){#loop through the populations
    #for (yr in 2:numyears){ #for each pop, loop through the years
      N[,pop] <- N[,pop-1] * exp(r * (1 - N[,pop-1] / K) + rnorm(1,0,sigma))
    #}
  }
  return(N)
}


print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))
print("Vectorized Stochastic_Ricker_Vect takes:")
print(system.time(res2<-stochrickvect()))
print("Vectorized Stochastic_Ricker_Vect takes:")
print(system.time(res2<-stochrick1()))