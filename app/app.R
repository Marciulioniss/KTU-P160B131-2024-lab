library(shiny)
library(ggplot2)
library(tidyverse)
library(jsonlite)


# Define UI for application that draws a histogram
ui <- fluidPage(

  
  # Application title
  titlePanel("Ekonominė sritis 620000"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectizeInput("Company",
                     "Pasirinkite įmonę",choices = NULL)),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data = readRDS('../data/620000.rds')
  updateSelectizeInput(session, "Company", choices = data$name, server = T)
  
  output$plot = renderPlot(
    data%>%
      filter(name == input$Company)%>%
      ggplot(aes(x=ym(month),y=avgWage, color = name))+geom_point(size = 4)+
      geom_line(size = 2)+
      theme_classic()+ scale_color_manual(values = c("green")) +
      labs(x="Mėnesis", y="Vidutinis atlyginimas", color = "Įmonė")
  )
}


# Run the application 
shinyApp(ui = ui, server = server)
