function [x, out] = l1_cvx_mosek(x0, A, b, mu, opts)
%  --------------------------------------------------------------
%  L1 Regularized Problem with CVX-Mosek
%
%  This function solves the convex problem
%
%     x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
%
%  calling cvx-mosek. 
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

%% Problem Setting
[m, n] = size(A);

cvx_solver mosek
cvx_begin quiet
  variable x(n)
  minimize(0.5 * (A * x - b)' * (A * x - b) + mu * norm(x, 1))
cvx_end

%% Output
out.optval = cvx_optval;
out.step = NaN;
out.solution_path = [];
out.status = 'Solved';

end
