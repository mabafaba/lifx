
# api token ------------------------------------------------------


#' retrieve lifx_token from R environment
#'
#' #' @details To use the lifx API, you need to get a personal access token from your lifx account. Usually you save API tokens in your r environment file; that way you only have to enter it once per system. Once you have your token, you can use `save_lifx_token()` to do that.
#' How to get a token:
#' 1. go to \url{https://cloud.lifx.com/sign_in} and sign in (if you do not have an account, you must download the mobile app and register there.
#' 2. generate or look up your access token
#'
#' You do not need to save the token in the environment; you can use all functions in this package by passing a valid `token` argument.
#' @return the lifx api token found in environmental variables
#' @seealso \code{\link{has_lifx_token}}, \code{\link{save_lifx_token}}
#'
get_lifx_token <- function() {
  token <- Sys.getenv('LIFX_TOKEN')
  if (identical(token, "")) {
    stop("Please supply a token or add a token to your R environment file with lifx::save_lifx_token()",
         call. = FALSE)
  }

  return(token)
}

#' save a lifx API token in your r environment file
#'
#' @details To use the lifx API, you need to get a personal access token from your lifx account. Usually you save API tokens in your r environment file; that way you only have to enter it once per system.
#' How to get a token:
#' 1. go to \url{https://cloud.lifx.com/sign_in} and sign in (if you do not have an account, you must download the mobile app and register there.
#' 2. generate or look up your access token
#'
#' You do not need to save the token in the environment; you can use all functions in this package by passing a valid `token` argument.
#'
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @seealso \code{\link{has_lifx_token}}, \code{\link{get_lifx_token}}
#' @return logical TRUE if saving token has been successful
#' @export
save_lifx_token <- function(token){
  assertthat::assert_that(assertthat::is.string(token))
  Sys.setenv(LIFX_TOKEN = token)
}

#' check whether a lifx api token is stored in the R environment file.
#'
#' @details To use the lifx API, you need to get a personal access token from your lifx account. Usually you save API tokens in your r environment file; that way you only have to enter it once per system. Once you have your token, you can use `save_lifx_token()` to do that.
#' How to get a token:
#' 1. go to \url{https://cloud.lifx.com/sign_in} and sign in (if you do not have an account, you must download the mobile app and register there.
#' 2. generate or look up your access token
#'
#' You do not need to save the token in the environment; you can use all functions in this package by passing a valid `token` argument.
#' @seealso \code{\link{save_lifx_token}}, \code{\link{get_lifx_token}}
#' @return logical TRUE if a token was found
#'@export
has_lifx_token<-function(){
  Sys.getenv("LIFX_TOKEN")!=""
}
