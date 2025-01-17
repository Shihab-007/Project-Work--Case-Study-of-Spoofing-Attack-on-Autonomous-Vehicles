% GPS Spoofing Simulation with Real-Time Animation

% Parameters and Setup
t = linspace(0, 10, 1000);  % Time vector for 10 seconds
original_position = t;  % Original GPS signal path (straight line)
spoofed_position = original_position;  % Initialize spoofed position

% Spoofing starts at 20% of the timeline with increased noise and deviation
spoofing_start_index = round(length(t) * 0.2);
amplitude_variation = 1.0 + 0.3 * sin(0.1 * t(spoofing_start_index:end));  % Increased amplitude
frequency_variation = 1.0 + 0.1 * cos(0.05 * t(spoofing_start_index:end)); % Increased frequency
random_walk = cumsum(0.05 * randn(1, length(t) - spoofing_start_index + 1)); % Random walk
gaussian_noise = 0.2 * randn(1, length(t) - spoofing_start_index + 1); % Noise

% Spoofed position calculation
spoofed_position(spoofing_start_index:end) = original_position(spoofing_start_index:end) + ...
    amplitude_variation .* sin(frequency_variation .* t(spoofing_start_index:end)) + ...
    random_walk + gaussian_noise;

% Smooth the spoofed position
spoofed_position_smoothed = smoothdata(spoofed_position, 'gaussian', 15);

% Precompute velocity and acceleration
velocity_spoofed = gradient(spoofed_position_smoothed) ./ gradient(t); % Velocity
acceleration_spoofed = gradient(velocity_spoofed) ./ gradient(t); % Acceleration

% Set up figure for animated plot
figure('Name', 'GPS Spoofing Simulation', 'NumberTitle', 'off');

% Position plot
subplot(3,1,1); % Top subplot for position
hold on; grid on;
title('Position During GPS Spoofing Attack');
xlabel('Time (seconds)');
ylabel('Position');
xlim([0 10]);
ylim([0 15]);

original_plot = plot(NaN, NaN, 'b-', 'LineWidth', 1.5); % Original position plot
spoofed_plot = plot(NaN, NaN, 'r--', 'LineWidth', 1.5); % Smoothed spoofed position
legend('Original Position', 'Spoofed Position');

% Velocity plot
subplot(3,1,2); % Middle subplot for velocity
hold on; grid on;
title('Velocity Due to GPS Spoofing');
xlabel('Time (seconds)');
ylabel('Velocity');
velocity_plot = plot(NaN, NaN, 'g-', 'LineWidth', 1.5);

% Acceleration plot
subplot(3,1,3); % Bottom subplot for acceleration
hold on; grid on;
title('Acceleration Due to GPS Spoofing');
xlabel('Time (seconds)');
ylabel('Acceleration');
acceleration_plot = plot(NaN, NaN, 'm-', 'LineWidth', 1.5);

% Real-time animation loop
update_interval = 10; % Update every 10 frames for better performance
for i = 1:update_interval:length(t)
    % Update position plot
    set(original_plot, 'XData', t(1:i), 'YData', original_position(1:i));
    set(spoofed_plot, 'XData', t(1:i), 'YData', spoofed_position_smoothed(1:i));
    
    % Update velocity and acceleration plot
    set(velocity_plot, 'XData', t(1:i), 'YData', velocity_spoofed(1:i));
    set(acceleration_plot, 'XData', t(1:i), 'YData', acceleration_spoofed(1:i));
    
    drawnow; % Force MATLAB to update the plots in real-time
end

disp('Simulation completed: Real-time animation shown.');
