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
%    x0: m * 1 matrix, the starting point of the algotirhm
%
%     A: m * n matrix, the matrix to compute the l2 norm
%
%     b: m * 1 matrix, the target of approximation
%
%    mu:       scalar, penalty of the l1 norm
%
%  opts:    structure, modify options
%
%  ==============================================================
%
%  =========================== Outputs ==========================
%  
%     x: m * 1 matrix, the optimal point found by the algorithm
%
%   out:    structure, record of the process information
%
%  ==============================================================

    %% Hyperparameters
    if isfield(opts, 'alphamin')
        alphamin = opts.alphamin;      % minimum of step size
    else
        alphamin = 1e-30;
    end

    if isfield(opts, 'alphamax')
        alphamax = opts.alphamax;      % maximum of step size
    else
        alphamax = 1e30;
    end

    if isfield(opts, 'alpha')          % initial step size
        alpha = opts.alpha;
    else
        alpha = 3e-4;              
    end

    if isfield(opts, 'thres')          % stopping criterion
        thres = opts.thres;              
    else
        thres = 5e-10; 
    end

    if isfield(opts, 'maximum_step')         % maximun step
        maximum_step = opts.maximum_step;              
    else
        maximum_step = 200;
    end

    %% Initialization
    Atb = A' * b;          % precompute A^T * b
    x = x0;                % set the initial point
    u = x.*(x >= 0);       % get the positive and negative part of x
    v = -x.*(x < 0);
    k = 1;
    mus = mu * [1e5, 1e4, 1e3, 1e2, 1e1, 1e0];
    path = zeros(1, maximum_step * length(mus));
    path(k) = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);

    %% Gradient Descent Loop
    for count = 1:length(mus)
        % anneal mu gradually
        mu = mus(count);

        for step=1:maximum_step
            % compute gradient
            k = k + 1;
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

            path(k) = 0.5 * norm(A * x - b, 2)^2 + mus(length(mus)) * norm(x, 1);

            % stop when the relative improvement is small
            if abs(path(k)-path(k-1)) <= thres * path(k-1)
                break;
            end
        end
    end

    %% Output
    out.optval = path(k);
    out.step = k;
    out.solution_path = path(1:k);
    out.status = 'Solved';

end
