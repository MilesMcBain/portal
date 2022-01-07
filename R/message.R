
in_message <- function(object_name) {
in_portal <-
c(
" __",
"|  |---",
"|  |",
"{object_name} -> |  |",
"|  |",
"|__|---"
)
  in_portal[[4]] <- glue::glue(in_portal[[4]])
  in_portal[-4] <- paste0(strrep(" ", nchar(object_name) + nchar(" -> ")), in_portal[-4])
  paste0(in_portal, collapse = "\n") |>
  cat("\n")
}

out_message <- function(object_name) {
out_portal <-
"
     __
 ---|  |
    |  |
    |  | -> {object_name}
    |  |
 ---|__|

"
   glue::glue(out_portal) |>
   cat("\n")
}
