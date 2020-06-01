



#' picking a color by name or hsbk
#' @param hue set the hue (0-255)
#' @param saturation set the saturation (0-1)
#' @param brightness set the brightness (0-1)
#' @param kelvin set the colour temperature. limits depend on the specific lamp; limits are likely in the range of 2500-9000
#' @param color_name a color name, hexcode or string in lifx api format (see https://api.developer.lifx.com/docs/colors).
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @export
lx_color_name <- function(
                   hue=NULL,
                   saturation=NULL,
                   brightness=NULL,
                   kelvin=NULL,
                   color_name=NULL,
                   token =  get_lifx_token() ){

  inputs<-list(hue,saturation,brightness, kelvin)
  names(inputs)<-c("hue", "saturation", "brightness","kelvin")
  inputs<-unlist(inputs)
  # generate a string of color information as the lifx api expects it (https://api.developer.lifx.com/docs/colors)
  if(length(inputs)==0){
    color_string <- ""}else{
      color_string<-paste(names(inputs),":",inputs,collapse = " ",sep="")
    }

  color_string <-paste(color_name, color_string)
  # call api to validate color
  if(!lx_check_color(color_string,token = token)){stop("invalid color specification.")}
  class(color_string)<-c("lx_color_string", class(color_string))
  return(color_string)
}


#' @method print lx_color_string
#' @export
print.lx_color_string <- function(x, ...){
  cat(crayon::silver("lx color:"))
  cat(crayon::italic(x))
  invisible(x)
}
