## Explore Classic Literature Data - Shiny App Package

## Overview

This R package provides an interactive **Shiny app** to explore the "Classic Literature" dataset. The dataset contains various statistics related to readability scores, download counts, and publication years for famous literary works. The app allows users to filter books by genre, analyze trends in downloads, and examine readability across different works.

## Features

-   **Interactive Filtering**: Users can filter books by their readability scores, genres, and publication year.
-   **Download Analysis**: Visualize the number of downloads per book and compare across genres.
-   **Publication Trends**: Track how publication and readability trends have evolved over the years.

## Installation

To install the package from GitHub, first ensure you have the `devtools` package installed:

``` r
# Install devtools if not already installed
install.packages("devtools")

Then, install the Classic Literature Shiny App package:
# Install the package from GitHub
devtools::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-Dhanshree-dhrafani")
```

## How to Use

After installation, you can launch the Shiny app with the following command:

``` r
# Load the package
library(assignment4package)

# Run the Shiny App
runShinyApp()
```

The app provides several features for users to explore the classic literature dataset:

-   Filter Genres: Use interactive controls to filter the dataset by readability scores, genres, or years.
-   Explore Downloads: View the number of downloads per book.
-   Publication Trends: Use sliders to explore trends over time.

## Dataset Overview

The dataset used in this app contains the following key fields:

-   Title: The title of the book.
-   Download Count: The total number of downloads the book has received.
-   Publication Year: The year the book was originally published.

## Example Usage

Here's an example of how to use the package and load the dataset for analysis:

``` r
library(assignment4package)

# Load the classics dataset
data(classics)

# View the first few rows of the dataset
head(classics)
```

## Vignettes

For a detailed guide on using the package, check the vignette with: vignette("exploring_the_classics_data", package = "assignment4package")

## License

This package is licensed under the MIT License. See the LICENSE file for more details.
