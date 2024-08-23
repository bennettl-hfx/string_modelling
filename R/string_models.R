#2024-05-27
#Liam Bennett
#mooring version: 0.1.8

# Manual models and examples from mooring presentation with RW, DD, NT and Dan Kelley (2024-06-07)
# String with biofouling at end of script

library(mooring)

#Note: The most recent deployment was used is multiple logs were present in the R drive

# String 1 ------------------------------------------------------------------------------------------------------------------

#String 1: Centreville (ADCP: Centreville)

#Most extreme currents: 60.06 cm/s (0.6006 m/s)
#Average Current: 27.5 cm/s (0.275) (Median of current speed diagram on page 25 of Centreville ADCP report)

#String Description: One aquaMeasure DOT anchored with 2 small chains, with a Yellow nav buoy float

m1_1 <- mooring(waterDepth = 9.6,
             anchor(model = "1 rotor"),
             wire(model = "3/8in leaded polypropylene",
                  length = 6.1),
             instrument(model = "aquaMeasure DOT"),
             float(model = "11in centre hole tfloat"))


#segmentize: break up the chain and wire portions of a mooring into smaller chunks,
#so the deformation by a current can be traced more accurately to each segment
ms1_1 <- segmentize(m1_1, by = 1)

#knockdown: define the horizontal current (m/s). can be depth dependent or depth independent
msk1_1 <- knockdown(ms1_1, u = 0.275)

#plot without current applied. 
#use showDepths = TRUE to see if you need to adjust depth configurations in your string
plot(ms1_1, fancy = TRUE, showDepths = TRUE) 

#plot with current applied
plot(msk1_1, fancy = TRUE, showDepths = TRUE) 

#plot tension. is tension to the right or left of the red line?
plot(msk1_1, which = "tension", fancy = TRUE, showDepths = TRUE)

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk1_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk1_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk1_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk1_1, which = "velocity", fancy = TRUE)

#Depth seems inaccurate. The photo seems to show the aquaMeasure much closer to the anchor
#Also, no small chain or nav buoy float options 

#Now with the stronger current

msk1_2 <- knockdown(ms1_1, u=0.6006)

par(mfrow = c(2, 2))
plot(msk1_2, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk1_2, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk1_2, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk1_2, which = "velocity", fancy = TRUE)

# String 2 ------------------------------------------------------------------------------------------------------------------

#String 2: Cornwallis (ADCP: Cornwallis NE) - Deployment 2021-06-16 (Lost)

#String Description: Sub-surface buoy string with 2 instruments, from bottom to top: VR2AR, aquameasure DOT

#Most extreme currents: 79.68 cm/s (0.7968 m/s)
#Average Current: 19.98 cm/s (0.1998) (Median of current speed diagram on page 34 of Cornwallis NE ADCP report)

m2_1 <- mooring(waterDepth = 10.8,
                anchor(model = "1 rotor"),
                wire(model = "3/8in leaded polypropylene",
                     length = 0.85),
                instrument(model = "VR2AR reciever"),
                wire(model = "3/8in leaded polypropylene",
                     length = 8),
                instrument(model = "aquaMeasure DOT"),
                float(model = "11in centre hole tfloat"))

#Median Current

ms2_1 <- segmentize(m2_1, by = 1)
msk2_1 <- knockdown(ms2_1, u = 0.1998)

plot(ms2_1, fancy = TRUE, showDepths = TRUE) #No Current
plot(msk2_1, fancy = TRUE, showDepths = TRUE) #Current applied

plot(msk2_1, which = "tension", fancy = TRUE, showDepths = TRUE) #Tension Plot

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk2_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk2_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk2_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk2_1, which = "velocity", fancy = TRUE)


#Now with the stronger current

msk2_2 <- knockdown(ms2_1, u=0.7968)

par(mfrow = c(2, 2))
plot(msk2_2, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk2_2, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk2_2, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk2_2, which = "velocity", fancy = TRUE)

# String 3 ------------------------------------------------------------------------------------------------------------------

