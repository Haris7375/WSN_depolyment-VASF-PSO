% MATLAB Code for Combined Comparison of Simulation Results with Focus on Coverage Rate

% Data from the table
cases = {'Case 1', 'Case 2', 'Case 3'};
sensor_nodes = [32, 60, 36]; % Number of sensor nodes for each case
sensing_radius = [5, 8, 15]; % Sensing radius for each case (in meters)
coverage_area = [50*50, 100*100, 150*150]; % Coverage area (width*height)

% Coverage rates for algorithms
algorithms = {'PSO', 'ABC', 'ICS', 'IGWO-MS', 'HPO', 'Proposed'};
coverage_rates = [
    0.8856, 0.8545, 0.8278;  % PSO
    0.8945, 0.8434, 0.8195;  % ABC
    0.9105, 0.8656, 0.8345;  % ICS
    0.9387, 0.8813, 0.8534;  % IGWO-MS
    0.9456, 0.9034, 0.8967;  % HPO
    0.9945, 0.9810, 0.9690   % Proposed
];

% Computation times for algorithms
computation_times = [
    58.09, 72.81, 81.56;  % PSO
    57.78, 73.18, 85.23;  % ABC
    56.11, 71.45, 82.67;  % ICS
    53.45, 66.25, 72.78;  % IGWO-MS
    49.89, 61.10, 68.19;  % HPO
    38.98, 43.56, 48.88   % Proposed
];

% Create a single figure for all comparisons
figure('Position', [100, 100, 900, 1000]);

% Subplot for sensor nodes (smaller)
subplot(5, 1, 1);
bar(sensor_nodes, 'FaceColor', [0.2 0.6 0.8]);
set(gca, 'XTickLabel', cases);
title('Sensor Nodes', 'FontWeight', 'bold');
ylabel('Number of Sensor Nodes');
ylim([0 70]);
grid on;

% Subplot for sensing radius (smaller)
subplot(5, 1, 2);
bar(sensing_radius, 'FaceColor', [0.8 0.4 0.4]);
set(gca, 'XTickLabel', cases);
title('Sensing Radius', 'FontWeight', 'bold');
ylabel('Radius (m)');
ylim([0 20]);
grid on;

% Subplot for coverage area (smaller)
subplot(5, 1, 3);
bar(coverage_area, 'FaceColor', [0.4 0.8 0.4]);
set(gca, 'XTickLabel', cases);
title('Coverage Area', 'FontWeight', 'bold');
ylabel('Area (m^2)');
ylim([0 25000]);
grid on;

% Subplot for coverage rates (larger focus)
subplot(5, 1, 4);
bar(coverage_rates);
set(gca, 'XTickLabel', algorithms);
title('Coverage Rates by Algorithm', 'FontWeight', 'bold');
xlabel('Algorithms');
ylabel('Coverage Rate');
ylim([0 1]);
legend(cases, 'Location', 'best', 'Orientation', 'horizontal');
grid on;

% Subplot for computation times (larger focus)
subplot(5, 1, 5);
bar(computation_times);
set(gca, 'XTickLabel', algorithms);
title('Computation Time by Algorithm', 'FontWeight', 'bold');
xlabel('Algorithms');
ylabel('Computation Time (s)');
grid on;
ylim([0 100]);
legend(cases, 'Location', 'best');

% Adjust layout and aesthetics
sgtitle('Combined Comparison of Simulation Results', 'FontSize', 14, 'FontWeight', 'bold');
