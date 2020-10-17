# `iNaturalist`


## About
R Package to download formated inages from iNaturalist website. Plan to
add few more handy tools soon.

### Installation

```r
#install.packages("devtools")
require(devtools)

install_github("ropensci/rinat")
install_github("vijaybarve/iNaturalist")
require(rinat)
require(iNaturalist)
```


### Use following code to download images
```r
font <- "Times"
fontsize <- 18
fontstyle <- NA
fontcolor <- "white"
myfmt <- NULL
myfmt[[1]] <- c("border","black","20x50")
myfmt[[2]] <- c("border","grey", "2x2")
myfmt[[3]] <- c("annotate",c('"\u00A9"', 'photoby','"   "'),font,fontstyle,
                fontcolor, fontsize,"southeast")
myfmt[[4]] <- c("annotate",c('" "','scname'),font,"italic",
                fontcolor,fontsize,"northwest")
myfmt[[5]] <- c("annotate",c('"\\n "', 'cname'),font,fontstyle,
                fontcolor, fontsize,"northwest")
myfmt[[6]] <- c("annotate",c('" "','place','"\\n "', 'photodate'),font,fontstyle,
                fontcolor, fontsize,"southwest")
myfmt[[7]] <- c("annotate",c('"iNat Id \\n "','obs_id','" "'),font,fontstyle,
                fontcolor, fontsize,"northeast")

# Get some iNaturalist data for a butterfly Idea malabarica
inatdata <- get_inat_obs(query = "Idea malabarica", maxresults = 6)
downlaod_inat_images(inatdata, size="medium", outpath=".\\test\\", 
                     img_format=myfmt, firstonly=TRUE, verbose=TRUE)

# Get some iNaturalist data for a user
inatdata <- get_inat_obs_user("vijaybarve", maxresults = 5)
downlaod_inat_images(inatdata, size="medium", outpath=".",
                     img_format=myfmt, firstonly=TRUE, verbose=TRUE)

```


