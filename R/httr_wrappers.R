

# a lot of this code is following https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html

# global variable to let lifx know through which application the call is coming:
user_agent <- httr::user_agent("http://github.com/mabafaba/lifx")

# GET / PUT / POST  -----------------------------------------------------------------


#' GET request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token the API token; see ?lx_auth
lx_GET <-function(selector="all",endpoint, token = get_lifx_token()){
  url<-lifx_api_url(selector,endpoint)
  header<-lx_auth(token)
  response <- httr::GET(url,header, user_agent)
  response <- as_lifx_api_response(response)
  response
}


#' PUT request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @param ... named values to add to the request body
lx_PUT <-function(selector="all",endpoint, token, ...){
  url<-lifx_api_url(selector,endpoint)
  header<-lx_auth(token)
  response <- httr::PUT(url,header, body = list(...),encode = "json")
  response <- as_lifx_api_response(response)
  invisible(response)
}

#' POST request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @param ... named values to add to the request body
lx_POST <-function(selector="all",endpoint, token, ...){
  url <- lifx_api_url(selector,endpoint)
  header<-lx_auth(token)
  response <- httr::POST(url,header,body = list(...),encode = "json")
  response <- as_lifx_api_response(response)
  invisible(response)

}



# helpers -----------------------------------------------------------------

lifx_api_url<-function(selector,endpoint){
  httr::modify_url("https://api.lifx.com",path = c("v1","lights", selector,endpoint))
}

lx_auth <- function(token =  get_lifx_token()){
  httr::add_headers(Authorization=sprintf("Bearer %s", token))

}


# S3 object for response ---------------------------------------------------------

as_lifx_api_response<-function(r){

  check_lifx_response(r)
  content <- httr::content(r, "text",encoding = "UTF-8")
  if(content==""){
    content_parsed<-""
    }else{
    content_parsed  <- jsonlite::fromJSON(content, simplifyVector = FALSE)
  }


  response <-
    structure(
      list(
        content = content_parsed,
        path = r$url,
        response = r
      ),
      class = "lifx_api_response"
    )
}

#' @method print lifx_api_response
#' @export
print.lifx_api_response <- function(x, ...) {
  cat(crayon::italic(paste(crayon::bold("<LIFX "), x$path, ">\n")))
  # utils::str(x$content)
  invisible(x)
}

# api token ------------------------------------------------------


#' retrieve lifx_token from R environment
#'
#' #' @details To use the lifx API, you need to get a personal access token from your lifx account. Usually you save API tokens in your r environment file; that way you only have to enter it once per system. Once you have your token, you can use `save_lifx_token()` to do that.
#' How to get a token:
#' 1. go to \url{https://cloud.lifx.com/sign_in} and sign in (if you do not have an account, you must download the mobile app and register there.
#' 2. generate or look up your access token
#'
#' You do not need to save the token in the environment; you can use all functions in this package by passing a valid `token` argument.
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
#'@export
has_lifx_token<-function(){
  Sys.getenv("LIFX_TOKEN")!=""
}
