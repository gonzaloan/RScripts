library('rvest')


url<-"https://listado.mercadolibre.cl/cafetera"
selector <- "div.item__info-container.highlighted > div > h2 > a"

webpage<-read_html(url)
node<-html_node(webpage, selector)
text_node<-html_text(node)
#Obtenemos el href
links_node<-html_attr(node, "href")
links_node


#URL de cambiar página
#https://listado.mercadolibre.cl/cafetera_Desde_51
#https://listado.mercadolibre.cl/cafetera_Desde_101


library(stringr)
#debemos ver cómo obtener la paginación de la página
paginator<-"https://listado.mercadolibre.cl/cafetera_Desde_51"
pages_list<-seq(1,501, by=50)
pages_list
#Str replace cambiará dentro de webpage, los textos que digan "desde_51", por los de dentro de paste0
paginator<-str_replace(paginator, "Desde_51", paste0("Desde_", pages_list))

getPageLinks<-function(url){
  selector <- "div.item__info-container.highlighted > div > h2 > a"
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
