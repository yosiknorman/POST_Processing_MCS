#!/usr/bin/Rscript

rm(list = ls())

stringfile = c("Starttime is: ", 
"Endtime is: ",
"Life duration is ",
"Time of maturity is ",
"Duration mature stage is: ",
"Average area is: ",
"Max area is: ",
"Max area time is: ",
"Eccentricity at max area is: ",
# "Center (lat,lon) at max area is: ",
" bujurlintang ",
"Propagation speed is ")

txt = read.csv(file = "../data/MCSsUserFile.txt", sep = "\n", header = F)
txt = c(as.matrix(txt))

filter_str = function(MCS_USERFILE, uniq_str){
  mana = grep(MCS_USERFILE, pattern = uniq_str)
  hasil = MCS_USERFILE[mana]
  if(uniq_str == "Starttime is: "){
    jmlstr = nchar("Starttime is: 2007-10-27 00:30:00")
    hasil = substr(hasil, 1, jmlstr)
    for(i in 1:length(hasil)){
      hasil[i] = strsplit(hasil[i], split = uniq_str)[[1]][2]
    }
  }else if(uniq_str == "Endtime is: "){
    jmlstr = nchar("Endtime is: 2007-10-27 00:30:00")
    hasil = substr(hasil, 1, jmlstr)
    for(i in 1:length(hasil)){
      hasil[i] = strsplit(hasil[i], split = uniq_str)[[1]][2]
    }
  }
  return(hasil)
}

t0 = filter_str(MCS_USERFILE = baru_txt, uniq_str = stringfile[10])
tn = filter_str(MCS_USERFILE = txt, uniq_str = stringfile[2])
interval = as.vector(abs(as.POSIXct(t0) - as.POSIXct(tn)))

baru_txt = gsub (x = txt, pattern = "\\t", replacement = " bujurlintang ")
lonlat = filter_str(MCS_USERFILE = baru_txt, uniq_str = stringfile[10])
lon = c()
lat = c()
for(i in 1:length(lonlat)){
  lat[i] = as.numeric(strsplit(lonlat[i], split = " ")[[1]][7])
  lon[i] = as.numeric(strsplit(lonlat[i], split = " ")[[1]][9])
}
plot(x =lon, y = lat, col = "red", xlim = c(90, 150), ylim  = c(-15, 15))
library(maps)
map(add = T)

strsplit(t0, split = " ")[[1]][7]
strsplit(t0, split = " ")[[1]][9]
hasil_semua = list()
for(i in 1:length(stringfile)){
  hasil_semua[[i]] = filter_str(MCS_USERFILE = baru_txt, uniq_str = stringfile[i])
}

# n = "Center (lat,lon) at max area is: -1.51\t129.20"


res = data.frame(Awal = t0, Akhir = tn, Durasi = interval)
write.table(file = "../hasil/awal_akhir.csv", res, row.names = F, col.names = T)
system("mkdir ../hasil")
