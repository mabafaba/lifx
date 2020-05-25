

# a lot of this code is following https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html

# global variable to let lifx know through which application the call is coming:
user_agent <- httr::user_agent("http://github.com/mabafaba/lifx")

# GET / PUT / POST  -----------------------------------------------------------------


#' GET request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen" - see https://api.developer.lifx.com/docs/selectors
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
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen" - see https://api.developer.lifx.com/docs/selectors
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token the API token; see ?lx_auth
#' @param ... named values to add to the request body
lx_PUT <-function(selector="all",endpoint, token, ...){
  url<-lifx_api_url(selector,endpoint)
  header<-lx_auth(token)
  response <- httr::PUT(url,header, body = list(...),encode = "json")
  response <- as_lifx_api_response(response)
  invisible(response)
}

#' POST request
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen" - see https://api.developer.lifx.com/docs/selectors
#' @param endpoint the API endpoint to call; basically the last part of the API url after the light selector
#' @param token the API token; see ?lx_auth
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

print.lifx_api_response <- function(x, ...) {
  cat(crayon::italic(paste(crayon::bold("<LIFX "), x$path, ">\n")))
  str(x$content)
  invisible(x)
}

# getting an api token ------------------------------------------------------


#' @details To use the lifx API, you need to get a personal access token from your lifx account.
#' How to get a token:
#' 1. go to https://cloud.lifx.com/sign_in and sign in (if you do not have an account, you must download the mobile app and register there.
#' 2. generate or look up your access token
#'
#' Once you have your token, you can use all functions in this package by passing it as the `token`` argument.
#' Alternatively it is recommended to store the token in your R environment file:
#' 1. run usethis::edit_r_environ()
#' 2. in the file that opens, add in a new line `LIFX_TOKEN=your_token` (where your_token is your token, something like 58sdffsodAhF4rfs...)
#' 3. save and close the file and restart your R session
#'
#' Then you run the functions in this package without passing the token every time.
get_lifx_token <- function(token=NULL) {
  if(!is.null(token)){return(token)}

  token <- Sys.getenv('LIFX_TOKEN')
  if (identical(token, "")) {
    stop("Please provide a lifx token to the function, or add a token to your R environment file as  \"LIFX_TOKEN\". See ?get_lifx_token for details.",
         call. = FALSE)
  }

  return(token)
}
