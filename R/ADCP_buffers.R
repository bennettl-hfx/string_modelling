# Identify all deployments within 500, 1000, 2000 metres of ADCPs
# Author: LB


library(dplyr)
library(here)
library(sf)
library(googlesheets4)

#Retrieve station list from STRING TRACKING and ADCP list from ADCP TRACKING ----

# Google sheet links removed for security

#MUST INITIALIZE ADCP AND DEPLOYMENT COORDINATES IN A DATA FRAME BEFORE PASSING TO THE FUNCTION

check_adcp_ditstance <- function( #Returns true if station is within specified distance of ADCP
    ADCP_coordinates,
    station_coordinates,
    curr_crs = 4617,
    radius = 500
){
  
  ADCP_coordinates_sf <- ADCP_coordinates %>%
    st_as_sf(coords = c("latitude", "longitude"), crs = curr_crs)
  
  ADCP_buffer <- st_buffer(ADCP_coordinates_sf, dist = radius)
  
  station_coordinates_sf <- station_coordinates %>%
    st_as_sf(coords = c("latitude", "longitude"), crs = curr_crs)
  
  location_check <- st_intersection(station_coordinates_sf, ADCP_buffer) 
  
  if(nrow(location_check) == 1){
    return(TRUE)
  }
  
  return(FALSE)
}

centerville_adcp_long_lat <- data.frame(latitude=44.53358, longitude=-66.00035)
centerville_1_station_long_lat <- data.frame(latitude=44.5328, longitude=-65.98404)
centerville_station_long_lat <- data.frame(latitude=44.53624, longitude=-66.00172)

check_adcp_ditstance(centerville_adcp_long_lat, centerville_1_station_long_lat)


# Loop through all stations and ADCPs to find those within 500m ----------------


depl_within_500_m <- data.frame(ADCP=rep(NA, 500), String=rep(NA,500))
depl_within_1000_m <- data.frame(ADCP=rep(NA, 500), String=rep(NA,500))
depl_within_2000_m <- data.frame(ADCP=rep(NA, 500), String=rep(NA,500))
row=1 #Indicating the row of depl_within_500_m which the identified pairs are inserted

for(j in 1:length(ADCP_list$Station_Name)){
  
  curr_ADCP <- ADCP_list$Station_Name[j]
  
  curr_ADCP_coordinates <- data.frame(latitude = ADCP_list$Latitude[j], 
                                      longitude = ADCP_list$Longitude[j]
                                      )
  
  for(i in 1:length(station_list$station)){
    
    curr_Station <- station_list$station[i]
    
    curr_Station_coordinates <- data.frame(latitude = station_list$latitude[i], 
                                        longitude = station_list$longitude[i]
                                        )
    
    within_2000_m <- check_adcp_ditstance(curr_ADCP_coordinates, curr_Station_coordinates, radius=2000)
    
    if(within_2000_m){
      depl_within_2000_m[row, ] <- c(curr_ADCP, curr_Station) 
      
      row = row + 1
    }
    
  }
  
}

depl_within_500_m <- na.omit(depl_within_500_m)
depl_within_1000_m <- na.omit(depl_within_1000_m)
depl_within_2000_m <- na.omit(depl_within_2000_m)

saveRDS(depl_within_500_m, here("data/deployments_within_500_m.rds"))
saveRDS(depl_within_1000_m, here("data/deployments_within_1000_m.rds"))
saveRDS(depl_within_2000_m, here("data/deployments_within_2000_m.rds"))


depl_within_500_m <- readRDS(here("data/deployments_within_500_m.rds"))
depl_within_1000_m <- readRDS(here("data/deployments_within_1000_m.rds"))
depl_within_2000_m <- readRDS(here("data/deployments_within_2000_m.rds"))


depl_within_1000_m <- depl_within_1000_m %>% relocate(String, .before = ADCP)

# Strings within 500m are also present within 1000m and 2000m (these string should only be added to the input sheet once)
