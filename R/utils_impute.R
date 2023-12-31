#' Impute function
#'
#' This function performs data cleaning and imputation on a given data matrix.
#' It removes blank and NIST samples, features with NA values more than the specified threshold,
#' and imputes remaining NA values with half of the smallest non-NA value.
#'
#' @param data A data frame containing the sample data. The first column should contain
#' the sample identifiers, and the rest of the columns contain the peaks.
#'
#' @param percent A numeric value between 0 and 1 representing the threshold of the
#' percentage of NA values a feature should have for it to be removed from the dataset.
#' Default value is 0.2.
#'
#' @return A data frame with the first column as the sample identifiers and
#' the rest of the columns containing the cleaned and imputed peak intensities.
#' @examples
#'
#' # Load the CSV data
#' data_file <- system.file("extdata", "example1.csv", package = "omicsTools")
#' data <- readr::read_csv(data_file)
#' # Apply the impute function
#' imputed_data <- omicsTools::impute(data, percent = 0.2)
#'
#' \donttest{
#' # Write the imputed data to a new CSV file
#' readr::write_csv(imputed_data, paste0(tempdir(), "/imputed_data.csv"))
#' }
#' @importFrom dplyr filter bind_cols
#' @export
#' @author Yaoxiang Li \email{yl814@georgetown.edu}
#'
#' Georgetown University, USA
#'
#' License: GPL (>= 3)
impute <- function(data, percent = 0.2) {

  # Filter out Blank and NIST samples
  data <- data %>% dplyr::filter(!grepl('Blank', Sample))
  data <- data %>% dplyr::filter(!grepl('BLANK', Sample))
  data <- data %>% dplyr::filter(!grepl('NIST', Sample))

  # Convert the data except the sample identifiers to a matrix
  peaks <- as.matrix(data[, -1])

  # Identify features with NA values more than the specified threshold
  na_features <- which(colMeans(is.na(peaks)) > percent)

  if (length(na_features)) {
    # Remove features if NA > threshold rate
    peaks <- peaks[ ,-na_features]
    message(paste0(
      length(na_features),
      " features removed by percent of missing values > ",
      as.character(percent)
    ))
  } else {
    message('No features removed by missing values')
  }

  for (i in 1:ncol(peaks)) {
    v <- peaks[, i]

    # If there are any NA values, replace them with half the smallest non-NA value
    if (any(is.na(v))) {
      v[which(is.na(v))] <- min(v[which(!is.na(v))][-1]) / 2
      peaks[, i] <- v
    }
  }
  # Combine the sample identifiers with the cleaned and imputed peaks
  return(dplyr::bind_cols(data[, 1], peaks))
}