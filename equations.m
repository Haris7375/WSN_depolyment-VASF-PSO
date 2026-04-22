% LDIW (Linearly Decreasing Inertia Weight)
w_max = 0.9;      % Maximum inertia weight
w_min = 0.4;      % Minimum inertia weight

% TVAC (Time-Varying Acceleration Coefficients)
c1_max = 2.0;     % Maximum cognitive coefficient
c1_min = 0.5;     % Minimum cognitive coefficient
c2_max = 2.0;     % Maximum social coefficient
c2_min = 0.5;     % Minimum social coefficient


 % Update weights for this iteration
    w = w_max - ((w_max - w_min) / maxIter) * iter;  % Linearly decreasing inertia weight
    c1 = c1_max - ((c1_max - c1_min) / maxIter) * iter;  % Linearly decreasing cognitive coefficient
    c2 = c2_max - ((c2_max - c2_min) / maxIter) * iter;  % Linearly decreasing social coefficient
    
%Proposed
    w = w_min + (w_max - w_min) * exp(-0.1 * velocity_norm); % Exponential decay for smoother transition