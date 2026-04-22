%% Origional 

close all
clear
clc
warning('off')

% Parameters
N = 40;              % Number of nodes
area = [50, 50];  % Nodes deployment area in meters
Trange = 5;        % Transmission range of sensor node in meters
lambda = 0.125;     % Signal wavelength in meters

% Generate random positions for nodes
nodes.pos = area(1) .* rand(N, 2);

% Set major and minor axes for elliptical range
nodes.major = Trange;
nodes.minor = lambda * Trange;

%% Plot initial deployment of nodes
figure
plot(nodes.pos(:, 1), nodes.pos(:, 2), 'o', 'color', 'b');
hold on
for ii = 1:N
    [nodes.circle.x(ii, :), nodes.circle.y(ii, :)] = circle(nodes.pos(ii, 1), nodes.pos(ii, 2), Trange);
    fill(nodes.circle.x(ii, :), nodes.circle.y(ii, :), [1, 0, 0]);
    alpha 0.3
    hold on
end
axis([0 area(1) 0 area(2)])  % Fix axis limits to ensure consistent plotting area
xlabel('x(m)')
ylabel('y(m)')
title('Coverage hole in initial position of Nodes')

%% Plot Delaunay triangulation
TRI = delaunay(nodes.pos(:, 1), nodes.pos(:, 2));
figure
plot(nodes.pos(:, 1), nodes.pos(:, 2), 'o', 'color', 'b');
hold on
for ii = 1:N
    [nodes.circle.x(ii, :), nodes.circle.y(ii, :)] = circle(nodes.pos(ii, 1), nodes.pos(ii, 2), Trange);
    fill(nodes.circle.x(ii, :), nodes.circle.y(ii, :), [1, 0, 0]);
    alpha 0.3
    hold on
end
axis([0 area(1) 0 area(2)])  % Fix axis limits to ensure consistent plotting area
xlabel('x(m)')
ylabel('y(m)')
title('Initial Placement of Nodes with circular transmission range')
hold on
triplot(TRI, nodes.pos(:, 1), nodes.pos(:, 2))

%% Hole detection
[holeDetected.circle, Circmcenter.circle, circumradius.circle] = holeDetection(TRI, nodes, [], [], Trange, area, 1, 1);
display(['--> No of detected Holes for Circular = ', num2str(numel(find(holeDetected.circle)))])

%% PSO optimization to cover holes
nvars = 2 * N;
fun = @(x) objf(x, Trange, area);
lb = zeros(nvars, 1);
ub = area(1) * ones(nvars, 1);
options = optimoptions(@particleswarm, 'Display', 'iter', 'MaxIterations', 100, 'PlotFcn', 'pswplotbestf');
[x, fval] = particleswarm(fun, nvars, lb, ub, options);
finalPos = reshape(x, [numel(x) / 2, 2]);

% Plot optimized node positions
figure
plot(finalPos(:, 1), finalPos(:, 2), 'o', 'color', 'b');
hold on
for ii = 1:N
    [finalcircle.x(ii, :), finalcircle.y(ii, :)] = circle(finalPos(ii, 1), finalPos(ii, 2), Trange);
    fill(finalcircle.x(ii, :), finalcircle.y(ii, :), [1, 0, 0]);
    alpha 0.3
    hold on
end
axis([0 area(1) 0 area(2)])  % Fix axis limits to ensure consistent plotting area
xlabel('x(m)')
ylabel('y(m)')
title('Optimized location of Nodes with circular transmission range')
