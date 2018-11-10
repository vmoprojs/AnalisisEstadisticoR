# Analisis Estaistico con R
packages <- c("foreign","ggplot2","rgl","manipulate","ISwR","car","clusterSim",
              "AER","sandwich","lmtest","lmSupport","erer","aod","latticeExtra",
              "RColorBrewer","lattice","tseries","vars")
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
ipak(packages)