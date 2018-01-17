% function Test_l1_regularized_problems
% x = argmin 0.5 * ||Ax - b||_2^2 + mu * ||x||_1
rng(23333)
%% generate data
n = 1024;
m = 512;

A = randn(m,n);
u = sprandn(n,1,0.1);
b = A * u;
mu = 1e-3;
x0 = rand(n, 1);
errfun = @(x1, x2) norm(x1 - x2)/(1 + norm(x1));
%printfun = @(name, t, x, x_m, out) fprintf(...
%    '%25s: time: %5.3f, err-to-cvx-mosek: %3.3e, optval: %2.8e, iter: %d\n', ...
%    name, t, errfun(x_m, x), out.optval, out.step);

%printfun = @(name, t, x, x_m, out) fprintf(...
%    '& %25s & %5.3f & %3.3e & %2.8e & %d\\\\\n', ...
%    name, t, errfun(x_m, x), out.optval, out.step);

printfun = @(name, t, x, x_m, out) fprintf(...
    '| %25s | %5.3f | %3.3e | %2.8e | %d |\n', ...
    name, t, errfun(x_m, x), out.optval, out.step);

%% cvx calling mosek
opts1 = [];
tic; 
[x1, out1] = l1_cvx_mosek(x0, A, b, mu, opts1);
t1 = toc;

%% cvx calling gurobi
opts2 = [];
tic; 
[x2, out2] = l1_cvx_gurobi(x0, A, b, mu, opts2);
t2 = toc;

%% call mosek directly
opts3 = [];
tic; 
[x3, out3] = l1_mosek(x0, A, b, mu, opts3);
t3 = toc;

%% call gurobi directly
opts4 = [];
tic; 
[x4, out4] = l1_gurobi(x0, A, b, mu, opts4);
t4 = toc;

%% projection gradient
opts5 = [];
tic; 
[x5, out5] = l1_projection_gradient(x0,A,b,mu, opts5);
t5 = toc;

%% sub gradient
opts6 = [];
tic; 
[x6, out6] = l1_sub_gradient(x0,A,b,mu, opts6);
t6 = toc;

%% smooth gradient
opts7 = [];
tic; 
[x7, out7] = l1_smooth_gradient(x0,A,b,mu, opts7);
t7 = toc;

%% FISTA smooth gradient
opts8 = [];
tic; 
[x8, out8] = l1_smooth_FISTA_gradient(x0,A,b,mu, opts8);
t8 = toc;

%% Nesterov smooth gradient
opts9 = [];
tic; 
[x9, out9] = l1_smooth_Nesterov_gradient(x0, A, b, mu, opts9);
t9 = toc;

%% proximal gradient
opts10 = [];
tic; 
[x10, out10] = l1_proximal_gradient(x0, A, b, mu, opts10);
t10 = toc;

%% FISTA proximal gradient
opts11 = [];
tic; 
[x11, out11] = l1_proximal_FISTA_gradient(x0, A, b, mu, opts11);
t11 = toc;

%% Nesterov proximal gradient
opts12 = [];
tic; 
[x12, out12] = l1_proximal_Nesterov_gradient(x0, A, b, mu, opts12);
t12 = toc;

%% augmented Lagrangian method for the dual problem
opts13 = [];
tic; 
%[x13, out13] = l1_alm_dual_grad(x0, A, b, mu, opts13);
[x13, out13] = l1_augmented_Lagrangian(x0, A, b, mu, opts13);
t13 = toc;

%% ADMM for the dual problem
opts14 = [];
tic; 
[x14, out14] = l1_dual_ADMM(x0, A, b, mu, opts14);
t14 = toc;

%% ADMM for the primal problem
opts15 = [];
tic; 
[x15, out15] = l1_primal_ADMM(x0, A, b, mu, opts15);
t15 = toc;

%% ADMM for the linearized primal problem
opts16 = [];
tic; 
[x16, out16] = l1_primal_linearization_ADMM(x0, A, b, mu, opts16);
t16 = toc;

%% momentum gradient
opts17 = [];
tic; 
[x17, out17] = l1_momentum_gradient(x0, A, b, mu, opts17);
t17 = toc;

%% Nesterov momentum gradient
opts18 = [];
tic; 
[x18, out18] = l1_Nesterov_momentum_gradient(x0, A, b, mu, opts18);
t18 = toc;