#String 3: Madeline Point 1 (ADCP: Black Island) - Deployment 2023-10-18 (Currently Deployed)

#String description: Sub-surface buoy string with 5 instruments, from bottom to top: VR2AR, 2 HOBO's, aquameasuer DOT, and another HOBO

#Most extreme currents: 80.68 cm/s (0.8068 m/s)
#Average Current: 6.717 cm/s (0.06717) (Median of current speed diagram on page 38 of Black Island ADCP report)

m3_1 <- mooring(waterDepth = 29.1,
             anchor(model = "9 rotor"), 
             wire(model = "3/8in leaded polypropylene",
                  length = 1), 
             instrument(model = "VR2AR reciever"),
             wire(model = "3/8in leaded polypropylene",
                  length = 1),
             float(model = "8in centre hole tfloat"),
             wire(model = "3/8in leaded polypropylene",
                  length = 16.2), 
             instrument(model = "Hobo Temp U22"),
             wire(model = "3/8in leaded polypropylene",
                  length = 4.9), 
             instrument(model = "Hobo Temp U22"),
             wire(model = "3/8in leaded polypropylene",
                  length = 2.7), 
             instrument(model = "aquaMeasure DOT"),
             wire(model = "3/8in leaded polypropylene",
                  length = 0.5), 
             float(model = "14in centre hole tfloat"))

#Median Current

ms3_1 <- segmentize(m3_1, by = 1)
msk3_1 <- knockdown(ms3_1, u = 0.06717)

plot(ms3_1, fancy = TRUE, showDepths = TRUE) #No Current
plot(msk3_1, fancy = TRUE, showDepths = TRUE) #Current applied

plot(msk3_1, which = "tension", fancy = TRUE, showDepths = TRUE) #Tension Plot

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk3_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk3_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk3_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk3_1, which = "velocity", fancy = TRUE)


#Now with the stronger current

msk3_2 <- knockdown(ms3_1, u=0.8068)

par(mfrow = c(2, 2))
plot(msk3_2, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk3_2, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk3_2, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk3_2, which = "velocity", fancy = TRUE)

# String 4 ------------------------------------------------------------------------------------------------------------------

#String 4: Shut-In Island (ADCP: Shut-In Island) - Deployment 2023-11-10 (Currently Deployed)
#Note: ADCP and string are on opposite sides of the island (Unsure if currents would differ greatly)

#String Description: Sub-surface buoy string with 5 instruments, from bottom to top: VR2AR, 2 HOBO's, HOBO DO, and another HOBO

#Most extreme currents: 78.78 cm/s (0.7878 m/s)
#Average Current: 6.558 cm/s (0.06558) (Median of current speed diagram on page 47 of Shut-In Island ADCP report)

m4_1 <- mooring(waterDepth = 24,
                anchor(model = "7 rotor"), 
                wire(model = "3/8in leaded polypropylene",
                     length = 1.0), 
                instrument(model = "VR2AR reciever"),
                wire(model = "3/8in leaded polypropylene",
                     length = 1),
                float(model = "8in centre hole tfloat"),
                wire(model = "3/8in leaded polypropylene",
                     length = 6.1), 
                instrument(model = "Hobo Temp U22"),
                wire(model = "3/8in leaded polypropylene",
                     length = 5), 
                instrument(model = "Hobo Temp U22"),
                wire(model = "3/8in leaded polypropylene",
                     length = 4.5), 
                instrument(model = "Hobo DO U26"),
                wire(model = "3/8in leaded polypropylene",
                     length = 2.5), 
                instrument(model = "Hobo Temp U22"),
                wire(model = "3/8in leaded polypropylene",
                     length = 0.1),
                float(model = "14in centre hole tfloat"))

#Median Current

ms4_1 <- segmentize(m4_1, by = 1)
msk4_1 <- knockdown(ms4_1, u = 0.06558)

