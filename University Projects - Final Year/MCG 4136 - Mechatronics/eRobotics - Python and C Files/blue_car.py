# Copyright 1996-2020 Cyberbotics Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""vehicle_driver controller."""
from vehicle import Driver
import random
import time
import struct
sensorsNames = [
    "front",
    "front right 0",
    "front right 1",
    "front right 2",
    "front left 0",
    "front left 1",
    "front left 2",
    "rear",
    "rear left",
    "rear right",
    "right",
    "left"]
sensors = {}

# Set Max Speed
maxSpeed = 40
brakingDistance = 14
lanePositions = [1.68, -1.78]
currentLane = 0


# Speed filter
def get_filtered_speed(speed):
    #Filter the speed command to avoid abrupt speed changes.
    get_filtered_speed.previousSpeeds.append(speed)
    if len(get_filtered_speed.previousSpeeds) > 100:  # keep only 80 values
        get_filtered_speed.previousSpeeds.pop(0)
    return sum(get_filtered_speed.previousSpeeds) / float(len(get_filtered_speed.previousSpeeds))

# Speed filter variable
get_filtered_speed.previousSpeeds = []


# Sets the position of the car to stay between the lines
def apply_PID(position, targetPosition):
    #Apply the PID controller and return the angle command.
    P = 0.05
    I = 0.000015
    D = 25
    
    diff = position - targetPosition
    
    if apply_PID.previousDiff is None:
        apply_PID.previousDiff = diff
    # anti-windup mechanism
    if diff > 0 and apply_PID.previousDiff < 0:
        apply_PID.integral = 0
    if diff < 0 and apply_PID.previousDiff > 0:
        apply_PID.integral = 0
    apply_PID.integral += diff
     
    # compute angle
    angle = P * diff + I * apply_PID.integral + D * (diff - apply_PID.previousDiff)
    apply_PID.previousDiff = diff
    return angle


apply_PID.integral = 0
apply_PID.previousDiff = None
       

def obstacle_avoidence():
    # Obstacle avoidence
    frontDistance = sensors["front"].getValue()
    frontRange = sensors["front"].getMaxValue()
    speed = maxSpeed * frontDistance / frontRange
    if sensors["front right 0"].getValue() < 6.0 or sensors["front left 0"].getValue() < 6.0:
        # emergency braking
        speed = min(0.5 * maxSpeed, speed)
        
    speed = get_filtered_speed(speed)
    driver.setCruisingSpeed(speed)

    # brake if needed
    speedDiff = driver.getCurrentSpeed() - speed
    if speedDiff > 0:
        driver.setBrakeIntensity(min(speedDiff / speed, 1))
    else:
        driver.setBrakeIntensity(0)
        

# Sensors and Driver constructors
driver = Driver()
for name in sensorsNames:
    sensors[name] = driver.getDevice("distance sensor " + name)
    sensors[name].enable(10)

gps = driver.getDevice("gps")
gps.enable(1)
camera = driver.getDevice("camera")
camera.enable(10)
camera.recognitionEnable(50)

emitter = driver.getDevice("emit3")
receiver = driver.getDevice("receiver3")

receiver.enable(10)

          

while driver.step() != -1:   
    
    currentPosition = gps.getValues()
    #print(currentPosition)
   
"""        
    # adjust steering to stay in the middle of the current lane
    position = gps.getValues()[0]
    angle = max(min(apply_PID(position, lanePositions[currentLane]), 0.5), -0.5)
    driver.setSteeringAngle(angle)
    obstacle_avoidence()
"""                        
 
    if currentPosition[0] > 0 and currentPosition[0] < 7 and currentPosition[1] < 4.25:
        print("start of intersection")
        driver.setCruisingSpeed(20)
        driver.setSteeringAngle(-0.7)
    
    # when the car has turned and past the intersection apply pid and drive
    elif currentPosition[1] > 4.25:
        position = gps.getValues()[0]
        currentLane = 1
        angle = max(min(apply_PID(position, lanePositions[currentLane]), 0.5), -0.5)
        print(angle)
        driver.setSteeringAngle(-angle)
        obstacle_avoidence() 
        
    # if the car is not in the intersection and is just going horizontally
    else:
        drive(currentPosition[1],currentLane)
        obstacle_avoidence()












































    