%% AdaGrad
opts19 = [];
tic;
[x19, out19] = l1_AdaGrad(x0, A, b, mu, opts19);
t19 = toc;

%% RMSProp
opts20 = [];
tic;
[x20, out20] = l1_RMSProp(x0, A, b, mu, opts20);
t20 = toc;

%% Adam
opts21 = [];
tic;
[x21, out21] = l1_Adam(x0, A, b, mu, opts21);
t21 = toc;

%% print comparison results with cvx-call-mosek
printfun('cvx-mosek', t1, x1, x1, out1)
printfun('cvx-gurobi', t2, x2, x1, out2)
printfun('mosek', t3, x3, x1, out3)
printfun('gurobi', t4, x4, x1, out4)
printfun('projection-grad', t5, x5, x1, out5)
printfun('sub-grad', t6, x6, x1, out6)
printfun('smooth-grad', t7, x7, x1, out7)
printfun('smooth-FISTA-grad', t8, x8, x1, out8)
printfun('smooth-Nesterov-grad', t9, x9, x1, out9)
printfun('proximal-grad', t10, x10, x1, out10)
printfun('proximal-FISTA-grad', t11, x11, x1, out11)
printfun('proximal-Nesterov-grad', t12, x12, x1, out12)
printfun('augmented-Lagrangian', t13, x13, x1, out13)
printfun('dual-ADMM', t14, x14, x1, out14)
printfun('primal-ADMM', t15, x15, x1, out15)
printfun('primal-linearization-ADMM', t16, x16, x1, out16)
printfun('momentum-grad', t17, x17, x1, out17)
printfun('Nesterov-momentum-grad', t18, x18, x1, out18)
printfun('AdaGrad', t19, x19, x1, out19)
printfun('RMSProp', t20, x20, x1, out20)
printfun('Adam', t21, x21, x1, out21)

%% plot solution paths
figure(1)
semilogy(out5.solution_path, 'LineWidth', 1.0);hold on;
semilogy(out6.solution_path, 'LineWidth', 1.0);
semilogy(out7.solution_path, 'LineWidth', 1.0);
semilogy(out8.solution_path, 'LineWidth', 1.0);
semilogy(out9.solution_path, 'LineWidth', 1.0);
semilogy(out10.solution_path, 'LineWidth', 1.0);
semilogy(out11.solution_path, 'LineWidth', 1.0);
semilogy(out12.solution_path, 'r', 'LineWidth', 1.0);
semilogy(out13.solution_path, 'b','LineWidth', 1.0);
semilogy(out14.solution_path, 'Color',[0.7 0.7 0.8], 'LineWidth', 1.0);
semilogy(out15.solution_path, 'Color',[0.4 0.6 0.7], 'LineWidth', 1.0);
semilogy(out16.solution_path, 'Color',[0.2 0.3 0.4], 'LineWidth', 1.0);
semilogy(out17.solution_path, 'Color',[0.7 0.2 0.7], 'LineWidth', 1.0);
semilogy(out18.solution_path, 'Color',[0.2 0.7 0.4], 'LineWidth', 1.0);
semilogy(out19.solution_path, 'Color',[0.2 0.1 0.1], 'LineWidth', 1.0);
semilogy(out20.solution_path, 'Color',[0.9 0.7 0.9], 'LineWidth', 1.0);
semilogy(out21.solution_path, 'Color',[0.9 0.1 0.9], 'LineWidth', 1.0);
title('Solution Paths of Different Algorithms')
xlabel('Step')
ylabel('Function Value')
legend('projection-grad', 'sub-grad', 'smooth-grad',...
    'smooth-FISTA-grad', 'smooth-Nesterov-grad', 'proximal-grad',...
    'proximal-FISTA-grad', 'proximal-Nesterov-grad',...
    'augmented-Lagrangian', 'dual-ADMM', 'primal-ADMM', ...
    'primal-linearization-ADMM', 'momentum-grad',...
    'Nesterov-momentum-grad', 'AdaGrad', 'RMSProp', 'Adam')
xlim([1, 1500])

