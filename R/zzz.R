img_format2str <- function(myfmt){
  fmt_str <- 'myimg <- myimg %>% '
  for(i in 1:length(myfmt)){
    switch(myfmt[[i]][1],
           "border"={
             fmt_str <- paste(fmt_str,"\n ",'image_border( "',
                              myfmt[[i]][2],'","',myfmt[[i]][3],'") %>% ',
                              sep="")
           },
           "annotate"={
             arglength <- length(myfmt[[i]])
             fmt_str <- paste(fmt_str,"\n ",'image_annotate(paste(',sep="")
             for(j in 2:(arglength-4)){
               fmt_str <- paste(fmt_str,'',myfmt[[i]][j],',',sep="")
             }
             fmt_str <- paste(fmt_str,'sep=""),')
             if(is.na(myfmt[[i]][arglength -3])){
               myfont <- "sans"
             } else {
               myfont <- myfmt[[i]][arglength -3]
             }
             fmt_str <- paste(fmt_str,' font = "',myfont,'",',sep="")
             fmt_str <- paste(fmt_str,' color = "',myfmt[[i]][arglength -2],'",',sep="")
             fmt_str <- paste(fmt_str,' size = ',myfmt[[i]][arglength -1],',',sep="")
             fmt_str <- paste(fmt_str,' gravity = "',myfmt[[i]][arglength ],'") %>% ',sep="")
           }
    )
  }
  fmt_str <- substr(fmt_str,1,nchar(fmt_str)-4)
  return(fmt_str)
}
