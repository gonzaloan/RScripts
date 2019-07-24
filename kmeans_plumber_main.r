#Archivo para llamar plumber
library(plumber)
r<-plumb("C:/gmunoz/propios/r/RScripts/cafeteras_plumber.r")
r$run(port=8000)


#http://localhost:8000/getCluster?Precio=-1.0491919&Oferta=-1.0544088&Opiniones=-0.3371214&Ancho=0.6757187&Alto=-2.7433813&Peso=-2.3867230