figure(2)
semilogy(out5.solution_path, 'LineWidth', 1.0);hold on;
semilogy(out6.solution_path, 'LineWidth', 1.0);
semilogy(out7.solution_path, 'LineWidth', 1.0);
semilogy(out8.solution_path, 'LineWidth', 1.0);
semilogy(out9.solution_path, 'LineWidth', 1.0);
semilogy(out10.solution_path, 'LineWidth', 1.0);
semilogy(out11.solution_path, 'LineWidth', 1.0);
semilogy(out12.solution_path, 'r', 'LineWidth', 1.0);
semilogy(out13.solution_path, 'b','LineWidth', 1.0);
semilogy(out14.solution_path, 'Color',[0.7 0.7 0.8], 'LineWidth', 1.0);
semilogy(out15.solution_path, 'Color',[0.4 0.6 0.7], 'LineWidth', 1.0);
semilogy(out16.solution_path, 'Color',[0.2 0.3 0.4], 'LineWidth', 1.0);
semilogy(out17.solution_path, 'Color',[0.7 0.2 0.7], 'LineWidth', 1.0);
semilogy(out18.solution_path, 'Color',[0.2 0.7 0.4], 'LineWidth', 1.0);
semilogy(out19.solution_path, 'Color',[0.2 0.1 0.1], 'LineWidth', 1.0);
semilogy(out20.solution_path, 'Color',[0.9 0.7 0.9], 'LineWidth', 1.0);
semilogy(out21.solution_path, 'Color',[0.9 0.1 0.9], 'LineWidth', 1.0);
title('Solution Paths of Different Algorithms')
xlabel('Step')
ylabel('Function Value')
legend({'projection-grad', 'sub-grad', 'smooth-grad',...
    'smooth-FISTA-grad', 'smooth-Nesterov-grad', 'proximal-grad',...
    'proximal-FISTA-grad', 'proximal-Nesterov-grad',...
    'augmented-Lagrangian', 'dual-ADMM', 'primal-ADMM', ...
    'primal-linearization-ADMM', 'momentum-grad',...
    'Nesterov-momentum-grad', 'AdaGrad', 'RMSProp', 'Adam'}, 'FontSize', 6)

xlim([1, 300])
ylim([0.05, 3000])

%% plot results
figure(3)
subplot(11,2,1); plot(u); title('True Variable'); xlim([1, 1024]);
subplot(11,2,2); plot(x1); title('CVX-mosek'); xlim([1, 1024]);
subplot(11,2,3); plot(x2); title('CVX-gurobi'); xlim([1, 1024]);
subplot(11,2,4); plot(x3); title('Mosek'); xlim([1, 1024]);
subplot(11,2,5); plot(x4); title('Gurobi'); xlim([1, 1024]);
subplot(11,2,6); plot(x5); title('Projection Gradient'); xlim([1, 1024]);
subplot(11,2,7); plot(x6); title('Sub Gradient'); xlim([1, 1024]);
subplot(11,2,8); plot(x7); title('Smooth Gradient'); xlim([1, 1024]);
subplot(11,2,9); plot(x8); title('Smooth FISTA Gradient'); xlim([1, 1024]);
subplot(11,2,10); plot(x9); title('Smooth Nesterov Gradient'); xlim([1, 1024]);
subplot(11,2,11); plot(x10); title('Proximal Gradient'); xlim([1, 1024]);
subplot(11,2,12); plot(x11); title('Proximal FISTA Gradient'); xlim([1, 1024]);
subplot(11,2,13); plot(x12); title('Proximal Nesterov Gradient'); xlim([1, 1024]);
subplot(11,2,14); plot(x13); title('Augmented Lagrangian'); xlim([1, 1024]);
subplot(11,2,15); plot(x14); title('Dual ADMM'); xlim([1, 1024]);
subplot(11,2,16); plot(x15); title('Primal ADMM'); xlim([1, 1024]);
subplot(11,2,17); plot(x16); title('Primal Linearization ADMM'); xlim([1, 1024]);
subplot(11,2,18); plot(x17); title('Momentum Gradient'); xlim([1, 1024]);
subplot(11,2,19); plot(x18); title('Nesterov Momentum Gradient'); xlim([1, 1024]);
subplot(11,2,20); plot(x19); title('AdaGrad'); xlim([1, 1024]);
subplot(11,2,21); plot(x20); title('RMSProp'); xlim([1, 1024]);
subplot(11,2,22); plot(x21); title('Adam'); xlim([1, 1024]);
