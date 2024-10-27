# ShinyApp.R
# This file contains the Shiny app definition for exploring download trends over time.

# Load the required packages
if (!require(shiny)) install.packages("shiny"); library(shiny)
if (!require(ggplot2)) install.packages("ggplot2"); library(ggplot2)
if (!require(dplyr)) install.packages("dplyr"); library(dplyr)

# Load the dataset from the package
data("classics", package = "assignment4package")  # Make sure the dataset is properly loaded

# Define the UI
ui <- fluidPage(
  # Add some custom styling
  tags$head(tags$style(HTML("
                            body {background-color: #2f2f2f;}
                            .well {background-color: #e9ecef;}
                            h1 {color: #2f2f2f;}  # Greyish black color
                            "))),
  
  titlePanel("Explore Download Trends Over Time"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a year range and explore the number of downloads per year by genre."),
      
      # Slider for year range
      sliderInput("yearRange", "Filter by Year:",
                  min = min(classics$bibliography.publication.year, na.rm = TRUE),
                  max = max(classics$bibliography.publication.year, na.rm = TRUE),
                  value = c(min(classics$bibliography.publication.year, na.rm = TRUE), 
                            max(classics$bibliography.publication.year, na.rm = TRUE)),
                  step = 1,
                  sep = ""),
      
      # Allow multiple genres to be selected
      selectInput("selectedGenres", "Choose Genres:", 
                  choices = unique(classics$bibliography.subjects),
                  selected = unique(classics$bibliography.subjects)[1],
                  multiple = TRUE)
    ),
    
    mainPanel(
      plotOutput("downloadTrendPlot"),
      textOutput("interpretation")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  # Reactive expression to filter data based on user input
  filteredData <- reactive({
    classics %>%
      filter(!is.na(bibliography.publication.year),
             bibliography.publication.year >= input$yearRange[1],
             bibliography.publication.year <= input$yearRange[2],
             bibliography.subjects %in% input$selectedGenres)
  })
  
  # Generate line plot based on filtered data
  output$downloadTrendPlot <- renderPlot({
    if (nrow(filteredData()) == 0) {
      return(NULL)  # If no data to plot, show nothing
    }
    
    # Group by publication year and genre, and sum the number of downloads per year
    yearly_downloads <- filteredData() %>%
      group_by(bibliography.publication.year, bibliography.subjects) %>%
      summarise(total_downloads = sum(metadata.downloads, na.rm = TRUE))
    
    # Plotting the line graph for downloads per year, faceted by genre
    ggplot(yearly_downloads, aes(x = bibliography.publication.year, y = total_downloads, color = bibliography.subjects)) +
      geom_line(size = 1.5) +  # Line graph with different colors for each genre
      geom_point(size = 3) +  # Adding points for clarity
      labs(
        title = "Download Trends Over Time by Genre",
        x = "Publication Year",
        y = "Number of Downloads",
        color = "Genres"
      ) +
      theme_minimal() +
      theme(
        plot.title = element_text(face = "bold", hjust = 0.5, size = 16),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.title = element_text(face = "bold")
      )
  })
  
  # Interpretation text
  output$interpretation <- renderText({
    paste("This graph shows the trend of downloads over time for the selected genres. Compare how different genres have gained or lost popularity based on download numbers in the selected years.")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
