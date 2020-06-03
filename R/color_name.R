



#' picking a color by name or hsbk
#' @template param_colors
#' @template param_color_name
#' @param check if FALSE does not call the API to check if the color is valid
#' @template param_token
#' @export
lx_color_name <- function(hue = NULL, saturation = NULL, brightness = NULL, kelvin = NULL, color_name = NULL, check = TRUE, token = get_lifx_token()) {

    inputs <- list(hue, saturation, brightness, kelvin)
    names(inputs) <- c("hue", "saturation", "brightness", "kelvin")
    inputs <- unlist(inputs)
    # generate a string of color information as the lifx api expects it (https://api.developer.lifx.com/docs/colors)
    if (length(inputs) == 0) {
        color_string <- ""
    } else {
        color_string <- paste(names(inputs), ":", inputs, collapse = " ", sep = "")
    }

    color_string <- paste(color_name, color_string)
    # call api to validate color
    if(check){
    if (!lx_check_color(color_string, token = token)) {
        stop("invalid color specification.")
    }
    }
    class(color_string) <- c("lx_color_string", class(color_string))
    return(color_string)
}


#' @method print lx_color_string
#' @export
print.lx_color_string <- function(x, ...) {
    cat(crayon::silver("lx color:"))
    cat(crayon::italic(x))
    invisible(x)
}




#' check if lifx color name is valid
#' @param color_name a color string in lifx api format (can be made with \code{\link{lx_color_name}} )
#' @template param_token
#' @export
lx_check_color <- function(color_name,  token = get_lifx_token()) {
  url <- paste0("https://api.lifx.com/v1/color?string=", utils::URLencode(color_name))
  header <- lx_auth(token)
  response <- httr::GET(url, header)
  if (response$status_code == 422) {
    return(FALSE)
  }
  if (response$status_code == 200) {
    return(TRUE)
  }
  if (response$status_code == 401) {
    message("bad token - could not check color")
    return(FALSE)
  }
  print(response)
  stop(paste("Error:", response$status_code))
  return(color_name)
}


