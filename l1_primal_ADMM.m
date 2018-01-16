function [x, out] = l1_primal_ADMM(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Primal ADMM Method
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  using ADMM for the primal problem. 
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
    if isfield(opts, 'beta')          
        beta = opts.beta;
    else
        beta = 0.3;              
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
        maximum_step = 400;
    end
    
    %% Initialization
    x = x0;
    y = randn(length(x0), 1);
    z = randn(length(x0), 1);
    ATb = A' * b;
    [L, U] = lu(beta * eye(length(x0)) + (A' * A));
    k = 1;
    path = zeros(1, maximum_step);
    path(k) = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);
    
    %% ADMM Loop
    for step = 1:maximum_step
        k = k + 1;
        
        x = U \ (L \ (ATb + beta * y - z));
        tmp = x + z / beta;
        tar = 2 * mu / beta;
        y = (abs(tmp) > tar) .* (tmp - sign(tmp) * tar);
        z = z + gamma * beta * (x - y);
        
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
