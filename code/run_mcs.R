#!/usr/bin/Rscript

library(ncdf4)
library(raster)
library(EBImage)
        
rm(list = ls())
prf = list.files("../data/MERG/", pattern = ".nc")
dt_dir = "../data/MERG"

#### Membuat Fungsi Pembacaan Luas Cluster Awan dan Geometrinya ####


####################################################################

for(i in 1:length(prf)){
  print(paste0(dt_dir,"/", prf[i] ))
}