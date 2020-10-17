#' Download iNaturalist images
#'
#' Download iNaturalist images
#'
#' @param dat data frame containing iNaturalist records
#' @param size image size. Values accepted are "small", "medium", "large", "original".
#' Deafault(medium).
#' @param outpath path to the output folder
#' @param img_format image formating parameters in the form of list. Detailed
#' documentation is in the function \code{\link{format_image}}
#' @param firstonly All images need to be downloaded or only first for each
#' iNaturalist record
#' @param verbose should messges on progress to be displayed
#' @family image functions
#' @importFrom utils download.file
#' @examples
#' \dontrun{
#' font <- "Times"
#' fontsize <- 18
#' fontstyle <- NA
#' fontcolor <- "white"
#' myfmt <- NULL
#' myfmt[[1]] <- c("border","black","20x50")
#' myfmt[[2]] <- c("border","grey", "2x2")
#' myfmt[[3]] <- c("annotate",c('"\u00A9"', 'photoby','"   "'),font,fontstyle,
#'                 fontcolor, fontsize,"southeast")
#' myfmt[[4]] <- c("annotate",c('" "','scname'),font,"italic",
#'                 fontcolor,fontsize,"northwest")
#' myfmt[[5]] <- c("annotate",c('"\\n "', 'cname'),font,fontstyle,
#'                 fontcolor, fontsize,"northwest")
#' myfmt[[6]] <- c("annotate",c('" "','place','"\\n "', 'photodate'),font,fontstyle,
#'                 fontcolor, fontsize,"southwest")
#' myfmt[[7]] <- c("annotate",c('"iNat Id \\n "','obs_id','" "'),font,fontstyle,
#'                 fontcolor, fontsize,"northeast")
#'
#'# Get some iNaturalist data for a butterfly Idea malabarica
#' inatdata <- get_inat_obs(query = "Idea malabarica",maxresults = 5)
#' downlaod_inat_images(inatdata,size="medium", outpath=".", img_format=myfmt,
#'                      firstonly=TRUE,verbose=TRUE)
#'
#' # Get some iNaturalist data for a user
#' inatdata <- get_inat_obs_user("vijaybarve", maxresults = 5)
#' downlaod_inat_images(inatdata,size="medium", outpath=".", img_format=myfmt,
#'                      firstonly=TRUE,verbose=TRUE)
#' }
#' @export
downlaod_inat_images <- function(dat,size="medium", outpath=".", img_format=NULL,
                            firstonly=TRUE,verbose=TRUE){
  # Need to check if dat is not empty and it is indeed iNaturalist data
  if(!dir.exists(outpath)){
    dir.create(outpath)
    warning(paste("Counld not fing folder",outpath,". Creating folder."))
  }

  for (i in 1:nrow(dat)){
    if(verbose){
      if(firstonly){
        cat(paste("\n",dat$id[i]))
      }else{
        cat(paste("\n",dat$id[i]," :"))
      }
    }
    imginfo <- get_inat_obs_id(dat$id[i])
    medurl <- imginfo$observation_photos$photo$medium_url
    no_images <- imginfo$observation_photos_count
    if(no_images>0){
      for (img_no in 1:no_images){
        if(firstonly){
          iname <- paste(outpath,dat$id[i]," ",
                         dat$scientific_name[i]," ",
                         dat$observed_on[i],".jpg",sep="")
          myimg <- format_image(imginfo,img_no,size,img_format)
          image_write(myimg,iname,format = "jpg")
          break
        } else {
          iname <- paste(outpath,dat$id[i],"_",
                         img_no, " ",
                         dat$scientific_name[i]," ",
                         dat$observed_on[i],".jpg",sep="")
          myimg <- format_image(imginfo,img_no,size,img_format)
          image_write(myimg,iname,format = "jpg")
          cat("+")
        }
      }
    }
  }
  cat("\n\n")
}
