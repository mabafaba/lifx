#' list available lights
#' @template param_selector
#' @template param_token
#' @return the API response
#' @export
lx_list_lights <- function(selector = "all", token = get_lifx_token()) {
    lx_GET(selector = selector, endpoint = "", token = token)
}
