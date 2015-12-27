library("gplots")
data=read.table("data.txt", header=TRUE, sep=",")
#Q1
#quantile(90, c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6))

#Q2
#barplot(c(3, 5, 6, 7, 4, 5))

#test E5
#participant2SurfPad=subset(data,Participant==2 & Technique=="SurfPad")
#mean(participant2SurfPad[,"Time"])

#Q3 - 6
moyenneTechnique = function(data, techniqueName){
  techniques=subset(data, Technique==techniqueName & Err==0)
  result=mean(techniques[,"Time"])
  return(result)
}

#Q7
intervalleConfiance = function(data, techniqueName){
  techniques=subset(data, Technique==techniqueName & Err==0)
  N=nrow(techniques)
  SD=sd(techniques[, "Time"])
  result=1.96 * SD/sqrt(N)
  return(result)
}

#Q4
allMean = sapply(unique(data$Technique), moyenneTechnique, data=data)

#Q5
#barplot(allMean, names.arg=unique(data$Technique))

allCi = sapply(unique(data$Technique), intervalleConfiance, data=data)

#Q8
barplot2(allMean, names.arg=unique(data$Technique), plot.ci=TRUE, ci.l=allMean-allCi/2, ci.u=allMean+allCi/2)