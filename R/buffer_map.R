# Generating a map of NS with ADCP buffers
# Updated 2024-07-29, by LB

# Load required libraries
library(dplyr)
library(here)
library(sf)
library(googlesheets4)
library(plotly)
library(rnaturalearth)
library(ggplot2)
library(viridis)

# Read in the ns_base_map function from its R script
source(here("R/ns_base_map.R"))


# Access Area Info tabs from ADCP and STRING TRACKING sheets

# Google sheets links removed for security

# Depl within 500m ------------------------------------------------------------

# Adding a column with the buffers around all ADCPs
ADCP_list_500_m <- ADCP_list %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4617) %>%
  st_buffer(dist = 500) %>%
  rename(Buffer = geometry)

# Adding a column with the coordinates of all stations
station_list <- station_list %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4617) %>%
  rename(coordinates = geometry)

# Assign the plot to a value p
p <- ns_base_map() +
  geom_sf(data = ADCP_list_500_m$Buffer, fill = "#a6eaf5") +
  geom_sf(data = station_list$coordinates) +
  theme(legend.position = "none") 

# Print the interactive plot
ggplotly(p)

# Depl within 1000m ------------------------------------------------------------

ADCP_list_1000_m <- ADCP_list %>%
  st_as_sf(coords = c("longitude", "latitude"), crs = 4617) %>%
  st_buffer(dist = 1000) %>%
  rename(Buffer = geometry)

# Assign the plot to a value p
p_2 <- ns_base_map() +
  geom_sf(data = ADCP_list_1000_m$Buffer, fill = "#a6eaf5") +
  geom_sf(data = station_list$coordinates) +
  theme(legend.position = "none") 

# Print the interactive plot
ggplotly(p_2)
