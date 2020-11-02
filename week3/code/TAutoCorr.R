KWAMT = load("../data/KeyWestAnnualMeanTemperature.RData")
year = ats$Year
temp = ats$Temp

# Compute the appropriate correlation coefficient between successive years and store it (cor())
temp1 = temp[-1]
temp2 = temp[-length(temp)]
result = cor(temp1,temp2)
print(result)

Tresult <- vector()
Greater <- vector()
i=1
j=1
while (i<=10000) {
  ts = sample(temp)
  ts1 = ts[-1]
  ts2 = ts[-length(ts)]
  Tresult[[i]] <- cor(ts1,ts2)
  #print(Tresult)
  if(Tresult[[i]]>result){
    Greater[[j]] <- Tresult[[i]]
    j = j +1
  }
  i = i+1
}
hist(Tresult, main = "Calculate 10000 times", xlab = "result" , ylab = "times")
if(length(Greater)>0){
  print(Greater)
  print(length(Greater)/10000)
}else{
  print("No greater value.")
}

