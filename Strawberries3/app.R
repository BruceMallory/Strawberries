library(shiny)
library(tidyverse)

straw <- read.csv("straw.csv")

ui <- fluidPage(
    title = "Strawberries3",
    titlePanel("Strawberries"),
    # Sidebar layout with input and output definitions ----
    sidebarLayout(

        # Sidebar panel for inputs ----
        sidebarPanel(

             selectInput(inputId = "Year",
                        label = "Year",
                        choices = unique(as.character(straw$Year))),

             selectInput(inputId = "Application",
                        label = "Application",
                        choices = unique(as.character(straw$Application))),
        ),

        # Main panel for displaying outputs ----
        mainPanel(

            # Output: Verbatim text for data summary ----
            textOutput("text1"),
            textOutput("text2"),

            # Output: side by side boxplots ----
            plotOutput("boxplots")

        )
    )
)

server <- function(input, output, session) {

    output$text1 <- renderText({

        paste('The amount of ', input$Application, "in ", input$Year)

    })

    output$text2 <- renderText({

        print('measured in pounds per year')

    })

    output$boxplots <- renderPlot({

        df <- filter(straw, Year==input$Year & Application==input$Application)
        ggplot(df, aes(State, Amount)) +
            geom_boxplot()

    })
}


shinyApp(ui, server)
