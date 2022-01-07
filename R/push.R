#' @export
push <- function(
  object,
  serialiser = getOption("portal.serialser", default = "rds")
) {

  serialiser_fun <- switch(
    serialiser,
    "rds" = saveRDS,
    "qs" = qs::qsave,
    "parquet" = arrow::write_parquet,
    NULL
  )
  if (is.null(serialiser_fun)) {
    stop(
      "Unknown serialiser option: ",
      serialiser,
      ". Choose 'rds', 'qs', or 'parquet'"
    )
  }
  object_name <- substitute(object)
  if (!is.symbol(object_name)) {
    stop("The portal can only take symbols (objects), not expressions, assign your expressoin to an object?")
  }
  serialiser_fun(
    object,
    file.path(
      get_pkg_user_dir(),
      paste(as.character(object_name), serialiser, sep =".")
    )
  )
  in_message(as.character(object_name))
}

function() {
   foo <- mtcars
   push(foo)
   get_portalled_items()  
   pull()
}
