#' "Breathe" effect
#'
#' @param color color The color to use for the breathe effect. use lx_color() as input
#' @param from_color The color to start the effect from. If this parameter is omitted then the color the bulb is currently set to is used instead.
#' @param period The time in seconds for one cycle of the effect.
#' @param cycles The number of times to repeat the effect.
#' @param persist boolean; If FALSE set the light back to its previous value when effect ends, if true leave the last effect color.
#' @param power_on If FALSE, does not turn light on if it is off
#' @param peak Defines where in a period the target color is at its maximum. Minimum 0.0, maximum 1.0.
#' @template param_selector
#' @template param_token
#' @export
lx_effect_breathe<-function(
  color,
  from_color = NULL,
  period=NULL,
  cycles = NULL,
  persist = NULL,
  power_on = NULL,
  peak = 0.5,
  selector = "all",
  token =  get_lifx_token()
){

  lx_POST(selector,
          endpoint = paste0("effects","/" ,"breathe"),
          token = token,
          color = color,
          from_color = from_color,
          period = period,
          cycles = cycles,
          persist = persist,
          power_on = power_on,
          peak = peak)
}




#' "Move" effect
#'
#' @param direction Move direction, can be "forward" or "backward".
#' @param period The time in seconds for one cycle of the effect.
#' @param cycles The number of times to move the pattern across the device. Special cases are 0 to switch the effect off, and unspecified to continue indefinitely.
#' @param power_on Switch any selected device that is off to on before performing the effect.
#' @template param_fast
#'
#' @template param_token
#' @template param_selector
#' @export
lx_effect_move<-function(
  direction = "forward",
  period=1,
  cycles = Inf,
  power_on = TRUE,
  fast = FALSE,

  selector = "all",
  token =  get_lifx_token()
){

  lx_POST(selector,
          endpoint = paste0("effects","/" ,"move"),
          token = token,

          direction = direction,
          period = period,
          cycles = cycles,
          power_on = power_on,
          fast = fast)
}



#' #' "Morph" effect
#' #'
#' @param palette color The color to use for the breathe effect. use lx_color() as input
#' @param from_color The color to start the effect from. If this parameter is omitted then the color the bulb is currently set to is used instead.
#' @param persist boolean; If FALSE set the light back to its previous value when effect ends, if true leave the last effect color.
#' @param peak Defines where in a period the target color is at its maximum. Minimum 0.0, maximum 1.0.
#' @export
#' lx_effect_move<-function(
#'   direction = "forward",
#'   period=1,
#'   cycles = Inf,
#'   persist = NULL,
#'   power_on = TRUE,
#'   fast = FALSE,
#'   selector = "all",
#'   token =  get_lifx_token()
#' ){
#'
#'   lx_POST(selector,
#'           endpoint = paste0("effects","/" ,"morph"),
#'           token = token,
#'           color = color,
#'           from_color = from_color,
#'           period = period,
#'           cycles = cycles,
#'           persist = persist,
#'           power_on = power_on,
#'           peak = peak,
#'           fast = fast)
#' }
