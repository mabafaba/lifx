#' retrieve lifx_token from R environment
#'
#' @template details_token
#' @return the lifx api token found in environmental variables
#' @seealso \code{\link{lx_has_token}}, \code{\link{lx_save_token}}
#'
lx_get_token <- function() {
    token <- Sys.getenv("LIFX_TOKEN")
    if (identical(token, "")) {
        stop("Please supply a token or add a token to your R environment file with lifx::lx_save_token()", call. = FALSE)
    }

    return(token)
}

#' save a lifx API token in your r environment file
#' @template details_token
#' @template param_token
#' @seealso \code{\link{lx_has_token}}, \code{\link{lx_get_token}}
#' @return logical TRUE if saving token has been successful
#' @export
lx_save_token <- function(token) {
    assertthat::assert_that(assertthat::is.string(token))
    Sys.setenv(LIFX_TOKEN = token)
}

#' check whether a lifx api token is stored in the R environment file.
#'
#' @template details_token
#' @seealso \code{\link{lx_save_token}}, \code{\link{lx_get_token}}
#' @return logical TRUE if a token was found
#'@export
lx_has_token <- function() {
    Sys.getenv("LIFX_TOKEN") != ""
}
