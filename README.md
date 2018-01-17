# L1-Regularized-Problem
Here is my solution to the following convex optimization problem,

<div align = 'center'>
<img src = "https://raw.githubusercontent.com/hzxsnczpku/L1-Regularized-Problem/master/images/pb.png?token=Ac3JKCcnZscE3xaEkzjc5uYIv60_tjCuks5aaD3twA%3D%3D" width='280px'>
</div>

## Algorithms
Below are the implemented algorithms so far,
* Call of CVX
  * CVX Mosek
  * CVX Gurobi
* Direct call of Mosek
* Direct call of Gurobi
* Projection Gradient Method
* Sub Gradient Method
* Gradient Method for the Smoothed Primal Problem
* Fast Gradient Method for the Smoothed Primal Problem
  * FISTA
  * Nesterov's Second Method
* Fast Gradient Method for the Primal Problem
  * FISTA
  * Nesterov's Second Method
* Augmented Lagrangian Method
* ADMM for the Primal problem
* ADMM for the Dual problem
* ADMM for the Linearized Primal Problem
* Momentum Gradient Method
* Nesterov's Momentum Gradient Method
* AdaGrad
* RMSProp
* Adam

## Experimental Results
Seed = 0

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
|                 cvx-mosek | 1.131 | 0.000e+00 | 7.28448691e-02 | NaN |
|                cvx-gurobi | 1.665 | 3.033e-06 | 7.28442784e-02 | NaN |
|                     mosek | 1.250 | 4.001e-06 | 7.28446155e-02 | NaN |
|                    gurobi | 1.341 | 3.213e-06 | 7.28442671e-02 | NaN |
|           projection-grad | 0.137 | 3.216e-06 | 7.28442661e-02 | 452 |
|                  sub-grad | 0.502 | 1.795e-06 | 7.28444407e-02 | 2485 |
|               smooth-grad | 0.435 | 7.980e-07 | 7.28444145e-02 | 2101 |
|         smooth-FISTA-grad | 0.065 | 2.066e-06 | 7.28444001e-02 | 301 |
|      smooth-Nesterov-grad | 0.041 | 2.502e-06 | 7.28445550e-02 | 181 |
|             proximal-grad | 0.364 | 2.788e-06 | 7.28442683e-02 | 1801 |
|       proximal-FISTA-grad | 0.064 | 3.534e-06 | 7.28442674e-02 | 301 |
|    proximal-Nesterov-grad | 0.040 | 1.198e-06 | 7.28443722e-02 | 181 |
|      augmented-Lagrangian | 0.788 | 3.645e-06 | 7.28444247e-02 | 41 |
|                 dual-ADMM | 0.154 | 3.503e-06 | 7.28450928e-02 | 135 |
|               primal-ADMM | 0.546 | 8.372e-06 | 7.28468060e-02 | 336 |
| primal-linearization-ADMM | 1.463 | 1.564e-06 | 7.28443091e-02 | 721 |
|             momentum-grad | 0.116 | 3.411e-06 | 7.28447857e-02 | 554 |
|    Nesterov-momentum-grad | 0.071 | 2.224e-06 | 7.28444500e-02 | 279 |
|                   AdaGrad | 0.321 | 7.176e-06 | 7.28445404e-02 | 1355 |
|                   RMSProp | 0.404 | 1.435e-05 | 7.28467014e-02 | 1884 |
|                      Adam | 0.464 | 1.741e-06 | 7.28445424e-02 | 2135 |

