library('rvest')
library(stringr)
library(xml2)
#Vamos a scrappear elementos de Ripley
url<-"https://simple.ripley.cl/search/cafeteras"
selector <- "body > div.container > div.algolia-search > div > div.catalog-page > div.catalog-page__product-grid--with-sidebar.col-sm-12.col-lg-9 > section > div > div > a:nth-child(2)"

webpage<-read_html(url)
node<-html_node(webpage, selector)
text_node<-html_text(node)
text_node

#Obtenemos el href
links_node<-html_attr(node, "href")
links_node
url_completa<-paste0("https://simple.ripley.cl", links_node)

#URL de cambiar página
#https://simple.ripley.cl/search/cafeteras?page=2
#https://simple.ripley.cl/search/cafeteras?page=3


#debemos ver cómo obtener la paginación de la página
paginator<-"https://simple.ripley.cl/search/cafeteras?page=2"
pages_list<-c(1:10)
pages_list
#Str replace cambiará dentro de webpage, los textos que digan "desde_51", por los de dentro de paste0
paginator<-str_replace(paginator, "page=2", paste0("page_", pages_list))

getPageLinks<-function(url){
  selector <- "div.catalog-page > div.catalog-page__product-grid--with-sidebar.col-sm-12.col-lg-9 > section > div > div > a"
  webpage<-read_html(url)
  node<-html_nodes(webpage, selector)
  text_node<-html_text(node)
  #Obtenemos el href
  links_node<-html_attr(node, "href")
  links_node
}

#Veamos los links asociados a alguna pagina
test<-getPageLinks(paginator[2])



linksAsp<-sapply(paginator, getPageLinks)
linksAsp

vlink<-as.vector(linksAsp)

vlinkCafetera<-paste0("https://simple.ripley.cl", vlink)


# SACAR LOS DATOS DE CADA ARTIULO 
url<-"https://simple.ripley.cl/cafetera-nescafe-dolce-gusto-jovia-2000352940403p"

webpage<-read_html(url)

#Nombre del articulo
selector<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-header.hidden-xs > h1"
node_name<-html_node(webpage, selector)
node_name
name_text<-html_text(node_name)
name_text

 
#Precio Internet
selector_price<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-info > ul > li.product-internet-price-not-best > span.product-price"
node_price<-html_node(webpage, selector_price)
price_text<-html_text(node_price)
price_text

#Precio tarjeta  
selector_price_card<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-info > ul > li.product-ripley-price > span.product-price"

node_price_card<-html_node(webpage, selector_price_card)
price_card_text<-html_text(node_price_card)
price_card_text

#Califications

selector_opinions<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-header.hidden-xs > div.product-rating.product-rating-small > span"

node_opinions<-html_node(webpage, selector_opinions)
opinions_text<-html_text(node_opinions)
opinions_text


#Especifications
selector_specs<-"body > div.container > div.react-product-page > section > section.section-product-info > div > div:nth-child(2) > div.accordion-item-wrapper > div > table"

node_specs<-html_node(webpage, selector_specs)
table_specs<-html_table(node_specs)
table_specs
class(table_specs)

#Obtenemos columna de los resultados de los specs
val<-table_specs$X2
val

res_table<-data.frame(t(val))
res_table

#Ahora colocamos los nombres de las columnas, esto estaba en la primer valor de table_specs
table_names<-table_specs$X1
table_names
colnames(res_table)<- table_names

#Tenemos todo el resultado aquí:
res_table

#Ahora hacemos un dataframe final con toda la información
product_results<-c(price_text, price_card_text, name_text, opinions_text, res_table$Marca, res_table$`Tipo de Cafetera`, res_table$`Tipo de Café`, res_table$`Capacidad Neta (lt)`, res_table$`Peso (kg)`)


