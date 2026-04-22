% Parameters
omega_min = 0.4;          % Minimum inertia weight
omega_max = 0.9;          % Maximum inertia weight
V_max = 10;               % Maximum velocity
num_iterations = 100;     % Total number of iterations
V_prev = linspace(0, V_max, num_iterations);  % Linearly increasing velocity (from 0 to V_max)

% Initialize iteration indices
iterations = 1:num_iterations;

% Compute R_i(t) for each iteration (velocity-dependent)
R_i = omega_min + (omega_max - omega_min) .* (1 - abs(V_prev) / V_max);

% Compute inertia weight omega_i(t) using the double-exponential formula
omega_i = exp(-exp(-R_i));

% Plotting the results
figure;
plot(iterations, omega_i, '-o', 'LineWidth', 1.5, 'DisplayName', 'Double Exponential Inertia Weight');
grid on;

% Labels and Title
xlabel('Iteration');
ylabel('Inertia Weight (\omega)');
title('Inertia Weight Update with Double Exponential Decay');
legend('show', 'Location', 'northeast');

% Enhance plot appearance
set(gca, 'FontSize', 12);
