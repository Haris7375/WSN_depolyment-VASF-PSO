clc;
clear;
close all;

% Define parameters for each function
functions = {@(x, y) x + y, ...                                % f1: Sum of elements
             @(x, y) max(abs(x), abs(y)), ...                 % f2: Schwefel 2.21
             @(x, y) abs(x) + abs(y) + abs(x).*abs(y), ...    % f3: Schwefel 2.22
             @(x, y) x.^4 + y.^4 + rand(size(x)), ...         % f4: Quartic Noise
             @(x, y) 10*2 + (x.^2 - 10*cos(2*pi*x)) + (y.^2 - 10*cos(2*pi*y)), ... % f5: Rastrigin
             @(x, y) -20*exp(-0.2*sqrt(0.5*(x.^2 + y.^2))) - exp(0.5*(cos(2*pi*x) + cos(2*pi*y))) + 20 + exp(1)}; % f6: Ackley

% Define domains and resolutions
domains = {[-100, 100, 5], ...
           [-100, 100, 5], ...
           [-10, 10, 1], ...
           [-1.28, 1.28, 0.1], ...
           [-5.12, 5.12, 0.5], ...
           [-32, 32, 1]};

% Titles for the plots
titles = {"Sum Function (f_1)", "Schwefel 2.21 (f_2)", "Schwefel 2.22 (f_3)", ...
          "Quartic Noise (f_4)", "Rastrigin (f_5)", "Ackley (f_6)"};

% Create separate figures for each function
for i = 1:length(functions)
    figure;
    domain = domains{i};
    x = domain(1):domain(3):domain(2);
    y = domain(1):domain(3):domain(2);
    [X, Y] = meshgrid(x, y);
    Z = functions{i}(X, Y);

    % Plot each function with enhanced visual appearance
    surf(X, Y, Z, 'EdgeColor', 'none', 'FaceLighting', 'gouraud');
    title(titles{i}, 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('y', 'FontSize', 12, 'FontWeight', 'bold');
    zlabel('f(x, y)', 'FontSize', 12, 'FontWeight', 'bold');
    colormap([linspace(0.5, 1, 256)', linspace(0, 0.2, 256)', linspace(0.5, 0, 256)']); % Purple-Red Colormap
    colorbar;
    view(135, 45); % Adjust viewing angle for better visualization
    light('Position', [1, 1, 1], 'Style', 'infinite'); % Add lighting
    lighting phong;
    material shiny;
    axis tight;
    grid on;
    set(gca, 'FontSize', 10, 'LineWidth', 1.2);
end
