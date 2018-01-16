function [x,out]= l1_Adam(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Adam
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  using Adam. 
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
        alpha = 3e-2;              
    end
    
    if isfield(opts, 'thres')                % stopping criterion
        thres = opts.thres;              
    else
        thres = 1e-7;
    end
    
    if isfield(opts, 'maximum_step')         % maximun step
        maximum_step = opts.maximum_step;              
    else
        maximum_step = 500;
    end
    
    if isfield(opts, 'rho1')         % maximun step
        rho1 = opts.rho1;              
    else
        rho1 = 0.9;
    end
    
    if isfield(opts, 'rho2')         % maximun step
        rho2 = opts.rho1;              
    else
        rho2 = 0.999;
    end
    
    %% Initialization
    Atb = A' * b;                           % precompute A^T * b
    x = x0;                                 % set the initial point
    k = 1;
    delta = 1e-8;
    mus = mu * [1e5, 1e4, 1e3, 1e2, 1e1, 1e0];
    path = zeros(1, maximum_step * length(mus));
    path(k) = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);
    r = zeros(length(x0), 1);
    s = zeros(length(x0), 1);

    %% Gradient Descent Loop
    for count = 1:length(mus)
        mu = mus(count);                    % anneal mu gradually
        for step=1:maximum_step
            k = k + 1;
            
            % apply gradient descent step
            grad = A' * (A * x) - Atb;
            s = rho1 * s + (1 - rho1) * grad;
            r = rho2 * r + (1 - rho2) * grad .* grad;
            s_hat = s / (1 - rho1^(k - 1));
            r_hat = r / (1 - rho2^(k - 1));
            dx = -alpha * s_hat ./ (delta + sqrt(r_hat));
            
            tmp = x + dx;
            beta = alpha * mu ./ (delta + sqrt(r_hat));
            x = (abs(tmp) > beta) .* (tmp - sign(tmp) .* beta);
            x = x + dx;
            
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
