

# a lot of this code is following https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html

# global variable to let lifx know through which application the call is coming:
user_agent <- httr::user_agent("http://github.com/mabafaba/lifx")

# GET / PUT / POST  -----------------------------------------------------------------


#' GET request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token the API token; see ?lx_auth
#' @return an httr response object (see \code{\link[httr]{response}})
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
#'@return an httr response object (see \code{\link[httr]{response}})
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
#' @return an httr response object (see \code{\link[httr]{response}})
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

