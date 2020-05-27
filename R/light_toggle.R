#' Toggle light
#' @param duration in seconds, how long to perform the transition
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @export
lx_toggle<-function(duration = 0, selector = "all", token =  get_lifx_token()){
  lx_POST(selector,endpoint = "toggle",token = token, duration = duration)
}










