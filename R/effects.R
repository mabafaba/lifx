#' "Breathe" effect
#'
#' @param color color The color to use for the breathe effect. use lx_color() as input
#' @param from_color The color to start the effect from. If this parameter is omitted then the color the bulb is currently set to is used instead.
#' @param period The time in seconds for one cycle of the effect.
#' @param cycles The number of times to repeat the effect.
#' @param persist boolean; If FALSE set the light back to its previous value when effect ends, if true leave the last effect color.
#' @param power_on boolean; If true, turn the bulb on if it is not alxlready on.
#' @param peak Defines where in a period the target color is at its maximum. Minimum 0.0, maximum 1.0.
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
          endpoint = paste0("effects","/" ,effect),
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
#' @inheritParams lx_effect_breathe
#' @param color color The color to use for the breathe effect. use lx_color() as input
#' @param from_color The color to start the effect from. If this parameter is omitted then the color the bulb is currently set to is used instead.
#' @param persist boolean; If FALSE set the light back to its previous value when effect ends, if true leave the last effect color.
#' @param peak Defines where in a period the target color is at its maximum. Minimum 0.0, maximum 1.0.
#' @export
lx_effect_move<-function(
  direction = "forward",
                    period=1,
                    cycles = Inf,
                    persist = NULL,
                    power_on = TRUE,
                    fast = FALSE,
                    selector = "all",
                    token =  get_lifx_token()
                    ){

lx_POST(selector,
        endpoint = paste0("effects","/" ,"move"),
        token = token,
        color = color,
        from_color = from_color,
        period = period,
        cycles = cycles,
        persist = persist,
        power_on = power_on,
        peak = peak,
        fast = fast)
}
#'
#'
#' #' "Morph" effect
#' #'
#' #' @inheritParams lx_effect_breathe
#' #' @inheritParams lx_effect_move
#' #' @param palette color The color to use for the breathe effect. use lx_color() as input
#' #' @param from_color The color to start the effect from. If this parameter is omitted then the color the bulb is currently set to is used instead.
#' #' @param persist boolean; If FALSE set the light back to its previous value when effect ends, if true leave the last effect color.
#' #' @param peak Defines where in a period the target color is at its maximum. Minimum 0.0, maximum 1.0.
#' #' @export
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
#'           endpoint = paste0("effects","/" ,"move"),
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