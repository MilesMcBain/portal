
#' @export
pull <- function(object) {
  portal_items <- get_portalled_items()
  item_filename <-
    if (!missing(object)) {
      item_names <-
        fs::path_ext_remove(fs::path_file(portal_items$filename))
      portal_items[item_names == as.character(substitute(object)), ]$filename
    } else {
      first_in <- head(sort(portal_items$ctime), 1)
      portal_items[portal_items$ctime == first_in, ]$filename
    }
  if (length(item_filename) == 0) stop("Could not find item in the portal.")
  object_data <- read_item(item_filename)
  object_name <- fs::path_ext_remove(fs::path_file(item_filename))
  assign(object_name, object_data, envir = .GlobalEnv)
  out_message(object_name)
  unlink(item_filename)
}

read_item <- function(filename) {
  extension <- fs::path_ext(filename)
  deserialiser <- switch(
    extension,
    "rds" = readRDS,
    "qs" = qs::qread,
    "parquet" = arrow::read_parquet,
    NULL
  )
  if (is.null(deserialiser)) {
    stop("Portalled item has unsupported file extension: ", filename)
  }
  deserialiser(filename)
}
