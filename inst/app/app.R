
# Define UI for application that draws a histogram
ui <- shiny::fluidPage(

    # Application title
    shiny::titlePanel("United States City Map"),

    # Sidebar with a 
    shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::selectInput("st",
                             "State:",
                             choices = c(unique(uscitydata$state_name)), selected = "New York"
          ),
          shiny::selectizeInput("cn",
                                "City name:",
                                choices = NULL,
                        

          ),
          shiny::selectInput("mp",
                             "Map Type:",
                             choices =  c("terrain", "terrain-background", "terrain-labels", "terrain-lines", 
                                          "toner", "toner-2010", "toner-2011", "toner-background", "toner-hybrid", 
                                          "toner-labels", "toner-lines", "toner-lite", "watercolor"), 
                             selected = "toner-hybrid"
                        
            ),
            shiny::actionButton("show_map", "Show map!")
        ),

        # Show a plot of the generated distribution
        shiny::mainPanel(
          shiny::plotOutput("point_map")
        )
    )
)


server <- function(input, output,session) {
  shiny::updateSelectizeInput(session, 'cn', choices = c(uscitydata$city_ascii), selected = "Albany",server = TRUE)
  
  
  shiny::observeEvent(input$show_map, {
    output$point_map <- renderPlot({viewCityMap(isolate(input$cn),isolate(input$st),isolate(input$mp))})

  })
}


shiny::shinyApp(ui = ui, server = server)
