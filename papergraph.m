% Define algorithm and function labels
algorithms = {'PSO', 'LDIW', 'TVAC', 'AWDV', 'AWPSO', 'VASF-PSO'};
functions = arrayfun(@(i) sprintf('f_{%d}(x)', i), 1:13, 'UniformOutput', false);

% Updated mean values matrix from your provided table
mean_values = [
    5.93e-25, 1.34e-28, 4.57e-51, 4.78e-62, 3.21e-68, 6.22e-90;
    1.93e-20, 1.65e-29, 1.78e-17, 5.23e-19, 1.22e-27, 1.16e-39;
    3.27e-16, 1.67e-12, 3.12e-17, 7.68e-34, 1.14e-15, 5.61e-34;
    4.72e-27, 2.58e-19, 3.14e-17, 1.06e-23, 1.23e-27, 1.09e-40;
    4.09e-01, 4.88e-01, 4.22e-01, 3.45e-02, 1.32e-03, 1.15e-04;
    1.31e-02, 5.23e-03, 4.09e-03, 5.18e-03, 6.11e-03, 1.32e-03;
    1.34e-30, 1.02e-32, 1.21e-32, 1.15e-33, 1.28e-32, 1.12e-32;
    1.56e-29, 3.12e-18, 2.04e-29, 2.02e-29, 2.19e-29, 3.12e-29;
    1.98e-02, 2.56e-02, 6.72e-03, 3.89e-03, 3.01e-03, 1.23e-03;
    8.76e-05, 3.68e-02, 4.67e-03, 4.25e-03, 5.97e-03, 8.76e-09;
    2.45e-04, 5.29e-03, 7.21e-02, 2.76e-06, 2.98e-07, 2.12e-10;
    1.56e-01, 3.12e-01, 4.67e-01, 2.19e-01, 1.12e-01, 4.56e-02;
    7.34e-01, 6.87e-01, 2.56e-02, 2.12e-02, 2.31e-02, 3.92e-02;
];

% Plot heatmap
figure('Position', [100, 100, 800, 500]);
imagesc(log10(mean_values + 1e-50));  % Add small value to avoid log10(0)
colormap(parula);
colorbar;
title('Mean Fitness Values');
xticks(1:length(algorithms));
xticklabels(algorithms);
yticks(1:length(functions));
yticklabels(functions);
xlabel('Algorithm');
ylabel('Function');
axis tight;
