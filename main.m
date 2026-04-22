close all
clear
clc
addpath(genpath(cd))
warning('off')
%%
N = 32;                       % number of nodes
area = [50, 50];              % nodes deployment area in meter
Trange = 5;                   % transmission range of sensor node in meter
nodes.pos = area(1).*rand(N, 2); % nodes geographical locations
lambda = 0.125;                % signal wavelength in meter
nodes.major = Trange;        % major axis for elliptical range in meter
nodes.minor = lambda * Trange;  % minor axis for elliptical range in meter
redundantNo = round(10 * N / 100);

%% Hammersley Sequence-Based Initialization
% Generate Hammersley sequence for initial particle positions (x, y)
%[H_x, H_y] = hammersleySequence(N);

% Scale Hammersley sequence to the area
%nodes.pos = [area(1) * H_x, area(2) * H_y];  % Particle positions initialized with Hammersley sequence


%%
% plot the nodes deployment
cnt = 1;
for ii = 1:N      
    for jj = 1:N
        if ii ~= jj
            nodes.distance(ii, jj) = pdist([nodes.pos(ii, :); nodes.pos(jj, :)]);
            if nodes.distance(ii, jj) < Trange || nodes.distance(ii, jj) == Trange
                nodes.inrange(ii, jj) = 1;
            else
                nodes.inrange(ii, jj) = 0;
            end
        end
    end
end

figure
F5 = plot(nodes.pos(:, 1), nodes.pos(:, 2), '.', 'color', 'r');
hold on
for ii = 1:N                   % plot the circular transmission range
    [nodes.circle.x(ii,:), nodes.circle.y(ii,:)] = circle(nodes.pos(ii, 1), nodes.pos(ii, 2), Trange);
    F6 = fill(nodes.circle.x(ii,:), nodes.circle.y(ii,:), [0.25, 0.25, 0.25]);
    alpha 0.3
    hold on
end
axis on
xlabel('x(m)')
ylabel('y(m)')
title('Initial Placement of Nodes with circular transmission range')
%%
% plot delaunay triangle
TRI = delaunay(nodes.pos(:, 1), nodes.pos(:, 2));
figure(2)
F5 = plot(nodes.pos(:, 1), nodes.pos(:, 2), '.', 'color', 'r');
hold on
for ii = 1:N                   % plot the circular transmission range
    [nodes.circle.x(ii,:), nodes.circle.y(ii,:)] = circle(nodes.pos(ii, 1), nodes.pos(ii, 2), Trange);
    F6 = fill(nodes.circle.x(ii,:), nodes.circle.y(ii,:), [0.25, 0.25, 0.25]);
    alpha 0.3
    hold on
end
axis on
xlabel('x(m)')
ylabel('y(m)')
title('Coverage hole in initial position of Nodes')
hold on
triplot(TRI, nodes.pos(:, 1), nodes.pos(:, 2))
%%
% Hole detection
[holeDetected.circle, Circmcenter.circle, circumradius.circle] = holeDetection(TRI, nodes, F5, F6, Trange, area, 2, 1);
display(['--> No of detected Holes for Circular = ', num2str(numel(find(holeDetected.circle)))])
%%
% PSO optimize position of rest WSN nodes to cover the hole
nvars = 2 * N;  % Number of variables (positions for N nodes, each with x and y)
fun = @(x) objf(x, Trange, area);
lb = zeros(1, nvars);  % Lower bound for each particle's position (x and y for each node)
ub = area(1) * ones(1, nvars);  % Upper bound for each particle's position (x and y for each node)

% PSO Parameters
maxIter = 50;    % Max iterations
popSize = 30;     % Population size

% LDIW (Linearly Decreasing Inertia Weight)
w_max = 0.9;      % Maximum inertia weight
w_min = 0.4;      % Minimum inertia weight
V_max = 2;        % Maximum velocity (can be adjusted based on problem)

% TVAC (Time-Varying Acceleration Coefficients)
c1_max = 2.0;     % Maximum cognitive coefficient
c1_min = 0.5;     % Minimum cognitive coefficient
c2_max = 2.0;     % Maximum social coefficient
c2_min = 0.5;     % Minimum social coefficient

% Initialize population
X = lb + (ub - lb) .* rand(popSize, nvars);  % Positions of particles
V = zeros(popSize, nvars);  % Velocities of particles
Pbest = X;  % Personal best positions
PbestScore = inf(popSize, 1);  % Personal best scores
Gbest = X(1, :);  % Global best position
GbestScore = inf;  % Global best score

% Main PSO loop
for iter = 1:maxIter
    for i = 1:popSize
        % proposed adaptive
        %velocity_norm = norm(V(i, :)); % Norm of velocity
        %w = w_min + (w_max - w_min) * exp(-0.1 * velocity_norm); % Exponential decay for smoother transition
        %lDIW
        w = w_max - ((w_max - w_min) / maxIter) * iter;  % Linearly decreasing inertia weight
        
        % Update cognitive and social coefficients with slight random perturbation
        c1 = c1_max - ((c1_max - c1_min) / maxIter) * iter + 0.1 * randn;
        c2 = c2_max - ((c2_max - c2_min) / maxIter) * iter + 0.1 * randn;
        
        % Evaluate fitness
        score = fun(X(i, :));
        
        % Update personal best
        if score < PbestScore(i)
            PbestScore(i) = score;
            Pbest(i, :) = X(i, :);
        end
        
        % Update global best
        if score < GbestScore
            GbestScore = score;
            Gbest = X(i, :);
        end
        
        % Update velocity
        V(i, :) = w * V(i, :) + c1 * rand(1, nvars) .* (Pbest(i, :) - X(i, :)) + c2 * rand(1, nvars) .* (Gbest - X(i, :));
        
        % Update position
        X(i, :) = X(i, :) + V(i, :);
        
        % Apply boundary conditions
        X(i, :) = max(X(i, :), lb);
        X(i, :) = min(X(i, :), ub);
    end
    
    % Display iteration info
    disp(['Iteration: ', num2str(iter), ', Best Fitness: ', num2str(GbestScore)]);
end

finalPos = reshape(Gbest, [numel(Gbest) / 2, 2]);

% plot the final tuned Node' pos
figure
plot(finalPos(:, 1), finalPos(:, 2), 'o', 'color', 'r');
hold on
for ii = 1:N                 % plot the circular transmission range
    [finalcircle.x(ii,:), finalcircle.y(ii,:)] = circle(finalPos(ii, 1), finalPos(ii, 2), Trange);
    fill(finalcircle.x(ii,:), finalcircle.y(ii,:), [0.25, 0.25, 0.25]);
    alpha 0.3
    hold on
end
axis on
xlabel('x(m)')
ylabel('y(m)')
title('Optimized location of Nodes with circular transmission range')
