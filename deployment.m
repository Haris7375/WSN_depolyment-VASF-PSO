% Define the size of the deployment area (W x H)
W = 10; % Width of the region
H = 10; % Height of the region

% Define the number of nodes to deploy
N = 400; % Number of sensor nodes

% Hammersley Sequence initialization
hammersley_x = (0:N-1) / N; % Fractional part for x-coordinates
hammersley_y = zeros(N, 1); % Pre-allocate y-coordinates

% Compute the Van der Corput sequence for base 2
for i = 1:N
    num = i - 1; % Index starts at 0 for Van der Corput
    q = 0;
    base = 2;
    k = 1;
    while num > 0
        q = q + mod(num, base) / base^k;
        num = floor(num / base);
        k = k + 1;
    end
    hammersley_y(i) = q; % Store result in y
end

% Scale the Hammersley points to the region [0, W] and [0, H]
hammersley_x = hammersley_x * W;  % Scale x-coordinates
hammersley_y = hammersley_y * H;  % Scale y-coordinates

% Plot for Hammersley Sequence Deployment
figure;
scatter(hammersley_x, hammersley_y, 12, 'k', 'filled'); % Black small dots
title('Hammersley Sequence initialization', 'FontSize', 16);
xlabel('X Coordinate', 'FontSize', 14);
ylabel('Y Coordinate', 'FontSize', 14);

% Set axis limits to avoid gaps
xlim([0 W]);
ylim([0 H]);

% Adjust axis properties to eliminate gaps
set(gca, 'Position', [0.1 0.1 0.8 0.8]); % Remove extra padding
set(gca, 'FontSize', 14);
set(gca, 'GridAlpha', 0.3);
axis tight; % Ensure no gaps around axes
axis equal; % Maintain equal aspect ratio
box on; % Keep a clean bounding box around the plot
grid on;

% Save the Hammersley Sequence Deployment as an image
saveas(gcf, 'Hammersley_Deployment_Fixed.png');
