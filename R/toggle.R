#' Toggle light
#' @template param_duration
#' @template param_selector
#' @template param_token
#' @export
lx_toggle <- function(duration = 0, selector = "all", token = lx_get_token()) {
    lx_POST(selector, endpoint = "toggle", token = token, duration = duration)
}










