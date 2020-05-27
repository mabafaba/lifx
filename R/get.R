#' list available lights
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @return the API response
lx_list_lights<-function(selector = "all", token = get_lifx_token()){
  lx_GET(selector = selector, endpoint="",token=token)
}