plot(ms4_1, fancy = TRUE, showDepths = TRUE) #No Current
plot(msk4_1, fancy = TRUE, showDepths = TRUE) #Current applied

plot(msk4_1, which = "tension", fancy = TRUE, showDepths = TRUE) #Tension Plot

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk4_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk4_1, which = "shape", fancy = TRUE, showDepths = TRUE)
plot(msk4_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk4_1, which = "velocity", fancy = TRUE)


#Now with the stronger current

msk4_2 <- knockdown(ms3_1, u=0.7878)

par(mfrow = c(2, 2))
plot(msk4_2, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk4_2, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk4_2, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk4_2, which = "velocity", fancy = TRUE)

# String 5 ---------------------------------------------------------------------------------------------------------

#String 5: Southside (ADCP: Antigonish Harbour) - Deployment 2023-11-01 (Currently Deployed)

#String Description: Sub-surface buoy string with 3 instruments, from bottom to top: VR2AR, aquameasure DOT, HOBO.

#Most extreme currents: 81.18 cm/s (0.8118 m/s)
#Average Current: 6.758 cm/s (0.06758) (Median of current speed diagram on page 35 of Antigonish Harbour ADCP report)

m5_1 <- mooring(waterDepth = 9.5,
                anchor(model = "4 rotor"), 
                wire(model = "3/8in leaded polypropylene",
                     length = 0.7), 
                instrument(model = "VR2AR reciever"),
                wire(model = "3/8in leaded polypropylene",
                     length = 7.3),
                instrument(model = "aquaMeasure DOT"),
                wire(model = "3/8in leaded polypropylene",
                     length = 0.3), 
                float(model = "11in centre hole tfloat"))

#Median Current

ms5_1 <- segmentize(m5_1, by = 1)
msk5_1 <- knockdown(ms5_1, u = 0.06758)

plot(ms5_1, fancy = TRUE, showDepths = TRUE) #No Current
plot(msk5_1, fancy = TRUE, showDepths = TRUE) #Current applied

plot(msk5_1, which = "tension", fancy = TRUE, showDepths = TRUE) #Tension Plot

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk5_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk5_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk5_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk5_1, which = "velocity", fancy = TRUE)

#Now with the stronger current

msk5_2 <- knockdown(ms5_1, u=0.8118)

par(mfrow = c(2, 2))
plot(msk5_2, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk5_2, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk5_2, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk5_2, which = "velocity", fancy = TRUE)

#------------------------------------------------------------------------------------------------------------------

#Formula to calculate velocity for different current models
0.5 * exp(-depth / 30) #0.5 here represents the current at the top of the water column
0.5 * exp(-depth / 100)
0.5 * exp(-depth / 300)


m <- mooring(
  anchor(model = "9 rotor"),
  wire(model = "3/8in leaded polypropylene", length = 15),
  clamped(instrument(model = "Hobo Temp U22")),
  wire(model = "3/8in leaded polypropylene", length = 5),
  float(model = "14in centre hole tfloat"),
  waterDepth = 25)

ms <- segmentize(m, by = 0.5)
msk <- knockdown(ms, u = function(depth) 2 * exp(-depth / 5))
plot(msk, which = "velocity", fancy = TRUE)
plot(msk, fancy = TRUE, showDepths = TRUE)

m1 <- mooring(
  anchor(model = "9 rotor"),
  wire(model = "3/8in leaded polypropylene", length = 5),
  clamped(instrument(model = "Hobo Temp U22")),
  wire(model = "3/8in leaded polypropylene", length = 5),
  float(model = "14in centre hole tfloat"),
  waterDepth = 25)

ms1 <- segmentize(m1, by = 0.5)
msk1 <- knockdown(ms1, u = function(depth) 0.78* exp(-depth / 30))
plot(msk1, which = "velocity", fancy = TRUE)
plot(msk1, fancy = TRUE, showDepths = TRUE)

msk1 <- knockdown(ms, u = function(depth) depth^2) #You can have any function of depth as the current!
plot(msk1, which = "velocity", fancy = TRUE)

