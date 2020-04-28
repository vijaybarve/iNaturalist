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


### USe following code to download images
```r
myfmt <- NULL
myfmt[[1]] <- c("border","white","20x50")
myfmt[[2]] <- c("border","grey", "2x2")
myfmt[[3]] <- c("annotate",c('"\u00A9"', 'photoby','"   "'),"black",NA, 20,"southeast")
myfmt[[4]] <- c("annotate",c('" "','scname','"\\n "', 'cname'),"black",NA, 20,"northwest")
myfmt[[5]] <- c("annotate",c('" "','place','"\\n "', 'photodate'),"black",NA, 20,"southwest")
myfmt[[6]] <- c("annotate",c('"iNat Id \\n "','obs_id','" "'),"black",NA, 20,"northeast")

# Get some iNaturalist data for a butterfly Idea malabarica
inatdata <- get_inat_obs(query = "Idea malabarica",maxresults = 5)
downlaod_inat_images(inatdata,size="medium", outpath=".\\test\\", img_format=myfmt,
                     firstonly=TRUE,verbose=TRUE)
# Get some iNaturalist data for a user
inatdata <- get_inat_obs_user("vijaybarve", maxresults = 15)
downlaod_inat_images(inatdata,size="medium", outpath=".\\test\\", img_format=myfmt,
                     firstonly=TRUE,verbose=TRUE)
```


