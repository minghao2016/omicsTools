
<!-- README.md is generated from README.Rmd. Please edit that file -->

# omicsTools

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/omicsTools)](https://cran.r-project.org/package=omicsTools)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

The goal of omicsTools is to provide tools for processing and analyzing
omics data from genomics, transcriptomics, proteomics, and metabolomics
platforms. It provides functions for preprocessing, normalization,
visualization, and statistical analysis, as well as machine learning
algorithms for predictive modeling. omicsTools is an essential tool for
researchers working with high-throughput omics data in fields such as
biology, bioinformatics, and medicine.

License: MIT + file LICENSE

## Installation

### CRAN version

You can install the Stable version of omicsTools like so:

``` r
install.packages("omicsTools")
```

### Development version

To get a bug fix, or use a feature from the development version, you can
install omicsTools from GitHub.

``` r
if (!require("devtools", quietly = TRUE))
    install.packages("devtools")
devtools::install_github("YaoxiangLi/omicsTools")
```

## Example of imputation

You can also use the graphical user interface:

``` r
# Load the CSV data
data_file <- system.file("extdata", "example1.csv", package = "omicsTools")
data <- readr::read_csv(data_file)
#> Rows: 85 Columns: 482
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr   (1): Sample
#> dbl (414): Urea_pos, Lipoamide_pos, AcetylAmino Sugars_pos, Glycerophosphoch...
#> lgl  (67): DBQ_pos.IS, Aminolevulinic Acid_pos, Leucine_pos, Homocystine_pos...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
# Apply the impute function
imputed_data <- omicsTools::impute(data, percent = 0.2)
#> 280 features removed by percent of missing values > 0.2
# Write the imputed data to a new CSV file
readr::write_csv(imputed_data, paste0(tempdir(), "/imputed_data.csv"))
```

## Example of QC-normalization

You can also use the graphical user interface:

``` r
# Load the CSV data
data_file <- system.file("extdata", "example2.csv", package = "omicsTools")
data <- readr::read_csv(data_file)
#> Rows: 63 Columns: 202
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr   (1): Sample
#> dbl (201): Urea_pos, Lipoamide_pos, Glycerophosphocholine_pos, Allanoate_pos...
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
# Apply the normalize function
normalized_data <- omicsTools::normalize(data)
# Write the normalized data to a new CSV file
readr::write_csv(normalized_data, paste0(tempdir(), "/normalized_data.csv"))
```

## Example of GUI

You can also use the graphical user interface:

``` r
library(omicsTools)
#> 
#> This is omicsTools version 1.0.5.
#> omicsTools is free software and comes with ABSOLUTELY NO WARRANTY.
#> Please use at your own risk.
omicsTools::run_app()
```

<div style="width: 100% ; height: 400px ; text-align: center; box-sizing: border-box; -moz-box-sizing: border-box; -webkit-box-sizing: border-box;" class="muted well">Shiny applications not supported in static R Markdown documents</div>

`devtools::build_readme()`

### Code style

Since this is a collaborative project, please adhere to the following
code formatting conventions: \* We use the tidyverse style guide
(<https://style.tidyverse.org/>) \* Please write roxygen2 comments as
full sentences, starting with a capital letter and ending with a period.
Brevity is preferred (e.g., “Calculates standard deviation” is preferred
over “This method calculates and returns a standard deviation of given
set of numbers”).
