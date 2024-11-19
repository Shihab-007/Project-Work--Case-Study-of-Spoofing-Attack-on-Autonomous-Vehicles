
# MATLAB Simulations for Spoofing Attacks

This repository contains MATLAB scripts simulating spoofing attacks on autonomous vehicle systems. Each simulation demonstrates a specific type of spoofing attack (GPS, time, and sensor) with visualizations of their effects.

---

## 1. **GPS Spoofing Simulation**
### Purpose:
Simulates the impact of GPS spoofing on the vehicle's positional accuracy. The simulation introduces dynamic noise, sinusoidal disturbances, and random walk patterns to the GPS signal to mimic real-world spoofing attacks.

### Setup:
- **Timeline:** 10 seconds.
- **Original Path:** Linear progression (straight-line trajectory).
- **Spoofing Dynamics:** Noise, frequency variation, and amplitude fluctuation start at 20% of the timeline.

### Output:
- **Visualizations:**
  - Position deviation caused by spoofing.
  - Changes in velocity and acceleration due to spoofing effects.
- **File Export:** A GIF (`GPS_Spoofing_Simulation.gif`) showcasing the animation.

---

## 2. **Time Spoofing Simulation**
### Purpose:
Demonstrates how spoofing attacks can disrupt time synchronization in autonomous systems. The spoofed time signal introduces linear deviations, sinusoidal disturbances, and random noise.

### Setup:
- **Timeline:** 10 seconds.
- **Original Signal:** Linearly progressing time vector.
- **Spoofing Dynamics:** Spoofing starts at 20% of the timeline, adding increasing time offsets.

### Output:
- **Visualizations:**
  - Original vs. spoofed time signal.
  - Time offset caused by spoofing.
  - Rate of change of the time signal, highlighting deviations.

---

## 3. **Sensor (LiDAR) Spoofing Simulation**
### Purpose:
Explores the effect of sensor spoofing (LiDAR) on obstacle detection. The simulation adds linear drifts, sinusoidal disturbances, and random noise to manipulate distance measurements.

### Setup:
- **Timeline:** 10 seconds.
- **True Distance:** A constant 20 meters.
- **Spoofing Dynamics:** Spoofing starts at 30% and ends at 60% of the timeline.

### Output:
- **Visualizations:**
  - True vs. spoofed distances.
  - Deviation from the true distance over time.
  - Rate of change in spoofed distances.

---

## Instructions
1. Open the corresponding MATLAB script (`GPS_Spoofing.m`, `Time_Spoofing.m`, or `Sensor_Spoofing.m`) in MATLAB.
2. Run the script to visualize the impact of spoofing attacks.
3. Export the results as GIFs or screenshots for analysis.

---

## Screenshots
### GPS Spoofing Effect:
![GPS Spoofing Effect](./Simulation Screenshot/gps_simulation.png)

### Time Spoofing Effect:
![Time Spoofing Effect](./Simulation Screenshot/time_simulation.png)

### Sensor (LiDAR) Spoofing Effect:
![Sensor Spoofing Effect](./Simulation Screenshot/sensor_simulation.png)

---

## Notes:
- **Simulation Parameters:** Parameters like noise intensity, amplitude variations, and spoofing duration are customizable for experimentation.
- **Code Outputs:** Real-time plots and animations for detailed analysis.
- **Next Steps:** Integrate these simulations into a comparative analysis to evaluate vulnerabilities and propose mitigation strategies.
