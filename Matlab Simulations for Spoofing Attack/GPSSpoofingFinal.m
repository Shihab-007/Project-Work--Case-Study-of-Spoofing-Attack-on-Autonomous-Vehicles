% GPS Spoofing Simulation 

% Parameters and Setup
t = linspace(0, 10, 1000);  % Time vector for 10 seconds
original_position = t;  % Original GPS signal path (straight line)
spoofed_position = original_position;  % Initialize spoofed position

% Spoofing starts at 20% of the timeline with increased noise and deviation
spoofing_start_index = round(length(t) * 0.2);
amplitude_variation = 1.0 + 0.3 * sin(0.1 * t(spoofing_start_index:end));  % Increased amplitude
frequency_variation = 1.0 + 0.1 * cos(0.05 * t(spoofing_start_index:end)); % Increased frequency
random_walk = cumsum(0.05 * randn(1, length(t) - spoofing_start_index + 1)); % Increased random walk
gaussian_noise = 0.2 * randn(1, length(t) - spoofing_start_index + 1); % Increased noise

% Spoofed position calculation with enhanced dynamic components
spoofed_position(spoofing_start_index:end) = original_position(spoofing_start_index:end) + ...
    amplitude_variation .* sin(frequency_variation .* t(spoofing_start_index:end)) + ...
    random_walk + gaussian_noise;

% Set up figure for animated plot
figure('Name', 'GPS Spoofing Simulation with Complex Dynamics', 'NumberTitle', 'off');

% Position plot
subplot(2,1,1); % Top subplot for position
hold on; grid on;
title('Position During GPS Spoofing Attack');
xlabel('Time (seconds)');
ylabel('Position');
xlim([0 10]);
ylim([0 15]); % Adjust y-axis to make the spoofing effect clearer

original_plot = plot(NaN, NaN, 'b-', 'LineWidth', 1.5); % Original position plot
spoofed_plot = plot(NaN, NaN, 'r--', 'LineWidth', 1.5); % Spoofed position plot
legend('Original Position', 'Spoofed Position');

% Annotations for the position plot
text(2, 2, 'Spoofing Starts', 'Color', 'red', 'FontSize', 10);
annotation('textarrow', [0.25, 0.3], [0.75, 0.7], 'String', 'Minor Deviation Begins', 'FontSize', 8, 'Color', 'red');
annotation('textarrow', [0.6, 0.65], [0.4, 0.35], 'String', 'Deviation Increasing', 'FontSize', 8, 'Color', 'red');
annotation('textarrow', [0.85, 0.8], [0.25, 0.3], 'String', 'Peak Spoofing Effect', 'FontSize', 8, 'Color', 'red');

% Velocity and Acceleration plot
subplot(2,1,2); % Bottom subplot for velocity and acceleration
hold on; grid on;
title('Velocity and Acceleration Due to Spoofing');
xlabel('Time (seconds)');
ylabel('Velocity / Acceleration');

% Calculating and plotting velocity and acceleration
velocity_spoofed = gradient(spoofed_position) ./ gradient(t); % Velocity
acceleration_spoofed = gradient(velocity_spoofed) ./ gradient(t); % Acceleration

velocity_plot = plot(NaN, NaN, 'g-', 'LineWidth', 1); % Velocity plot
acceleration_plot = plot(NaN, NaN, 'm-', 'LineWidth', 1); % Acceleration plot
legend('Velocity', 'Acceleration');

% Adding annotations for velocity and acceleration plot
text(2, 10, 'Spoofing Effects on Velocity', 'Color', 'green', 'FontSize', 10);
text(2, -10, 'Acceleration Disturbances', 'Color', 'magenta', 'FontSize', 10);

% GIF Export Parameters
gif_filename = 'GPS_Spoofing_Simulation.gif';
gif_delay = 0.05; % 50 milliseconds between frames

% Animation with Optimized GIF creation
update_interval = 10; % Update every 10 frames for better performance
for i = 1:update_interval:length(t)
    % Update the position plot
    set(original_plot, 'XData', t(1:i), 'YData', original_position(1:i));
    set(spoofed_plot, 'XData', t(1:i), 'YData', spoofed_position(1:i));
    
    % Update velocity and acceleration plot
    set(velocity_plot, 'XData', t(1:i), 'YData', velocity_spoofed(1:i));
    set(acceleration_plot, 'XData', t(1:i), 'YData', acceleration_spoofed(1:i));
    
    % Capture the current frame
    frame = getframe(gcf);
    img = frame2im(frame);
    [img_ind, colormap] = rgb2ind(img, 256);
    
    % Write to GIF
    if i == 1
        imwrite(img_ind, colormap, gif_filename, 'gif', 'Loopcount', Inf, 'DelayTime', gif_delay);
    else
        imwrite(img_ind, colormap, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', gif_delay);
    end
    
    drawnow limitrate; % Optimize rendering speed
end

disp(['Animation saved as ', gif_filename]);
