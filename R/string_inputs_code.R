# Code to automatically generate string models. With examples at end of script.
# LB, final update: 2024-08-12

#Import libraries and data------------------------------------------------------

# Install mooring package (if not done already)

#library(devtools)
#devtools::install_github("dankelley/mooring", dependencies = TRUE)

library(here)
library(mooring)
library(dplyr)
library(readr)
library(tidyverse)

string_inputs <- read.csv(here("data/string_modelling_input.csv"), header=T, na.strings="")


# get_string_model function ----------------------------------------------------

get_string_model <- function(station, 
                             depl_date, 
                             wire_mat = "3/8in leaded polypropylene", 
                             segmentize_length = 1,
                             with_current = TRUE){
  
  # Filter down to indicated string
  curr_string <- string_inputs %>%
    filter(station_name==station, deployment_date==depl_date)
  
  #Applying default values if float and/or anchor are missing and print warning messages altering to the same
  
  if(is.na(curr_string$float)){
    curr_string$float <- "14in centre hole tfloat"
    warning("Default Float Applied")
  }
  
  if(is.na(curr_string$anchor)){
    curr_string$anchor <- "7 rotor"
    warning("Default Anchor Applied")
  }
  
  # Stop the function if Sounding is missing
  if(is.na(curr_string$sounding)) stop("Missing Water Depth")
  
  # Stop the function if there are too many instruments
  if(!is.na(curr_string$instrument_10)) stop("Too many instruments. Update code to allow for more instruments. Remember: update this warning as well")
  
  # Assign the First Instrument and Section of Wire
  i_1 <- instrument(model=curr_string$instrument_1) #Every string must have at least one instrument
  w_1 <- wire(model = wire_mat, length = curr_string$sounding - curr_string$instrument_depth_1
              - anchor(model = curr_string$anchor)@height)
  
  
  # Running through curr_string to check for instruments and assigning them accordingly
  if(!is.na(curr_string$instrument_2)){
    i_2 <- instrument(model=curr_string$instrument_2)
    w_2 <- wire(model = wire_mat, length = curr_string$instrument_depth_1 - curr_string$instrument_depth_2)
  } else {
    i_2 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_2 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_3)){
    i_3 <- instrument(model=curr_string$instrument_3)
    w_3 <- wire(model = wire_mat, length = curr_string$instrument_depth_2 - curr_string$instrument_depth_3)
  } else {
    i_3 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_3 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_4)){
    i_4 <- instrument(model=curr_string$instrument_4)
    w_4 <- wire(model = wire_mat, length = curr_string$instrument_depth_3 - curr_string$instrument_depth_4)
  } else {
    i_4 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_4 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_5)){
    i_5 <- instrument(model=curr_string$instrument_5)
    w_5 <- wire(model = wire_mat, length = curr_string$instrument_depth_4 - curr_string$instrument_depth_5)
  } else {
    i_5 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_5 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_6)){
    i_6 <- instrument(model=curr_string$instrument_6)
    w_6 <- wire(model = wire_mat, length = curr_string$instrument_depth_5 - curr_string$instrument_depth_6)
  } else {
    i_6 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_6 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_7)){
    i_7 <- instrument(model=curr_string$instrument_7)
    w_7 <- wire(model = wire_mat, length = curr_string$instrument_depth_6 - curr_string$instrument_depth_7)
  } else {
    i_7 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_7 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_8)){
    i_8 <- instrument(model=curr_string$instrument_8)
    w_8 <- wire(model = wire_mat, length = curr_string$instrument_depth_7 - curr_string$instrument_depth_8)
  } else {
    i_8 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_8 <- wire(model = wire_mat, length = 0)
  }
  
  if(!is.na(curr_string$instrument_9)){
    i_9 <- instrument(model=curr_string$instrument_9)
    w_9 <- wire(model = wire_mat, length = curr_string$instrument_depth_8 - curr_string$instrument_depth_9)
  } else {
    i_9 <- instrument(model="not_an_instrument", buoyancy=0, height=0, area=0, CD=0)
    w_9 <- wire(model = wire_mat, length = 0)
  }
  
  # Initialize the mooring, m
  m <- mooring( waterDepth = curr_string$sounding,
                anchor(model = curr_string$anchor),
                w_1,
                clamped(i_1),
                w_2,
                clamped(i_2),
                w_3,
                clamped(i_3),
                w_4,
                clamped(i_4),
                w_5,
                clamped(i_5),
                w_6,
                clamped(i_6),
                w_7,
                clamped(i_7),
                w_8,
                clamped(i_8),
                w_9,
                clamped(i_9),
                float(model=curr_string$float)
  ) %>%
    segmentize(by=segmentize_length)
  
  if(with_current){
    # Plot with current (knockdown)
    
    mk <- knockdown(m, u = curr_string$mean_current_m_s)
    
    par(mfrow = c(2, 2))
    plot(mk, which = "tension", fancy = TRUE, showDepths = FALSE, showLabels = TRUE) 
    plot(mk, which = "shape", fancy = TRUE, showDepths = FALSE, showLabels = TRUE)
    plot(mk, which = "knockdown", fancy = TRUE, showDepths = FALSE, showLabels = TRUE)
    plot(mk, which = "velocity", fancy = TRUE)
    
    mtext(paste(station, depl_date, sep = ", "), side = 3, line = -1, outer = TRUE)
    
  } else {
    # Plot without current (no knockdown)
    
    par(mfrow = c(2, 2))
    plot(m, which = "tension", fancy = TRUE, showDepths = TRUE, showLabels = FALSE)
    plot(m, which = "shape", fancy = TRUE, showDepths = FALSE, showLabels = FALSE)
    plot(m, which = "knockdown", fancy = TRUE, showDepths = TRUE, showLabels = FALSE)
    plot(m, which = "velocity", fancy = TRUE)
    
    mtext(paste(station, depl_date, sep = ", "), side = 3, line = -1, outer = TRUE)
  }
  
}

# Testing with current
get_string_model(station = "Centreville", depl_date = "2023-10-13")

get_string_model(station = "Center Bay", depl_date = "2023-10-18")

get_string_model("Southside", "2023-11-01")

get_string_model("Long Island 1", "2020-07-16")

get_string_model("Little Narrows S", "2016-09-20") # Missing anchor and string

get_string_model("Captains Pond", "2023-11-01") # Missing water depth


# Testing without current
get_string_model(station = "Centreville", depl_date = "2023-10-13", with_current = FALSE)