Seed = 23333

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
|                 cvx-mosek | 1.151 | 0.000e+00 | 7.99348749e-02 | NaN |
|                cvx-gurobi | 1.635 | 6.630e-06 | 7.99341909e-02 | NaN |
|                     mosek | 1.250 | 4.159e-06 | 7.99344433e-02 | NaN |
|                    gurobi | 1.393 | 6.624e-06 | 7.99341863e-02 | NaN |
|           projection-grad | 0.142 | 6.655e-06 | 7.99341858e-02 | 366 |
|                  sub-grad | 0.593 | 5.002e-06 | 7.99343389e-02 | 2419 |
|               smooth-grad | 0.426 | 5.159e-06 | 7.99343294e-02 | 2026 |
|         smooth-FISTA-grad | 0.062 | 5.349e-06 | 7.99343334e-02 | 301 |
|      smooth-Nesterov-grad | 0.038 | 4.153e-06 | 7.99344929e-02 | 181 |
|             proximal-grad | 0.363 | 6.655e-06 | 7.99341858e-02 | 1768 |
|       proximal-FISTA-grad | 0.063 | 6.450e-06 | 7.99341874e-02 | 301 |
|    proximal-Nesterov-grad | 0.038 | 5.064e-06 | 7.99343058e-02 | 181 |
|      augmented-Lagrangian | 0.771 | 6.872e-06 | 7.99343751e-02 | 41 |
|                 dual-ADMM | 0.146 | 6.533e-06 | 7.99350305e-02 | 81 |
|               primal-ADMM | 0.647 | 6.551e-06 | 7.99359284e-02 | 401 |
| primal-linearization-ADMM | 1.350 | 6.576e-06 | 7.99341859e-02 | 685 |
|             momentum-grad | 0.104 | 5.678e-06 | 7.99346946e-02 | 513 |
|    Nesterov-momentum-grad | 0.060 | 5.855e-06 | 7.99343456e-02 | 292 |
|                   AdaGrad | 0.237 | 4.530e-06 | 7.99343552e-02 | 1104 |
|                   RMSProp | 0.357 | 4.990e-05 | 7.99395567e-02 | 1648 |
|                      Adam | 0.370 | 5.403e-06 | 7.99344316e-02 | 1695 |

Seed = 666666

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
|                 cvx-mosek | 3.021 | 0.000e+00 | 6.37300442e-02 | NaN |
|                cvx-gurobi | 4.921 | 1.853e-06 | 6.37296052e-02 | NaN |
|                     mosek | 1.736 | 2.235e-06 | 6.37297788e-02 | NaN |
|                    gurobi | 1.568 | 2.368e-06 | 6.37295648e-02 | NaN |
|           projection-grad | 0.131 | 2.398e-06 | 6.37295644e-02 | 328 |
|                  sub-grad | 0.543 | 1.883e-06 | 6.37297030e-02 | 2542 |
|               smooth-grad | 0.449 | 6.735e-07 | 6.37297069e-02 | 2018 |
|         smooth-FISTA-grad | 0.080 | 7.426e-07 | 6.37297146e-02 | 301 |
|      smooth-Nesterov-grad | 0.052 | 1.634e-06 | 6.37298085e-02 | 181 |
|             proximal-grad | 0.413 | 2.417e-06 | 6.37295644e-02 | 1748 |
|       proximal-FISTA-grad | 0.074 | 2.116e-06 | 6.37295663e-02 | 301 |
|    proximal-Nesterov-grad | 0.056 | 1.216e-06 | 6.37296339e-02 | 181 |
|      augmented-Lagrangian | 0.420 | 2.743e-06 | 6.37297173e-02 | 41 |
|                 dual-ADMM | 0.152 | 2.840e-06 | 6.37302394e-02 | 102 |
|               primal-ADMM | 0.693 | 7.137e-06 | 6.37315396e-02 | 401 |
| primal-linearization-ADMM | 0.918 | 2.340e-06 | 6.37295645e-02 | 674 |
|             momentum-grad | 0.149 | 2.618e-06 | 6.37300676e-02 | 553 |
|    Nesterov-momentum-grad | 0.086 | 2.263e-06 | 6.37297227e-02 | 293 |
|                   AdaGrad | 0.240 | 2.518e-06 | 6.37296650e-02 | 1000 |
|                   RMSProp | 0.389 | 1.143e-05 | 6.37318376e-02 | 1593 |
|                      Adam | 0.515 | 1.682e-06 | 6.37297978e-02 | 2099 |

Under Construction...
