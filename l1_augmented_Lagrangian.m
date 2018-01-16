function [x, out] = l1_augmented_Lagrangian(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Dual Augmented Lagrangian Method
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  using the Augmented Lagrangian Method for the dual problem. 
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
    if isfield(opts, 'alpha')          
        alpha = opts.alpha;
    else
        alpha = 3e-6;              
    end

    if isfield(opts, 'beta')          
        beta = opts.beta;
    else
        beta = 150.0;              
    end
    
    if isfield(opts, 'gamma')          
        gamma = opts.gamma;
    else
        gamma = 1.618;              
    end

    if isfield(opts, 'thres')          % stopping criterion
        thres = opts.thres;              
    else
        thres = 5e-10; 
    end

    if isfield(opts, 'maximum_step')         % maximun step
        maximum_step = opts.maximum_step;              
    else
        maximum_step = 40;
    end
    
    if isfield(opts, 'grad_step')         % maximun step
        grad_step = opts.grad_step;              
    else
        grad_step = 20;
    end
    
    %% Initialization
    x = x0;
    y = randn(length(b), 1);
    k = 1;
    path = zeros(1, maximum_step);
    
    %% ALM Loop
    for step=1:maximum_step
        k = k + 1;
        for i=1:grad_step
            tmp = A' * y - x / beta;
            prox = (abs(tmp) > mu) .* (tmp - sign(tmp) * mu);
            grad = y + b + beta * A * prox;
            y = y - alpha * grad;
        end
        z = max(min(A' * y - x / beta, mu), -mu);
        x = x - beta * gamma * (A' * y - z);
        
        path(k) = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);

        % stop when the relative improvement is small
        if abs(path(k)-path(k-1)) <= thres * path(k-1)
            break;
        end
        
    end
    
    %% Output
    out.optval = path(k);
    out.step = k;
    out.solution_path = path(1:k);
    out.status = 'Solved';
    
end
