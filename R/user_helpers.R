
#' select lights
#'
#' use this function to select lights that you want to communicate with
#' @param id the id of the lamp(s) to select
#' @param label the label of the lamp(s) to select
#' @param group_id the group_id of the lamp(s) to select
#' @param group the group of the lamp(s) to select
#' @param location_id the location_id of the lamp(s) to select
#' @param location the location of the lamp(s) to select
#' @param zones the zones of the lamp(s) to select
#' @details this creates strings to select lamps in the format that the lifx api expects (see https://api.developer.lifx.com/docs/selectors). This function is intended to be used to create a "selector" that is then passed to a function that changes the state of the lamps.
lx_selector<-function(
  id = NULL,
  label = NULL,
  group_id = NULL,
  group = NULL,
  location_id = NULL,
  location = NULL,
  zones = NULL){
  args <- as.list(match.call())
  # remove fun name from args
  args <- args[-1]

  # must add |1|2|3 if zones = c(1,2,3) at the end of each selector:
  if(!is.null(zones)){
    # remove 'zones' from argument list:
    args <- args[-length(args)]
    zones_string<-paste0("|",paste0(zones,collapse = "|"))
  }else{
      zones_string<-""
  }

  if(length(args)==0){return(paste0("all",zones_string))}

  paste0(paste0(paste0(names(args),":",args),zones_string), collapse = ",")
}



#' picking a color by name or hsbk
#' @param hue set the hue (0-255)
#' @param saturation set the saturation (0-1)
#' @param brightness set the brightness (0-1)
#' @param kelvin set the colour temperature. limits depend on the specific lamp; limits are likely in the range of 2500-9000
#' @param name a color name, hexcode or string in lifx api format (see https://api.developer.lifx.com/docs/colors). If this parameter is used, all others will be ignored.
#' @param token API token (see ?save_lifx_token). If left empty, the token is retreived from the environmental variable if available. (see \code{\link{save_lifx_token}})
#' @export
lx_color_name <- function(
                   hue=NULL,
                   saturation=NULL,
                   brightness=NULL,
                   kelvin=NULL,
                   name=NULL,
                   token =  get_lifx_token() ){
  if(!is.null(name)){
    lx_check_color(name,token = token)
    return(name)
  }

  inputs<-list(hue,saturation,brightness, kelvin)
  names(inputs)<-c("hue", "saturation", "brightness","kelvin")
  inputs<-unlist(inputs)
  # generate a string of color information as the lifx api expects it (https://api.developer.lifx.com/docs/colors)
  color_string<-paste(names(inputs),":",inputs,collapse = " ",sep="")
  # call api to validate color
  lx_check_color(color_string,token = token)
  return(color_string)

}
