library(shiny)
library(leaflet)
library(vcd)
library(grid) # needed for gpar
library(shinydashboard)
library(XML)
library(zipcode)
library(plotly)
library(choroplethr)
library(dplyr)
library(ggplot2)
library(devtools)
library(choroplethrZip)
library(mapproj)
library(stringr)
library(proxy) 


#Load data
Trees=read.csv("tree_app_final.csv")
Trees<-rename(Trees,"Recorder_type"="user_type")
Trees<-rename(Trees,"Tree_species"="species")
Types=names(summary(Trees$Tree_species))

 