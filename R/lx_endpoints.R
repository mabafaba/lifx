# generic state modifiers ----------------------------------------------------

#' set light state (wrapper for PUT Set State https://api.developer.lifx.com/docs/set-state)
#' @param power "on" or "off"
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @param brightness set the brightness (0-1)
#' @param color_name a color name, hexcode or output from \lx_color_name() (in lifx api format (see https://api.developer.lifx.com/docs/colors). If this parameter is used, other parameters may be ignored.
#' @param infrared infrared brightness (0-1)
#' @param duration in seconds, how long to perform the transition
#' @param selector lifx API selector criteria; can be created with lx_select() or written manually
#' @param fast Execute the query fast, without initial state checks and wait for no results. See https://api.developer.lifx.com/docs/set-state
#' @param delta if set to TRUE, color values (hue, saturation, brightness, kelvin, infrared) are added to the lights' current values. Can not be used in combination with `color_name`
#' @param power string - if set to "on", turns the light on, if set to "off" turns it off.
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @export
lx_state<-function(power=NULL,
                   color_name=NULL,
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
                     color=color_name,
                     brightness=brightness,
                     infrared=infrared,
                     duration=duration,
                     fast=fast
  )

  invisible(response)
}


#' Change light state relative to current state
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})

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


