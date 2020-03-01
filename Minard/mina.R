library(ggplot2)
library(tidyverse)
library(knitr)
library(lubridate)
library(ggmap)
library(ggrepel)
library(gridExtra)
library(pander)
library(extrafont)
library(plyr)

#Load fonts for windows
#font_import()
#loadfonts(device = "win")

#set working directory for the R script
setwd("D:/OneDrive - TCDUD.onmicrosoft.com/MSc/Sem 2/DV/git/Minard")

# get data for troops size and their movement
troopsData <- read.table("./data/troops.txt", header = T)

#print troops data
troopsData

#read temperature data and convert string to date
temperatures <- read.table("./data/temp.txt", header = T) %>%
  mutate(date = dmy(date))

#print temperature data
temperatures

#read data of city longitude and latitude
cities <- read.table("./data/cities.txt", header = T)

#print city data
cities

#get watercolor map of europe
europe_map <- c(left = 23.5, bottom = 53.4, right = 38.1, top = 56.3)
europe_map_wc <- get_stamenmap(bbox = europe_map, zoom = 7,
                                          maptype = "watercolor", where = "cache")

#Create a plot of troops data with geom_path 
#Size of path is defined by number of survivors
#color of the path is decided by direction of travel
#Group of army is used to show paths of different troops
#Overlay this plot on europe map
troops_data_on_europe <- ggmap(europe_map_wc) +
  geom_path(data = troopsData, 
              aes(x = long, 
                  y = lat, 
                  group = group, 
                  color = direction, size = survivors))

troops_data_on_europe

#Overlay labels of city names on the plot
troops_data_on_europe_with_cities <-  troops_data_on_europe + 
  geom_label(data = cities, label.size = 0.1,label.padding = unit(0.1, "lines"),
             mapping = aes(label = city, family = "Constantia"),
             size = 4)

#Apply scale and theme on the map
#Change color of paths
#Remove legend, text on x & y axis
#provide title
themed_scaled_map_data <- troops_data_on_europe_with_cities + 
  scale_size(
    range = c(0, 15)
  ) +
  scale_color_manual(values = c("#B25800", "#00b34a")) +
  labs(title = "Napoleon's Russian campaign in 1812",
       x = NULL,
       y = NULL) +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "None"
  )

themed_scaled_map_data

#Format temperature values in Temp°, month. day format
temperatures.formatted <- temperatures %>%
  mutate(formatted.label = paste0(temp, "°, ", month, ". ", day))

#Create a line plot with temperature labels
temprature_plot <-
  ggplot(data = temperatures.formatted, aes(x = long, y = temp)) +
  geom_line() +
  geom_label(aes(label = formatted.label),
             family = "Segoe UI Black", size = 3.5)

#Apply scaling and themes
#Remove x axis labels & ticks
#Remove border
temprature_plot <- temprature_plot +
  labs(x = NULL, y = "° Celsius") +
  scale_y_continuous(position = "right", limits = c(-32,3)) +
  theme_bw(base_family = "Constantia") +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank()
  )

temprature_plot

#Combine both army path and temperature plots based on longitude values
combined_plots <- rbind(ggplotGrob(themed_scaled_map_data),
                        ggplotGrob(temprature_plot))

#Show plot
grid::grid.newpage()
grid::grid.draw(combined_plots)

#Save plot
ggsave(filename = "CombinedPlot.png", plot = combined_plots, scale = 2, dpi = 600)
