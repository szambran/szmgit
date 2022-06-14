#------------------------Contar pixeles por raster---------------
#---------------------Calcular áreas sector colección 4-------------------------#

setwd("/home/sergio/GIS/provita/gdrive/")


library(raster)
library(doParallel)


ff <- list.files("/home/sergio/GIS/provita/gdrive/RAISG-EXPORT-90221_gapfill//", pattern = "\\.tif$", full=TRUE)
s <- stack(ff)
x <- freq(s)


db <- data.frame(value=3:33)

for (i in 1:length(x)) {
  y <- x[[i]]
  colnames(y)[2] <- paste0("V", i)
  db <- merge(db, y, all.x=TRUE)
}



#--------Voltear tabla------------------------

en_filas <-t(db)
db1 <- as.data.frame(en_filas)
names(db1) <- as.matrix(db1[1, ]) #convertir el título de las columnas a las clases
db1 <- db1[-1, ]

#Renombrar las filas por fechas
row.names(db1) <-c(1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995, 
                   1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,
                   2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,
                   2018,2019,2020,2021)

#------Convertir los píxeles a km2)
db1 <-900*(db1)
db1 <-(db1)/1000000


#--------Estadisticas básicas por clase-------------

summary(db1$`33`)

#--------Graficar las clases deseadas


plot(db1$`3`, main = "Clase 3", xaxt = "n",type = "o", 
     lwd = 1, pch = 19, col = "green", xlab = "Serie temporal", ylab = "km2")
axis(1, at=1:37,labels=1985:2021,las=1)

plot(db1$`12`, main = "Clase 12", xaxt = "n",type = "o", 
     lwd = 1, pch = 19, col = "red", xlab = "Serie temporal", ylab = "km2")
axis(1, at=1:37,labels=1985:2021,las=1)

plot(db1$`33`, main = "Clase 33", xaxt = "n",type = "o", 
     lwd = 1, pch = 19, col = "blue", xlab = "Serie temporal", ylab = "km2")
axis(1, at=1:37,labels=1985:2021,las=1)

# Guardar tabla en CSV
write.csv(resultados, file = "/home/sergio/GIS/provita/gdrive/RAISG-EXPORT-90221_final//CSV_final1.csv")
