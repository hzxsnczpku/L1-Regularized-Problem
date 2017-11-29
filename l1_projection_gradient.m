function [x,out]= l1_projection_gradient(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Projection Gradient Method
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  using the the projection gradient method. 
%
%  Author: Ni Chengzhuo, School of Mathematical Science, PKU
%  --------------------------------------------------------------
%
%  =========================== Inputs ===========================
%  
%  x0: m * 1 matrix, the starting point of the algotirhm
%
%  A: m * n matrix, the matrix for l2 norm computation
%
%  b: m * 1 matrix, the approximation target
%
%  mu: scalar, the l1 norm penalty
%
%  opts: list, modify options
%
%  ==============================================================
%
%  =========================== Outputs ==========================
%  
%  x: the optimal point found by the algorithm
%
%  out: a structure recording some information about the process
%
%  ==============================================================

%% Initialization
alphamin = 1e-30;      % range of step size
alphamax = 1e30;
Atb = A' * b;          % precompute A^Tb due to its frequent usage
alpha = 3e-4;          % initial step size
tolA = 1e-12;           % stopping criterion
maximum_step = 200;
x = x0;                % set the initial point
u = x.*(x >= 0);       % get the positive and negative part of x
v = -x.*(x < 0);

%% Gradient Descent Loop
mus = mu * [1e5, 1e4, 1e3, 1e2, 1e1, 1e0];
for count = 1:length(mus)
    % anneal mu gradually
    mu = mus(count);
    
    for step=1:maximum_step
        % compute gradient
        grad0 = A' * (A * x) - Atb;
        gradu = grad0 + mu;
        gradv = -grad0 + mu;
        
        % compute delta u, delta v and delta x
        du = max(u - alpha * gradu, 0) - u;   % projection
        dv = max(v - alpha * gradv, 0) - v;
        dx = du - dv;
        
        % apply gradient descent step
        u = u + du;
        v = v + dv;
        x = u - v;
        
        % BB step size
        Adx = A * dx;
        dGd = Adx' * Adx;
        dd = du' * du + dv' * dv;
        alpha = min(alphamax, max(alphamin, dd / dGd));
        
        % stop when the change in x is small
        if norm(dx, 2) <= tolA
            break;
        end
    end
end

%% Output
out.optval = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);

end
