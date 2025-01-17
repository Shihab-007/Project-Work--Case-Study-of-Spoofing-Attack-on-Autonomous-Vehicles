# GPS Spoofing Visualization with JavaScript

This project demonstrates a **GPS spoofing simulation** using JavaScript and the Leaflet.js library to visualize how spoofing attacks can mislead a vehicle from its intended route. By introducing controlled disruptions like amplitude variation, frequency shifts, random walk, and Gaussian noise, this simulation showcases the impact of spoofing on navigation systems.

## Key Features of the Simulation

1. **Original Route Visualization**: 
   - The vehicle starts from a dorm location and aims to reach the university following a straight and legitimate route (blue line).
   - This route is fetched dynamically using the OpenRouteService API.

2. **Spoofing Effects**: 
   - Spoofing starts at 20% of the journey (near the beginning) and grows gradually.
   - Four dynamics are introduced:
     - **Amplitude Variation**: Introduces oscillations around the original route.
     - **Frequency Variation**: Adds periodic variations to disrupt the trajectory.
     - **Random Walk**: Gradually drifts the vehicle off its path.
     - **Gaussian Noise**: Adds random noise to mimic real-world inaccuracies.

3. **Wrong Destination Simulation**:
   - After 50% of the journey, the vehicle is misled to an unintended destination (red line). 
   - This route is fetched separately using the OpenRouteService API.

4. **Annotations and Animation**:
   - Each spoofing effect is introduced incrementally with annotations displayed at key points, making it easier to track the changes.
   - The car marker animates step-by-step to visualize the spoofing progression and the eventual wrong route.

## How It Works

### Core Components:
- **Leaflet.js**: Used to render the map and routes.
- **OpenRouteService API**: Fetches routing data for both original and spoofed paths.
- **Spoofing Dynamics**: 
  - Implemented using mathematical models for amplitude, frequency, random walk, and noise.
  - Functions like `Math.sin()` and `Math.cos()` generate smooth oscillations, while random walk and Gaussian noise create unpredictability.

### Steps in the Simulation:
1. **Fetch the Original Route**: 
   - The API retrieves coordinates from the dorm to the university.
   - A blue polyline represents this legitimate route.

2. **Introduce Spoofing**:
   - At 20% of the journey, spoofing begins.
   - Amplitude variation starts first, followed by frequency shifts, random walk, and Gaussian noise.
   - Each effect is applied step-by-step, with visual and textual annotations.

3. **Redirect to a Wrong Route**:
   - At 50% of the journey, the spoofed vehicle is redirected to a different destination.
   - A red polyline highlights this completely wrong path.

4. **Animation**:
   - The car marker moves dynamically along the route, showcasing the transition from normal navigation to spoofed navigation.

### Key JavaScript Functions:
- **`randn()`**: Generates Gaussian random values for noise simulation.
- **`computeSpoofOffset()`**: Calculates the positional offset caused by each spoofing dynamic.
- **`animateCar()`**: Handles the car's movement and triggers visual updates at each step.

## Why This Visualization Matters
- Demonstrates how spoofing attacks can mislead autonomous vehicles, posing safety risks.
- Highlights the importance of implementing robust countermeasures in navigation systems.
- Provides an interactive way to understand the progression and severity of spoofing attacks.

## How to Run the Simulation
1. Clone the repository.
2. Open the `index.html` file in a browser.
3. Ensure you have an active OpenRouteService API key and replace the placeholder in the code (`const orsApiKey`) with your key.
4. View the map to see the car navigating through the original and spoofed routes.


This simulation is a step toward understanding and addressing vulnerabilities in autonomous vehicle systems. Feedback and contributions are welcome!
