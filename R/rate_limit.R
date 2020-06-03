#' get lifx API rate limit
#' @template param_token
#' @return a named vector of three numbers:
#'
#' 1. `limit`: The rate limit
#' 2. `remaining`: how many calls are remaining
#' 3. `reset`: the Unix timestamp for when the next window begins. Usually every minute.
#' @export
lx_rate_limit <- function(token = get_lifx_token()) {
    light_list <- lx_list_lights(token = token)
    
    limits <- c(limit = as.numeric(light_list$headers$`x-ratelimit-limit`), remaining = as.numeric(light_list$headers$`x-ratelimit-remaining`), 
        reset = as.numeric(light_list$headers$`x-ratelimit-reset`))
    limits
}
