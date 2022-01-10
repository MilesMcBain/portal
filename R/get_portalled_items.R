get_pkg_user_dir <- function() {
  portal_user_dir <- R_user_dir("portal")
  if (!dir.exists(portal_user_dir)) {
    dir.create(portal_user_dir, recursive = TRUE)
 }
  portal_user_dir
}

#' Catalogue all the objects in the abyss.
#'
#' Where you need a specfic object, knowing its name is necessary to conjur it.
#'
#' Names have power.
#'
#' @export
get_portalled_items <- function() {
  items <- list.files(get_pkg_user_dir(), full.names = TRUE)
  items_info <- lapply(items, \(filename) {
        file_info <- file.info(filename)
        file_info$filename <- filename
        file_info 
  })
  item_dataframe <- do.call(rbind, items_info)

  # if the item_dataframe was NULL, we found no items.
  # return an empty dataframe of right shape and type for no items, 
  # rather than NULL.
  if (is.null(item_dataframe)) {
          dummy_frame <- file.info("__not_a_real_file__")
          dummy_frame$filename <- NA_character_
          item_dataframe <- stats::na.omit(dummy_frame)
  }
  item_dataframe
}
