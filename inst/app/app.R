
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("United State City Map"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput("cn",
                        "City name:",
                        #choices = c(uscitydata$city_ascii),
                        choices = NULL,
                        selected = "Birmingham",

                        ),
            selectInput("st",
                        "State:",
                        choices = NULL,
                        selected = "AL",
                        ),
            actionButton("show_map", "Show map!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
          plotOutput("point_map")
        )
    )
)


server <- function(input, output,session) {
  updateSelectizeInput(session, 'cn', choices = c(uscitydatafull), server = TRUE)
  updateSelectizeInput(session, 'st', choices = c(unique(uscitydatafull$state_id)), server = TRUE)
  observeEvent(input$show_map, {
    city_name <- reactive({
      input$cn
    })
    state_abb <- reactive({
      input$st
    })

  map <- viewCityMap(city_name(),state_abb())
  
    output$point_map <- renderPlot({map})
  })
  
}


shinyApp(ui = ui, server = server)