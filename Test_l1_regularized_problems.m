% function Test_l1_regularized_problems
% x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
rng(666666)
%% generate data
n = 1024;
m = 512;

A = randn(m,n);
u = sprandn(n,1,0.1);
b = A * u;
mu = 1e-3;
x0 = rand(n, 1);
errfun = @(x1, x2) norm(x1 - x2)/(1 + norm(x1));

%% Call Different Algorithms
% cvx calling mosek
opts1 = [];
tic; 
[x1, out1] = l1_cvx_mosek(x0, A, b, mu, opts1);
t1 = toc;

% cvx calling gurobi
opts2 = [];
tic; 
[x2, out2] = l1_cvx_gurobi(x0, A, b, mu, opts2);
t2 = toc;

% call mosek directly
opts3 = [];
tic; 
[x3, out3] = l1_mosek(x0, A, b, mu, opts3);
t3 = toc;

% call gurobi directly
opts4 = [];
tic; 
[x4, out4] = l1_gurobi(x0, A, b, mu, opts4);
t4 = toc;

% projection gradient
opts5 = [];
tic; 
[x5, out5] = l1_projection_gradient(x0,A,b,mu, opts5);
t5 = toc;

% sub gradient
opts6 = [];
tic; 
[x6, out6] = l1_sub_gradient(x0,A,b,mu, opts6);
t6 = toc;

% smooth gradient
opts7 = [];
tic; 
[x7, out7] = l1_smooth_gradient(x0,A,b,mu, opts7);
t7 = toc;

% FISTA smooth gradient
opts8 = [];
tic; 
[x8, out8] = l1_smooth_FISTA_gradient(x0,A,b,mu, opts8);
t8 = toc;

% Nesterov smooth gradient
opts9 = [];
tic; 
[x9, out9] = l1_smooth_Nesterov_gradient(x0, A, b, mu, opts9);
t9 = toc;

% proximal gradient
opts10 = [];
tic; 
[x10, out10] = l1_proximal_gradient(x0, A, b, mu, opts10);
t10 = toc;

% FISTA proximal gradient
opts11 = [];
tic; 
[x11, out11] = l1_proximal_FISTA_gradient(x0, A, b, mu, opts11);
t11 = toc;

% Nesterov proximal gradient
opts12 = [];
tic; 
[x12, out12] = l1_proximal_Nesterov_gradient(x0, A, b, mu, opts12);
t12 = toc;

%% print comparison results with cvx-call-mosek
fprintf('              cvx-mosek: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t1, errfun(x1, x1), out1.optval);
fprintf('             cvx-gurobi: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t2, errfun(x1, x2), out2.optval);
fprintf('                  mosek: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t3, errfun(x1, x3), out3.optval);
fprintf('                 gurobi: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t4, errfun(x1, x4), out4.optval);
fprintf('        projection-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t5, errfun(x1, x5), out5.optval);
fprintf('               sub-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t6, errfun(x1, x6), out6.optval);
fprintf('            smooth-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t7, errfun(x1, x7), out7.optval);
fprintf('      smooth-FISTA-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t8, errfun(x1, x8), out8.optval);
fprintf('   smooth-Nesterov-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t9, errfun(x1, x9), out9.optval);
fprintf('          proximal-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t10, errfun(x1, x10), out10.optval);
fprintf('    proximal-FISTA-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t11, errfun(x1, x11), out11.optval);
fprintf(' proximal-Nesterov-grad: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t12, errfun(x1, x12), out12.optval);

%% print comparison results with cvx-call-mosek
fprintf('cvx-mosek & %5.3f & %3.3e & %2.8e\n', t1, errfun(x1, x1), out1.optval);
fprintf('cvx-gurobi & %5.3f & %3.3e & %2.8e\n', t2, errfun(x1, x2), out2.optval);
fprintf('mosek & %5.3f & %3.3e & %2.8e\n', t3, errfun(x1, x3), out3.optval);
fprintf('gurobi & %5.3f & %3.3e & %2.8e\n', t4, errfun(x1, x4), out4.optval);
fprintf('projection-grad & %5.3f & %3.3e & %2.8e\n', t5, errfun(x1, x5), out5.optval);
fprintf('sub-grad & %5.3f & %3.3e & %2.8e\n', t6, errfun(x1, x6), out6.optval);
fprintf('smooth-grad & %5.3f & %3.3e & %2.8e\n', t7, errfun(x1, x7), out7.optval);
fprintf('smooth-FISTA-grad & %5.3f & %3.3e & %2.8e\n', t8, errfun(x1, x8), out8.optval);
fprintf('smooth-Nesterov-grad & %5.3f & %3.3e & %2.8e\n', t9, errfun(x1, x9), out9.optval);
fprintf('proximal-grad & %5.3f & %3.3e & %2.8e\n', t10, errfun(x1, x10), out10.optval);
fprintf('proximal-FISTA-grad & %5.3f & %3.3e & %2.8e\n', t11, errfun(x1, x11), out11.optval);
fprintf('proximal-Nesterov-grad & %5.3f & %3.3e & %2.8e\n', t12, errfun(x1, x12), out12.optval);