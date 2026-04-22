% Define algorithms and cases
algorithms = {'PSO', 'ABC', 'ICS', 'IGWO-MS', 'HPO', 'Proposed'};
cases = {'Case 1', 'Case 2', 'Case 3'};

% Coverage Rate data (rows=algorithms, cols=cases)
coverage_rate = [
    0.8856, 0.8545, 0.8278;
    0.8945, 0.8434, 0.8195;
    0.9105, 0.8656, 0.8345;
    0.9387, 0.8813, 0.8534;
    0.9456, 0.9034, 0.8967;
    0.9945, 0.9810, 0.9690;
];

% Computation Time data (seconds)
computation_time = [
    58.09, 72.81, 81.56;
    57.78, 73.18, 85.23;
    56.11, 71.45, 82.67;
    53.45, 66.25, 72.78;
    49.89, 61.10, 68.19;
    38.98, 43.56, 48.88;
];

% Create figure with two subplots
figure('Position', [100, 100, 900, 500]);

%% Subplot 1: Coverage Rate
subplot(1,2,1);
imagesc(coverage_rate);
colormap(parula);
colorbar;
caxis([0 1]); % Coverage rate is between 0 and 1
title('Coverage Rate');
xticks(1:length(cases));
xticklabels(cases);
yticks(1:length(algorithms));
yticklabels(algorithms);
xlabel('Case');
ylabel('Algorithm');
axis tight;

% Removed numeric annotations

%% Subplot 2: Computation Time
subplot(1,2,2);
imagesc(computation_time);
colormap(parula);
colorbar;
title('Computation Time (seconds)');
xticks(1:length(cases));
xticklabels(cases);
yticks(1:length(algorithms));
yticklabels(algorithms);
xlabel('Case');
ylabel('Algorithm');
axis tight;

% Removed numeric annotations
