#' @export
purge <- function(object = NULL) {
  portal_items <- get_portalled_items()
  if (!is.null(object)) {
    item_names <-
      fs::path_ext_remove(fs::path_file(portal_items$filename))
    target_name <-
      portal_items[item_names == as.character(substitute(object)), ]$filename
    if (length(target_name) == 0) {
      stop(
        "Could not find object ",
        object,
        " in the portal"
      )
    }
    unlink(target_name)
  } else {
    lapply(portal_items$filename, unlink)
  }
  invisible()
}
