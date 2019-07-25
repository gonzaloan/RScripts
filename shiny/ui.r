data <- read.csv("c:/gmunoz/propios/r/RScripts/data_limpia.csv")
data<-data[,-1]
pageWithSidebar(
  headerPanel('Cafeteras Ripley'),
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(data)),
    selectInput('ycol', 'Y Variable', names(data),
                selected=names(data)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 9)
  ),
  mainPanel(
    plotOutput('plot1')
  )
)

