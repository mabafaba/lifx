# lifx light color
#'
#' change the state of lifx lamps
#'
#' @template param_colors
#' @template param_duration
#' @template param_infrared
#' @template param_color_name
#' @template param_fast
#' @param delta if set to TRUE, color values (hue, saturation, brightness, kelvin, infrared) are added to the lights' current values. Can not be used in combination with `color_name`
#' @template param_selector
#' @template param_power
#' @template param_token
#' @return an httr response object (see \code{\link[httr]{response}})
#' @export
lx_color <- function(hue=NULL,
                   saturation=NULL,
                   brightness=NULL,
                   kelvin=NULL,
                   duration=NULL,
                   infrared = NULL,
                   color_name = NULL,
                   fast = FALSE,
                   delta = FALSE,
                   selector="all",
                   power = NULL,
                   token =  get_lifx_token()){

  # check inputs

  if(!is.null(color_name)){
    if(delta){stop("can not use parameter color_name when delta is set to TRUE")}
  }
  assertthat::assert_that(is.logical(fast))

  if(fast & delta){
    warning("fast = TRUE has no effect if delta = TRUE")
  }

  # assertthat::assert_that(is.logical(delta))
  if(!is.null(hue)){       assertthat::assert_that(is.numeric(hue))}
  if(!is.null(saturation)){assertthat::assert_that(is.numeric(saturation))}
  if(!is.null(brightness)){assertthat::assert_that(is.numeric(brightness))}
  if(!is.null(kelvin)){    assertthat::assert_that(is.numeric(kelvin))}
  if(!is.null(duration)){  assertthat::assert_that(is.numeric(duration))}
  if(!is.null(infrared)){  assertthat::assert_that(is.numeric(infrared))}

  if(!all(sapply(list(hue,saturation,brightness,kelvin,color_name),is.null))){
  color_name <- lx_color_name(color_name = color_name,
                              saturation = saturation,
                              hue = hue,
                              brightness = brightness,
                              kelvin = kelvin)
  }

  if(!delta){
  # set the state using 'lx_state' function (which mirrors the lifx api /state endpoint):
  response <- lx_state(power = power,
           color_name = color_name,
           brightness = brightness,
           infrared = infrared,
           duration = duration,
           selector = selector,
           fast = fast,
           token=token)
    return(response)
}

if(delta){
  # set the state using 'lx_state' function (which mirrors the lifx api /state/delta endpoint):
  response <- lx_delta(hue = hue,
                       saturation = saturation,
                       brightness = brightness,
                       kelvin = kelvin,
                       duration = duration,
                       infrared = infrared,
                       power = power,
                       selector = selector,
                       token=token)
}
}



#' check if lifx color name is valid
#' @param color_name a color string in lifx api format (can be made with \code{\link{lx_color_name}} )
#' @template param_token
#' @export
lx_check_color<-function(color_name,token =  get_lifx_token()){
  url <- paste0("https://api.lifx.com/v1/color?string=",utils::URLencode(color_name))
  header<-lx_auth(token)
  response <- httr::GET(url,header)
  if(response$status_code==422){return(FALSE)}
  if(response$status_code==200){return(TRUE)}
  if(response$status_code==401){
    message("bad token - could not check color")
    return(FALSE)}
  print(response)
  stop(paste("Error:", response$status_code))
  return(color_name)
}


