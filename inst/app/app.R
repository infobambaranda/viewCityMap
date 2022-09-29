
# Define UI for application that draws a histogram
ui <- shiny::fluidPage(

    # Application title
    shiny::titlePanel("United State City Map"),

    # Sidebar with a slider input for number of bins 
    shiny::sidebarLayout(
        shiny::sidebarPanel(
            shiny::selectizeInput("cn",
                        "City name:",
                        #choices = c(uscitydata$city_ascii),
                        choices = NULL,
                        

                        ),
            shiny::selectInput("st",
                        "State:",
                        choices = NULL,
                        ),
            shiny::selectInput("mp",
                        "Map Type:",
                        choices = NULL,
                        
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
  # uscitydata <- load(uscitydata)
  shiny::updateSelectizeInput(session, 'cn', choices = c(uscitydata), selected = "Albany",server = TRUE)
  shiny::updateSelectizeInput(session, 'st', choices = c(unique(uscitydata$state_name)), selected = "New York", server = TRUE)
  shiny::updateSelectizeInput(session, 'mp', choices = c("terrain", "terrain-background", "terrain-labels", "terrain-lines", 
                                                  "toner", "toner-2010", "toner-2011", "toner-background", "toner-hybrid", 
                                                  "toner-labels", "toner-lines", "toner-lite", "watercolor"), selected = "toner-hybrid", server = TRUE)
  
  
  shiny::observeEvent(input$show_map, {
    city_name <- reactive({
      input$cn
    })
    state_abb <- reactive({
      input$st
    })
    map_type <- reactive({
      input$mp
    })

    output$point_map <- renderPlot({viewCityMap(city_name(),state_abb(),map_type())})

  })
}


shiny::shinyApp(ui = ui, server = server)