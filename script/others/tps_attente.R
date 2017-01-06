library("Imap")
library(sqldf)

#Import des données

df <- read.csv2('data/Depot_Objet.csv', header = TRUE, sep = ";")


#Distance entre deux points
gdist(df$Longitude[1], df$Latitude[1], df$Longitude[2], df$Latitude[2], units = "km")


#Requête (categ,SS_categ,etat,Lon,Lat,rayon,date,time)

req <- c("Ameublement","Table","Bon","1.396912","43.57600","3","07/10/17","21:30:00")


t = paste(req[7],req[8])
today <- strptime(t,"%d/%m/%y %H:%M:%S")

sql_req = paste("SELECT * FROM df WHERE Categ = '",req[1],"' AND Ss_categ = '",req[2],"' AND Etat= '",req[3],"'", sep ='')

df_req <- sqldf(sql_req)

#Distance par rapport au requeteur
for(i in 1:nrow(df_req)){
  df_req$Distance[i] <- gdist(as.numeric(req[4]),as.numeric(req[5]),df_req$Longitude[i],df_req$Latitude[i],units = "km") 
  
}
#Données ciblées par rapport au rayon souhaité (en km)
df_req_dist <- sqldf(paste("Select * from df_req where Distance < ",req[6]))

#Calcul de fréquence d'apparition de l'objet
x <- paste(df_req_dist$Date, df_req_dist$Heure)
df_req_dist$DTime<- strptime(x, "%d/%m/%y %H:%M:%S")


dernier <- 38
res <- max(df_req_dist$DTime) - min(df_req_dist$DTime)
freq <- (as.numeric(res)/6) #Voir par rapport à la saisonnalité (Si il y a plus de depot en été, la fréquence sera plus élevé qu'en hiver, d'où la nécessité de cibler les données)
freq_heure <- 1/(freq*24/dernier)
freq_jour <- 1/(freq/dernier)
freq_sem <- 1/(freq/(7+dernier))
freq_mois <- 1/(freq/(28+dernier))
prob_heure <- pexp(1,freq_heure)
prob_jour <- pexp(1,freq_jour)
prob_sem <- pexp(1,freq_sem)
prob_mois <- pexp(1,freq_mois)

tps_attente <- freq - as.numeric(today - max(df_req_dist$DTime))




