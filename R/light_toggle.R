#' Toggle light
#' @param duration in seconds, how long to perform the transition
#' @param select lifx API selector criteria (see ?lx_select)
lx_toggle<-function(duration = 0, selector = "all", token =  get_lifx_token()){
  lx_POST(selector,endpoint = "toggle",token = token, duration = duration)
}










