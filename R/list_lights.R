#' list available lights
#' @template param_selector
#' @template param_token
#' @return an 'httr' response object (see \code{\link[httr]{response}})
#' @examples
#' \dontrun{
#' lx_list_lights()
#' lx_list_lights(
#'   lx_selector(location = "kitchen")
#' )
#' }
#' @export
lx_list_lights <- function(selector = "all", token = lx_get_token()) {
    lx_GET(selector = selector, endpoint = "", token = token)
}
