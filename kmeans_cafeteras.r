
cafeteras<- read.csv("D:\\Gmunoz\\Desarrollo\\Propios\\R\\RScripts\\cafeteras_clean_data.csv")

#Eliminamos fila de nombre, que no nos servira mucho
cafeteras<-cafeteras[,-1]
cafeteras<-cafeteras[,-1]
cafeteras<-cafeteras[,-4]

#Se debe escalar los datos, para que no haya mucha desigualdad. Resta la media a los datos y los divide entre la varianza.
cafeteras<-scale(cafeteras)

#Hacemos un kmeans, con 3 clusters, numero de inicios aleatorios de 5.
#
mycluster<-kmeans(cafeteras,3, nstart=5, iter.max = 30)

#Elresultado son 3 clusters de 110, 100 y30.
#Dice cuáles son los centros de cada cluster y campo
#Muestra el conjunto de datos, en qué cluster está cada elemento.
#Muestra suma de las distancias


#Algunas funciones interesantes

#Muestra número de iteraciones realizadas
mycluster$iter 

#tamaño de los clusters
mycluster$size

#Muestra las medias de cada columna y cluster
mycluster$centers

#Distancias de error
#Esto muestra qué tan buena es nuestra clusterizacion, mienrtas más pequeños los valores, más cercanos están de los centros.
mycluster$withinss


#Analizar el withinss

#Todas las distancias a sus centros para cada cluster.
wss<-(nrow(cafeteras-1))*sum(apply(cafeteras,2,var))

#Hacemos un bucle para que cada numero de cluster calcule el withinss y lo guardemos en variable wss
for(i in 2:20) wss[i]<-sum(kmeans(cafeteras,centers = i)$withinss)


wss

#Ploteamos
plot(1:20, wss, type="b", xlab="Numero de clusters", ylab="withinss groups")
#Con esto podemos obtener el Elbow, en este caso 7

mycluster<- kmeans(cafeteras, 8, nstart=5, iter.max = 30)

library(fmsb)

#partir la visualización en dos filas, y en cada fila 4 gráficas
par(mfrow=c(2,4))
#vamos a ir sacando cada una de las gráficas, para ello, necesitamos crear un subconjunto para cada uno, tiene que tener
#Valor minimo, valor máximo, y valor de los centros para cada una de las variables
dat<-as.data.frame(t(mycluster$centers[1,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

#Hacemos lo mismo para los otros 

dat<-as.data.frame(t(mycluster$centers[2,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

dat<-as.data.frame(t(mycluster$centers[3,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

dat<-as.data.frame(t(mycluster$centers[4,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

dat<-as.data.frame(t(mycluster$centers[5,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

dat<-as.data.frame(t(mycluster$centers[6,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)

dat<-as.data.frame(t(mycluster$centers[7,]))
dat
#Ahora agregamos a todos valores mínimos y máximos
dat<-rbind(rep(5,10), rep(-1,5,10), dat)
#Esto nos da como resultado tres linas, la primera con valores máximos 5
#La segunda con los valores mínimos -1
#La tercera con los valores que tenemos
dat

#Vemos el gráfico
radarchart(dat)