msk2 <- knockdown(ms, u = function(depth) depth^3) #You can have any function of depth as the current!
plot(msk2, which = "velocity", fancy = TRUE)

msk3 <- knockdown(ms, u = function(depth) depth^4) #You can have any function of depth as the current!
plot(msk3, which = "velocity", fancy = TRUE)

msk4 <- knockdown(ms, u = function(depth) depth^5) #You can have any function of depth as the current!
plot(msk4, which = "velocity", fancy = TRUE)

msk5 <- knockdown(ms, u = function(depth) sin(depth))
plot(msk5, which = "velocity", fancy = TRUE)

# Height Examples --------------------------------------------------------


height1 <- mooring(waterDepth = 20,
                anchor(model = "4 rotor"), 
                wire(model = "3/8in leaded polypropylene",
                     length = 5), 
                instrument(model = "VR2AR reciever"),
                wire(model = "3/8in leaded polypropylene",
                     length = 5),
                float(model = "11in centre hole tfloat"))

height1s <- segmentize(height1, by = 1)
plot(height1s, fancy = TRUE, showDepths = TRUE) #Based on the heights given, we would expect the HOBO to be at 15m


#Segmentize --------------------------------------------------------------------


ex_seg <- mooring(waterDepth = 9.6,
                anchor(model = "1 rotor"),
                wire(model = "3/8in leaded polypropylene",
                     length = 6.1),
                instrument(model = "aquaMeasure DOT"),
                float(model = "11in centre hole tfloat"))

seg_1 <- segmentize(ex_seg, by = 5)
seg_2 <- segmentize(ex_seg, by = 0.5)

#knockdown: define the horizontal current (m/s). can be depth dependent or depth independent
segk_1 <- knockdown(seg_1, u = 0.5)
segk_2 <- knockdown(seg_2, u = 0.5)

#plot without current applied. 
#use showDepths = TRUE to see if you need to adjust depth configurations in your string
plot(segk_1, fancy = TRUE, showDepths = TRUE) 
plot(segk_2, fancy = TRUE, showDepths = TRUE) 

#plot with current applied
plot(msk1_1, fancy = TRUE, showDepths = TRUE) 

#plot tension. is tension to the right or left of the red line?
plot(msk1_1, which = "tension", fancy = TRUE, showDepths = TRUE)

#plot all four plots together
par(mfrow = c(1, 2))
plot(msk1_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk1_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk1_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk1_1, which = "velocity", fancy = TRUE)

# Model with biofouling --------------------------------------------------------

i <- instrument("biofouledbuoy", buoyancy = 0.8, height = 0.279, area = 0.0613, CD = 1)

m5_1 <- mooring(waterDepth = 9.5,
                anchor(model = "4 rotor"), 
                wire(model = "3/8in leaded polypropylene",
                     length = 0.7), 
                instrument(model = "VR2AR reciever"),
                wire(model = "3/8in leaded polypropylene",
                     length = 7.3),
                instrument(model = "aquaMeasure DOT"),
                wire(model = "3/8in leaded polypropylene",
                     length = 0.3), 
                i
                #float(model = "11in centre hole tfloat")
                )

#Median Current

ms5_1 <- segmentize(m5_1, by = 1)
msk5_1 <- knockdown(ms5_1, u = 0.15)#0.06758)

plot(ms5_1, fancy = TRUE, showDepths = TRUE) #No Current
plot(msk5_1, fancy = TRUE, showDepths = TRUE) #Current applied

plot(msk5_1, which = "tension", fancy = TRUE, showDepths = TRUE) #Tension Plot

#plot all four plots together
par(mfrow = c(2, 2))
plot(msk5_1, which = "tension", fancy = TRUE, showDepths = TRUE)
plot(msk5_1, which = "shape", fancy = TRUE, showDepths = FALSE)
plot(msk5_1, which = "knockdown", fancy = TRUE, showDepths = TRUE)
plot(msk5_1, which = "velocity", fancy = TRUE)







