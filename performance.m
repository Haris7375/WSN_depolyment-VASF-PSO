% MATLAB Code to Compare Coverage Rates vs Sensing Radius

% Define algorithms and their coverage rates for each case
algorithms = {'PSO', 'ABC', 'ICS', 'IGWO-MS', 'HPO', 'Proposed'};
coverage_rates = [
    0.8856, 0.8545, 0.8444, 0.8345 0.8278;  % PSO
    0.8945, 0.8434, 0.8332, 0.8234  0.8195;  % ABC
    0.9105, 0.8656, 0.8523, 0.8267, 0.8345;  % ICS
    0.9387, 0.89013, 0.8811, 0.8699, 0.8434;  % IGWO-MS
    0.9556, 0.9234, 0.9067, 0.8921, 0.8845;  % HPO
    0.9945, 0.9710, 0.967, 0.9410, 0.9190   % Proposed
];

% Define sensing radii for each case
sensing_radii = [5, 8, 10, 12, 15]; % in meters

% Create a figure for the coverage rates vs sensing radius
figure('Position', [100, 100, 800, 500]);
hold on;

% Plot coverage rates for each algorithm
for i = 1:length(algorithms)
    plot(sensing_radii, coverage_rates(i, :), '-o', 'DisplayName', algorithms{i}, 'LineWidth', 2);
end

hold off;

% Title and labels
title('Coverage Rates of Algorithms vs Sensing Radius', 'FontWeight', 'bold');
xlabel('Sensing Radius (m)', 'FontWeight', 'bold');
ylabel('Coverage Rate', 'FontWeight', 'bold');
xticks(sensing_radii);
xticklabels({'5 m', '8 m','10 m','12 m', '15 m'});
legend('Location', 'best');
grid on;

% Adjust figure layout
sgtitle('Impact of Sensing Radius on Coverage Rate', 'FontWeight', 'bold');
