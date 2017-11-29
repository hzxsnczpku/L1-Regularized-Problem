% function Test_l1_regularized_problems
% x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1

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

%% print comparison results with cvx-call-mosek
fprintf('   cvx-call-mosek: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t1, errfun(x1, x1), out1.optval);
fprintf('  cvx-call-gurobi: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t2, errfun(x1, x2), out2.optval);
fprintf('       call-mosek: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t3, errfun(x1, x3), out3.optval);
fprintf('      call-gurobi: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t4, errfun(x1, x4), out4.optval);
fprintf('   call-proj-grad: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t5, errfun(x1, x5), out5.optval);
fprintf('    call-sub-grad: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t6, errfun(x1, x6), out6.optval);
fprintf(' call-smooth-grad: cpu: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e\n', t7, errfun(x1, x7), out7.optval);