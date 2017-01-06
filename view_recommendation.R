## Score de similarité

library(sqldf)

setwd("~/M2 CMI SID/WastyDB")
df <- read.csv2("data/historique100u.csv", header = TRUE, sep =";")

##
tab <- data.frame(matrix(nrow = 100,ncol = 50))

for(i in 1:100){
  for(j in 1:50){
    if(length(df[df$id_user == i & df$id_annonce == j,]$favoris) == 0){
      tab[i,j] <- 0
    }
    else{
      tab[i,j] <- df[df$id_user == i & df$id_annonce == j,]$favoris
    }
  }
}

# sim <- data.frame(matrix(nrow = 100,ncol = 100))
# 
# for(i in 1:100){
#   for(j in (i+1):100){
#     
#     sim[i,j] <- sum(tab[i,]*tab[j,])
#   }
# }
sim2 <- read.csv2("sim.csv", header = TRUE, sep=",")
sim2 <- sim2[,-1]



id_user = 1

u1 <- sim[id_user,]

top5 <- sort(u1,decreasing = TRUE)[1:5]

vecu <- data.frame(t(tab[id_user,]))
names(vecu) <- "val"
vecu$ida <- rownames(vecu)
res_u <- vecu[vecu$val == 1,]
recommend <- NULL

for(i in 1:5){
  PP <- as.numeric(substr(colnames(top5)[i],start = 2,stop = 100000L))
  
  vec <- data.frame(t(tab[PP,]))
  names(vec) <- "val"
  vec$ida <- rownames(vec)
  res <- vec[vec$val == 1,]
  
  recommend <- c(recommend,setdiff(res$ida, res_u$ida))
}





