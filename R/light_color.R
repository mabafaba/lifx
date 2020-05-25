

#' we wrap in three steps:
#'
#' 1. a user facing function based on what the user probably wants to do (i.e. set light color)
#' 2. a function wrapping each specific api endpoint (i.e. lx_state())
#' 3. a function wrapping httr verbs PUT POST GET


# set light color
#' @inheritParams lx_state
#' @param color_name a color name, hexcode or output from lx_color() (in lifx api format (see https://api.developer.lifx.com/docs/colors). If this parameter is used, other parameters may be ignored.
#' @param hue set the hue (0-255)
#' @param saturation set the saturation (0-1)
#' @param brightness set the brightness (0-1)
#' @param kelvin set the colour temperature. limits depend on the specific lamp; limits are likely in the range of 2500-9000
#' @param hue
#' @param duration
#' @param infrared
#' @param color
#' @param fast Execute the query fast, without initial state checks and wait for no results. See https://api.developer.lifx.com/docs/set-state
#' @param duration in seconds, how long to perform the transition
#' @param selector lifx API selector criteria; can be created with lx_select() or written manually
#' @param token API token (see ?get_lifx_token)
#' @param ... further parameters passed to lx_state()
lx_light_color <- function(hue=NULL,
                   saturation=NULL,
                   brightness=NULL,
                   kelvin=NULL,
                   duration=NULL,
                   infrared = NULL,
                   color_name = NULL,
                   fast = NULL,
                   selector="all",
                   ... ,
                   token =  get_lifx_token()){

  # check inputs


  color_string <- lx_color(name = color_name,saturation = saturation,hue = hue,brightness = brightness,kelvin = kelvin)

  # set the state using the more generic 'lx_state' function:
  lx_state(color = color_string,
           duration = duration,
           selector = selector,
           fast = fast,
           token=token,
           ...)
}



# Change the light relative to current state

#' @inheritParams lx_delta
lx_light_change<-function(
                       hue=NULL,
                       saturation=NULL,
                       brightness=NULL,
                       kelvin=NULL,
                       duration=NULL,
                       infrared = NULL,
                       power = NULL,
                       selector="all",
                       ... ,
                       token =  get_lifx_token()){

  # check inputs
  # ....

  # set the state using the more generic 'lx_state' function:
  response <- lx_delta(hue = hue,
           saturation = saturation,
           brightness = brightness,
           kelvin = kelvin,
           duration = duration,
           infrared = infrared,
           power = power,
           selector = selector,
           token=token,
           ...)
}






# generic state modifiers ----------------------------------------------------

#' set light state (wrapper for PUT Set State https://api.developer.lifx.com/docs/set-state)
#' @param power "on" or "off"
#' @param additive if TRUE, values will be added to current values (ie. brightness=0.1 will make the lamp 0.1 ligther than currenly). 'color' argument only works if additive = FALSE (default).
lx_state<-function(power=NULL,
                   color=NULL,
                   brightness=NULL,
                   infrared=NULL,
                   duration=0,
                   fast=FALSE,
                   selector="all",
                   token =  get_lifx_token()){

  response <- lx_PUT(endpoint="state", # expected params
           selector=selector,    # expected params
           token=token,          # expected params
           power=power,      # body params as ... (dots):
           color=color,
           brightness=brightness,
           infrared=infrared,
           duration=duration,
           fast=fast
  )

  invisible(response)
}



lx_delta<-function(hue = NULL,
                   saturation = NULL,
                   brightness=NULL,
                   kelvin = NULL,
                   infrared=NULL,
                   duration=0,
                   power=NULL,
                   selector="all",
                   token =  get_lifx_token() ){

  api_call <- lx_POST
  endpoint <- "state/delta"

  response <- lx_POST(endpoint=endpoint, # expected params
                     selector=selector,    # expected params
                     token=token,          # expected params

                     power=power,      # body params as ... (dots):
                     duration=duration,
                     infrared=infrared,
                     hue = hue,
                     saturation = saturation,
                     brightness=brightness,
                     kelvin = kelvin


  )

  invisible(response)

}








check_color<-function(color_string,token =  get_lifx_token()){
  url <- paste0("https://api.lifx.com/v1/color?string=",URLencode(color_string))
  header<-lx_auth(token)
  response <- httr::GET(url,header)
  if(response$status_code==422){return(FALSE)}
  if(response$status_code==200){return(TRUE)}
  if(response$status_code==401){message("bad token")}
  print(response)
  stop(paste("Error:", response$status_code))
  return(color_string)
}


