function [x, out] = l1_mosek(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Regularized Problem with the Direct Call of Mosek
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  calling mosek directly. 
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

    prob.c = mu * [ones(2 * n, 1); zeros(m, 1)];

    prob.qosubi = [2 * n + 1:2 * n + m]';
    prob.qosubj = [2 * n + 1:2 * n + m]';
    prob.qoval  = 0.5 * ones(m, 1);

    prob.a = [A, -A, -eye(m)];

    prob.blc = b;
    prob.buc = b;

    prob.blx = [zeros(2 * n, 1); -inf * ones(m, 1)];
    prob.bux = [];

    %% Call Mosek
    [r, res] = mosekopt('minimize', prob);

    %% Output
    x = res.sol.itr.xx(1:n) - res.sol.itr.xx((n + 1):(2 * n));
    out.optval = 0.5 * norm(A * x - b, 2)^2 + mu * norm(x, 1);
    out.step = NaN;
    out.solution_path = [];
    out.status = 'Solved';

end