# lifx light color
#'
#' change the state of lifx lamps
#'
#' @param hue set the hue (0-255)
#' @param saturation set the saturation (0-1)
#' @param brightness set the brightness (0-1)
#' @param kelvin set the colour temperature. limits depend on the specific lamp; limits are likely in the range of 2500-9000
#' @param color_name a color name, hexcode or output from lx_color() (in lifx api format (see \url{https://api.developer.lifx.com/docs/colors}). If this parameter is used, other parameters may be ignored.
#' @param infrared infrared brightness (0-1)
#' @param duration in seconds, how long to perform the transition
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param fast Executes the query fast, without initial state checks and wait for no results. See \url{https://api.developer.lifx.com/docs/set-state}
#' @param delta if set to TRUE, color values (hue, saturation, brightness, kelvin, infrared) are added to the lights' current values. Can not be used in combination with `color_name`
#' @param power string - if set to "on", turns the light on, if set to "off" turns it off.
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @export
lx_color <- function(hue=NULL,
                   saturation=NULL,
                   brightness=NULL,
                   kelvin=NULL,
                   duration=NULL,
                   infrared = NULL,
                   color_name = NULL,
                   fast = NULL,
                   delta = FALSE,
                   selector="all",
                   power = NULL,
                   token =  get_lifx_token()){

  # check inputs

  if(!is.null(color_name)){
    if(delta){stop("can not use parameter color_name when delta is set to TRUE")}
  }
  if(!is.null(fast)){
  assertthat::assert_that(is.logical(fast))
  }
  # assertthat::assert_that(is.logical(delta))
  if(!is.null(hue)){       assertthat::assert_that(is.numeric(hue))}
  if(!is.null(saturation)){assertthat::assert_that(is.numeric(saturation))}
  if(!is.null(brightness)){assertthat::assert_that(is.numeric(brightness))}
  if(!is.null(kelvin)){    assertthat::assert_that(is.numeric(kelvin))}
  if(!is.null(duration)){  assertthat::assert_that(is.numeric(duration))}
  if(!is.null(infrared)){  assertthat::assert_that(is.numeric(infrared))}


  color_string <- lx_color_name(name = color_name,saturation = saturation,hue = hue,brightness = brightness,kelvin = kelvin)

  if(!delta){
  # set the state using 'lx_state' function (which mirrors the lifx api /state endpoint):
  lx_state(power = power,
           color_name = color_string,
           brightness = brightness,
           infrared = infrared,
           duration = duration,
           selector = selector,
           fast = fast,
           token=token)
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
#' @param color_string a color string in lifx api format (can be made with \code{\link{lx_color_name}} )
#' @param token API token. If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @export
lx_check_color<-function(color_string,token =  get_lifx_token()){
  url <- paste0("https://api.lifx.com/v1/color?string=",utils::URLencode(color_string))
  header<-lx_auth(token)
  response <- httr::GET(url,header)
  if(response$status_code==422){return(FALSE)}
  if(response$status_code==200){return(TRUE)}
  if(response$status_code==401){message("bad token")}
  print(response)
  stop(paste("Error:", response$status_code))
  return(color_string)
}


