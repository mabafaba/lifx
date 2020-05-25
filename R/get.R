#' list available lights
#' @param selector which lights to look for?
lx_list_lights<-function(selector = "all", token = get_lifx_token()){
  lx_GET(selector = selector, endpoint="",token=token)
}
