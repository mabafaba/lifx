# generic state modifiers ----------------------------------------------------

#' set light state (lifx API endpoint PUT set state)
#'
#' @param power character string - if set to "on", turns the light on, if set to "off" turns it off.
#' @param color_name a color name, hexcode or output from \code{\link{lx_color_name}} (in lifx api format (see \url{https://api.developer.lifx.com/docs/colors}). If this parameter is used, other parameters may be ignored.
#' @param brightness set the brightness (0-1)
#' @param infrared infrared brightness (0-1)
#' @param duration in seconds, how long to perform the transition
#' @param fast if TRUE, executes the query fast, without initial state checks and wait for no results. See \url{https://api.developer.lifx.com/docs/set-state}
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @return an httr response object (see \code{\link[httr]{response}})
#' @references \url{https://api.developer.lifx.com/docs/set-state}
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
                     power=power,      # query body as ... (dots):
                     color=color_name,
                     brightness=brightness,
                     infrared=infrared,
                     duration=duration,
                     fast=fast
  )

  invisible(response)
}


#' Change light state relative to current state (wrapper for POST state delta
#' @param hue set the hue (0-255)
#' @param saturation set the saturation (0-1)
#' @param brightness set the brightness (0-1)
#' @param kelvin set the colour temperature. limits depend on the specific lamp; limits are likely in the range of 2500-9000
#' @param infrared infrared brightness (0-1)
#' @param duration in seconds, how long to perform the transition
#' @param power character string - if set to "on", turns the light on, if set to "off" turns it off.
#' @param selector lifx api "selector" such as "all", "id:12345", or "location:kitchen". Can be created with \code{\link{lx_selector}} or written manually (see \url{https://api.developer.lifx.com/docs/selectors}
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @return an httr response object (see \code{\link[httr]{response}})
#' @references \url{https://api.developer.lifx.com/docs/state-delta}
#' @export
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


