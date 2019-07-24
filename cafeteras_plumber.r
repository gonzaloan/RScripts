data <- read.csv("C:/gmunoz/propios/r/RScripts/cafeteras_clean_data.csv")
data<-data[,-1]
data<-data[,-1]
data<-data[,-4]
data<-scale(data)



data


write.csv(data, "c:/gmunoz/propios/r/RScripts/data_limpia.csv")

#mycluster<-kmeans(cafeteras,3, nstart=5, iter.max = 30)
mycluster<- kmeans(data, 8, nstart=5, iter.max = 30)
mycluster$centers


#* @param Precio
#* @param Oferta
#* @param Opiniones
#* @param Ancho
#* @param Alto
#* @param Peso
#* @get /getCluster
function(precio,oferta, opiniones, ancho, alto, peso){
    campos<-as.vector(data[1,])
    #Matriz de#  ceros, para calculas distancias. 8 columnas correspondientes a los 8 clusters y 
    #6 filas correspondientes a los campos
    midist<-matrix(0, ncol=8, nrow=6)
    for(i in 1:6){
      c<-dist(x=c(campos[i], mycluster$centers[,i]))
      b<-as.matrix(c)
      distancia<-b[-1,1]
      #Calculamos la distancia de la columna de precio
      distancia
      midist[i,]<-distancia
      }
    
    midist
    colnames(mycluster$centers)
    rownames(midist)<-colnames(mycluster$centers)
    midist
    #ASi calculamos las distancias a cada uno de los centers de los clusters
    
    #Debemos sumar cada una de las columnas, para obtener la distancia total
    dist_total<-apply(midist, 2, sum)
    dist_total
    
    #Necesitamos obtener la distancia menor
    num_cluster<-which.min(dist_total)
    num_cluster
}

