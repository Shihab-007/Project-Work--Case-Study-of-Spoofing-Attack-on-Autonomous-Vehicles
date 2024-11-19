% Enhanced LiDAR Sensor Spoofing Simulation with Intuitive Visualization

% Parameters and Setup
t = linspace(0, 10, 1000); % Time vector for 10 seconds
x = t * 5; % X-axis positions (meters), assuming a constant speed of 5 m/s
true_obstacle_distance = 20; % True obstacle distance (meters)
spoofed_distance = true_obstacle_distance * ones(size(t)); % Initialize spoofed distances

% Spoofing Setup
spoofing_start_index = round(length(t) * 0.3); % Spoofing starts at 30% of the timeline
spoofing_end_index = round(length(t) * 0.6);   % Spoofing ends at 60% of the timeline

% Spoofing Dynamics
linear_drift = 0.5 * (t(spoofing_start_index:spoofing_end_index) - t(spoofing_start_index)); % Linear drift
sinusoidal_disturbance = 2 * sin(2 * pi * 0.2 * t(spoofing_start_index:spoofing_end_index)); % Sinusoidal disturbance
gaussian_noise = 0.5 * randn(1, spoofing_end_index - spoofing_start_index + 1); % Random noise

% Apply Spoofing
spoofed_distance(spoofing_start_index:spoofing_end_index) = true_obstacle_distance + ...
    linear_drift + sinusoidal_disturbance + gaussian_noise;

% Visualization Setup
figure('Name', 'LiDAR Sensor Spoofing Simulation', 'NumberTitle', 'off');

% Subplot 1: LiDAR Distance Visualization
subplot(3, 1, 1);
hold on; grid on;
plot(t, true_obstacle_distance * ones(size(t)), 'g-', 'LineWidth', 1.5, 'DisplayName', 'True Distance');
plot(t, spoofed_distance, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Spoofed Distance');
fill([t(spoofing_start_index), t(spoofing_end_index), t(spoofing_end_index), t(spoofing_start_index)], ...
    [0, 0, 40, 40], [1, 0.9, 0.9], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Spoofing Duration');
title('LiDAR Sensor Spoofing: Distance Measurement');
xlabel('Time (seconds)');
ylabel('Distance to Obstacle (m)');
legend('Location', 'NorthWest');

% Add annotations for spoofing start and end
text(t(spoofing_start_index), spoofed_distance(spoofing_start_index), 'Spoofing Starts', ...
    'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');
text(t(spoofing_end_index), spoofed_distance(spoofing_end_index), 'Spoofing Ends', ...
    'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');

% Subplot 2: Deviation from True Distance
subplot(3, 1, 2);
hold on; grid on;
distance_deviation = spoofed_distance - true_obstacle_distance; % Deviation due to spoofing
plot(t, distance_deviation, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Distance Deviation');
yline(5, 'r--', 'Threshold', 'LineWidth', 1.2, 'DisplayName', 'Detection Threshold');
title('Deviation from True Distance');
xlabel('Time (seconds)');
ylabel('Deviation (m)');
legend('Location', 'NorthWest');

% Subplot 3: Rate of Change of Distance
subplot(3, 1, 3);
hold on; grid on;
rate_of_change = gradient(spoofed_distance) ./ gradient(t); % Rate of change of spoofed distance
plot(t, rate_of_change, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Rate of Change');
[max_rate, max_rate_index] = max(rate_of_change);
text(t(max_rate_index), rate_of_change(max_rate_index), sprintf('Max Rate: %.2f', max_rate), ...
    'Color', 'blue', 'FontSize', 10, 'FontWeight', 'bold');
title('Rate of Change of Distance');
xlabel('Time (seconds)');
ylabel('Rate of Change (m/s)');
legend('Location', 'NorthWest');

% Dynamic Visualization
for i = 1:10:length(t)
    % Update Subplot 1: LiDAR Distance Visualization
    subplot(3, 1, 1);
    cla;
    hold on; grid on;
    plot(t(1:i), true_obstacle_distance * ones(1, i), 'g-', 'LineWidth', 1.5);
    plot(t(1:i), spoofed_distance(1:i), 'r--', 'LineWidth', 1.5);
    fill([t(spoofing_start_index), t(min(i, spoofing_end_index)), t(min(i, spoofing_end_index)), t(spoofing_start_index)], ...
        [0, 0, 40, 40], [1, 0.9, 0.9], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    title('LiDAR Sensor Spoofing: Distance Measurement');
    xlabel('Time (seconds)');
    ylabel('Distance to Obstacle (m)');
    legend('True Distance', 'Spoofed Distance', 'Spoofing Duration');

    % Update Subplot 2: Deviation from True Distance
    subplot(3, 1, 2);
    cla;
    hold on; grid on;
    plot(t(1:i), distance_deviation(1:i), 'k-', 'LineWidth', 1.5);
    yline(5, 'r--', 'Threshold', 'LineWidth', 1.2);
    title('Deviation from True Distance');
    xlabel('Time (seconds)');
    ylabel('Deviation (m)');
    legend('Distance Deviation', 'Detection Threshold');

    % Update Subplot 3: Rate of Change of Distance
    subplot(3, 1, 3);
    cla;
    hold on; grid on;
    plot(t(1:i), rate_of_change(1:i), 'b-', 'LineWidth', 1.5);
    title('Rate of Change of Distance');
    xlabel('Time (seconds)');
    ylabel('Rate of Change (m/s)');
    legend('Rate of Change');

    drawnow;
end