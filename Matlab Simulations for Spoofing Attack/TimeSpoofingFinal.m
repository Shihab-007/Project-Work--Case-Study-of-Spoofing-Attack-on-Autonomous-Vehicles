% Time Spoofing Simulation with Enhanced Visualization and Dynamic Annotations

% Parameters and Setup
t = linspace(0, 10, 1000);  % Time vector for 10 seconds
original_time = t;         % Original time signal (linear progression)

% Spoofing Setup
spoofing_start_index = round(length(t) * 0.2);  % Spoofing starts at 20% of the timeline

% Spoofing Dynamics
time_deviation = 0.5 * (t(spoofing_start_index:end) - t(spoofing_start_index)); % Linear deviation
sinusoidal_disturbance = 0.2 * sin(2 * pi * 0.5 * (t(spoofing_start_index:end))); % Sinusoidal disturbance
gaussian_noise = 0.1 * randn(1, length(t) - spoofing_start_index + 1); % Random noise

% Spoofed Time Signal
spoofed_time = original_time; % Initialize spoofed time
spoofed_time(spoofing_start_index:end) = original_time(spoofing_start_index:end) + ...
    time_deviation + sinusoidal_disturbance + gaussian_noise;

% Time Offset
time_offset = spoofed_time - original_time;

% Rate of Change of Time Signal
rate_of_change = gradient(spoofed_time) ./ gradient(t);

% Visualization
figure('Name', 'Time Spoofing Simulation', 'NumberTitle', 'off');

% Subplot 1: Original vs. Spoofed Time Signal
subplot(3, 1, 1);
hold on; grid on;
plot(t, original_time, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Original Time Signal');
plot(t, spoofed_time, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Spoofed Time Signal');
fill([t(spoofing_start_index), t(end), t(end), t(spoofing_start_index)], ...
     [min(original_time), min(original_time), max(original_time), max(original_time)], ...
     [1, 0.9, 0.9], 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Spoofing Region');
title('Original vs. Spoofed Time Signal');
xlabel('Time (seconds)');
ylabel('Time Signal');
ylim([0 15]);
legend('Location', 'NorthWest');

% Annotation for Spoofing Start
annotation('textarrow', [0.25, 0.3], [0.8, 0.7], ...
    'String', sprintf('Spoofing Starts\n(%.2f sec)', t(spoofing_start_index)), ...
    'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');

% Subplot 2: Time Offset
subplot(3, 1, 2);
hold on; grid on;
plot(t, time_offset, 'k-', 'LineWidth', 1.5, 'DisplayName', 'Time Offset');
yline(0.5, 'r--', 'LineWidth', 1.2, 'DisplayName', 'Detection Threshold');
ylim([-1 4]);
threshold_index = find(time_offset > 0.5, 1);
if ~isempty(threshold_index)
    text(t(threshold_index), time_offset(threshold_index), ...
        sprintf('Threshold Crossed\n(%.2f sec)', t(threshold_index)), ...
        'Color', 'blue', 'FontSize', 10, 'FontWeight', 'bold');
end
title('Time Offset Due to Spoofing');
xlabel('Time (seconds)');
ylabel('Offset (seconds)');
legend('Location', 'NorthWest');

% Subplot 3: Rate of Change of Time Signal
subplot(3, 1, 3);
hold on; grid on;
plot(t, rate_of_change, 'g-', 'LineWidth', 1.5, 'DisplayName', 'Rate of Change');
ylim([-20 20]);
[max_rate, max_rate_index] = max(rate_of_change);
if ~isempty(max_rate_index)
    text(t(max_rate_index), rate_of_change(max_rate_index), ...
        sprintf('Max Rate: %.2f\n(%.2f sec)', max_rate, t(max_rate_index)), ...
        'Color', 'green', 'FontSize', 10, 'FontWeight', 'bold');
end
title('Rate of Change of Time Signal');
xlabel('Time (seconds)');
ylabel('Rate of Change (s/s)');
legend('Location', 'NorthWest');

% Dynamic Simulation with Real-Time Animation
for i = 1:10:length(t)
    % Update Subplot 1
    subplot(3, 1, 1);
    cla;
    hold on; grid on;
    plot(t(1:i), original_time(1:i), 'b-', 'LineWidth', 1.5);
    plot(t(1:i), spoofed_time(1:i), 'r--', 'LineWidth', 1.5);
    fill([t(spoofing_start_index), t(i), t(i), t(spoofing_start_index)], ...
         [min(original_time), min(original_time), max(original_time), max(original_time)], ...
         [1, 0.9, 0.9], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
    title('Original vs. Spoofed Time Signal');
    xlabel('Time (seconds)');
    ylabel('Time Signal');
    legend('Original Time Signal', 'Spoofed Time Signal', 'Spoofing Region');

    % Update Subplot 2
    subplot(3, 1, 2);
    cla;
    hold on; grid on;
    plot(t(1:i), time_offset(1:i), 'k-', 'LineWidth', 1.5);
    yline(0.5, 'r--', 'Threshold', 'LineWidth', 1.2);
    title('Time Offset Due to Spoofing');
    xlabel('Time (seconds)');
    ylabel('Offset (seconds)');
    legend('Time Offset', 'Detection Threshold');

    % Update Subplot 3
    subplot(3, 1, 3);
    cla;
    hold on; grid on;
    plot(t(1:i), rate_of_change(1:i), 'g-', 'LineWidth', 1.5);
    title('Rate of Change of Time Signal');
    xlabel('Time (seconds)');
    ylabel('Rate of Change (s/s)');
    legend('Rate of Change');

    drawnow;
end
