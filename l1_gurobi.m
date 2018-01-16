function [x, out] = l1_gurobi(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Regularized Problem with the Direct Call of Gurobi
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  calling gurobi directly. 
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

    %% Initialization
    [m, n] = size(A);

    clear model;
    model.Q = sparse(2 * n + 1:2 * n + m, 2 * n + 1:2 * n + m, 0.5 * ones(m, 1));
    model.A = sparse([A, -A, -eye(m)]);
    model.obj = mu * [ones(2 * n, 1); zeros(m, 1)];

    model.rhs = b;
    model.sense = '=';
    model.lb = [zeros(2 * n, 1); -inf * ones(m, 1)];
    model.ub = inf * ones(2 * n + m, 1);

    %% Call Gurobi
    result = gurobi(model);

    %% Output
    x = result.x(1:n) - result.x(n + 1:2 * n);
    out.optval = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);
    out.step = NaN;
    out.solution_path = [];
    out.status = 'Solved';

end