getProduct<-function(url){
  
  print(paste0("Url: ", url))
  webpage<-read_html(url)
  
  selector<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-header.hidden-xs > h1"
  node_name<-html_node(webpage, selector)
  node_name
  name_text<-html_text(node_name)
  name_text
  
  selector_price<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-info > ul > li.product-internet-price-not-best > span.product-price"
  node_price<-html_node(webpage, selector_price)
  price_text<-html_text(node_price)
  price_text
  if(is.na(price_text)) {
    selector_price<-".product-internet-price > span:nth-child(2)"
    node_price<-html_node(webpage, selector_price)
    price_text<-html_text(node_price)
  }
  
  #Precio tarjeta  
  selector_price_card<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-info > ul > li.product-ripley-price > span.product-price"
  node_price_card<-html_node(webpage, selector_price_card)
  price_card_text<-html_text(node_price_card)
  price_card_text
  
  #Califications
  
  selector_opinions<-"body > div.container > div.react-product-page > section > div:nth-child(3) > div.col-xs-12.col-sm-12.col-md-5 > section.product-header.hidden-xs > div.product-rating.product-rating-small > span"
  
  node_opinions<-html_node(webpage, selector_opinions)
  opinions_text<-html_text(node_opinions)
  opinions_text
  
  #Especifications
  selector_specs<-"body > div.container > div.react-product-page > section > section.section-product-info > div > div:nth-child(2) > div.accordion-item-wrapper > div > table"
  
  node_specs<-html_node(webpage, selector_specs)
  table_specs<-html_table(node_specs)
  table_specs
  class(table_specs)
  
  #Obtenemos columna de los resultados de los specs
  val<-table_specs$X2
  res_table<-data.frame(t(val))
  table_names<-table_specs$X1
  table_names
  colnames(res_table)<- table_names
  
  col<-c("Marca", "Ancho", "Alto", "Peso", "Color")
  if(length(res_table)==0){
    #No hay detalles, todo a -1
    mytab<-data.frame(colnames(col))
    mytab<-rbind(mytab,c("-1", "-1", "-1", "-1", "-1"))
    colnames(mytab)<-col
  }else{
    #Evaluar cada uno de los atributos
    zero<-matrix("-1", ncol=5, nrow=1)
    dfzero<-as.data.frame(zero)
    colnames(dfzero)<-col
    
    #Vemos cada uno de los campos que queremos
    marca<-as.character(res_table$Marca)
    print(paste0("marca:", marca))
    if(length(marca)==0) marca<- "-1"
    
    ancho<-as.character(res_table$`Ancho (cm)`)
    print(paste0("ancho:", ancho))
    if(length(ancho)==0) ancho<- "-1"
    
    alto<-as.character(res_table$`Alto (cm)`)
    print(paste0("alto:", alto))
    if(length(alto)==0) alto<- "-1"
    
    peso<-as.character(res_table$`Peso (kg)`)
    print(paste0("peso:", peso))
    if(length(peso)==0) peso<- "-1"
    color<-as.character(res_table$Color)
    print(paste0("color:", color))
    if(length(color)==0) color<- "-1"
    #Llenamos la tabla

    dfzero$Marca<-marca
    dfzero$Ancho<-ancho
    dfzero$Alto<-alto
    dfzero$Peso<-peso
    dfzero$Color<-color

    mytab<-dfzero
    colnames(mytab)<-col
    
  }


  article<-c(name_text, price_text, price_card_text, opinions_text, as.character(mytab$Marca), as.character(mytab$Ancho), as.character(mytab$Alto), as.character(mytab$Peso), as.character(mytab$Color))
  print("Se crea article")
  print(article)
  article
  return(article)
}

#Probamos la funcion
result<-getProduct(vlinkCafetera[1])
result
res<-getProduct(vlinkCafetera[3])
res

#Ahora hay que lanzarlo contra todos los urls de cafeteras

resultado_datos<-sapply(vlinkCafetera, getProduct)

#Matriz
class(resultado_datos)
#Dimension (240 urls con 9 parametros)
dim(resultado_datos)
#Se crea la matrix con cada columna con resultados.
resultado_datos
#Giramos la matriz que se vea los datos por filas
res<-t(resultado_datos)
View(res)
length(resultado_datos)

  #Ponemos los nombres de la columnas y de rows
products_results<-as.data.frame(res)
colnames(res)<-c("Nombre", "Precio", "Oferta", "Opiniones", "Marca", "Ancho", "Alto", "Peso", "Color")
rownames(res)<-c(1:NROW(res))
View(res)

#guardamos el dataset en csv
write.csv(res, file="D:\\Gmunoz\\Desarrollo\\Propios\\R\\RScripts\\cafeteras.csv")
