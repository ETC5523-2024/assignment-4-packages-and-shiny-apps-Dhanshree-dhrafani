#' Launch the Shiny app
#'
#' This function launches the Shiny app from the 'inst/shiny' directory.
#' @export
runShinyApp <- function() {
  # Directly specify the full path to the app
  app_path <- "E:/MONASH/Communication with Data/assignment-4-packages-and-shiny-apps-Dhanshree-dhrafani/inst/shiny/ShinyApp.R"
  
  print(paste("Sourcing the app from:", app_path))  # Debugging print statement
  
  if (!file.exists(app_path)) {
    stop("Shiny app not found at the specified path. Please check the file path.", call. = FALSE)
  }
  
  # Source the app from the full path
  source(app_path)
  
  # Run the Shiny app
  shinyApp(ui = ui, server = server)  # Assuming `ui` and `server` are defined in ShinyApp.R
}
