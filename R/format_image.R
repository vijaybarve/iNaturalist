#' Download formated iNaturalist images
#'
#' Download iNaturalist images for a recod and format them with metadata
#'
#' @param imginfo iNaturalist id of the record
#' @param img_no image number for the image for the iNaturalist record
#' @param size mage size. Values accepted are "small", "medium", "large", "original". Deafault(medium).
#' @param img_format image formating parameters in the form of list. Each item of the list is a
#' component to be added on the image. currently Border and Annotations are available. For Border
#' the componants of the list are \itemize{ \item{keyword -} {"border"} \item{color -} {color name}
#' \item{border dimentions -} {horizontal x verticle border in pixels.}}
#' For Annotations the componants of the list are \itemize{ \item{keyword -} {"annonate"}
#' \item{text -} { see bellow list of text components}
#' \item{color -} {color name}
#' \item{font size -} {Font size in pixel}
#' \item{placement -} {"southeast", "southwest", "northeast", "northwest"}}
#' Text annotation componants available from the iNaturalist records are as follows
#' \itemize{ \item{obs_id : Observation id by iNaturalist}
#' \item{photoby : Name of photographer}
#' \item{scname : Scientific name}
#' \item{canem : Common name}
#' \item{photodate : Date of record}
#' \item{place : Location }
#' }
#' @family image functions
#' @importFrom rinat get_inat_obs_id
#' @importFrom magick image_read
#' @importFrom magick image_info
#' @importFrom magick image_border
#' @importFrom magick image_annotate
#' @importFrom magick image_write
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' myfmt <- NULL
#' myfmt[[1]] <- c("border","white","20x50")
#' myfmt[[2]] <- c("border","grey", "2x2")
#' myfmt[[3]] <- c("annotate",c('"\u00A9"', 'photoby','"   "'),"black", 20,"southeast")
#' myfmt[[4]] <- c("annotate",c('" "','scname','"\\n "', 'cname'),"black", 20,"northwest")
#' myfmt[[5]] <- c("annotate",c('" "','place','"\\n "', 'photodate'),"black", 20,"southwest")
#' myfmt[[6]] <- c("annotate",c('"iNat Id \\n "','obs_id','" "'),"black", 20,"northeast")
#' format_image(imginfo,img_no,size="medium",img_format=myfmt)
#' }
#' @export
format_image <- function(imginfo,img_no=1,size="medium",img_format=NULL){
  obs_id <- imginfo$id
  photoby <- imginfo$user$name
  medurl <- imginfo$observation_photos$photo$medium_url
  scname <- imginfo$taxon$name
  cname <- imginfo$taxon$default_name$name
  photodate <- imginfo$observed_on
  place <- imginfo$place_guess
  url <- imginfo$uri
  img_url <- medurl[img_no]
  img_url <- gsub("medium",size,img_url)
  myimg <- image_read(img_url)
  if(!is.null(img_format)){
    if(scname==cname){
      cname <- ""
    }
    fmt_str <- img_format2str(img_format)
    eval(parse( text= fmt_str[1]))
  }
  return(myimg)
}
