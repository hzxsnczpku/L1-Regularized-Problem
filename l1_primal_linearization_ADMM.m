function [x, out] = l1_primal_linearization_ADMM(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Primal Linearization ADMM Method
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  using linearization ADMM for the primal problem. 
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
    if isfield(opts, 'alpha')                % initial step size
        alpha = opts.alpha;
    else
        alpha = 7e-4;              
    end
    
    if isfield(opts, 'beta')          
        beta = opts.beta;
    else
        beta = 0.3;              
    end
    
    if isfield(opts, 'gamma')          
        gamma = opts.gamma;
    else
        gamma = 2;              
    end

    if isfield(opts, 'thres')          % stopping criterion
        thres = opts.thres;              
    else
        thres = 5e-10; 
    end

    if isfield(opts, 'maximum_step')         % maximun step
        maximum_step = opts.maximum_step;              
    else
        maximum_step = 120;
    end
    
    %% Initialization
    x = x0;
    y = randn(length(b), 1);
    z = randn(length(b), 1);
    k = 1;
    mus = mu * [1e5, 1e4, 1e3, 1e2, 1e1, 1e0];
    path = zeros(1, maximum_step * length(mus));
    path(k) = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);
    
    %% ADMM Loop
    for count = 1:length(mus)
        % anneal mu gradually
        mu = mus(count);
        for step = 1:maximum_step
            k = k + 1;

            grad = beta * A' * (A * x - b - y + z / beta);
            tmp = x - alpha * grad;
            t = alpha * mu;
            x = sign(tmp) .* max(abs(tmp) - t, 0);

            Ax = A * x;
            y = (beta * Ax - beta * b + z) / (1 + beta);
            z = z + gamma * beta * (Ax - b - y);

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
