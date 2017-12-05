# L1-Regularized-Problem
Here is my solution to the following convex optimization problem,

<div align = 'center'>
<img src = "https://raw.githubusercontent.com/hzxsnczpku/L1-Regularized-Problem/master/images/eq1.gif" width='280px'>
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
  * Gradient Methods
* Fast Gradient Method for the Smoothed Primal Problem
  * FISTA
  * Nesterov's Second Merhod
* Fast Gradient Method for the Primal Problem
  * FISTA
  * Nesterov's Second Merhod

Under Construction...

## Experimental Results
Seed = 0

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
| cvx-mosek              |  1.294  |    0.000e+00     | 7.28448691e-02 |
| cvx-gurobi             |  1.927  |    3.033e-06     | 7.28442784e-02 |
| mosek                  |  1.647  |    4.001e-06     | 7.28446155e-02 |
| gurobi                 |  1.837  |    3.213e-06     | 7.28442671e-02 |
| projection-grad        |  0.286  |    3.300e-06     | 7.28442661e-02 |
| sub-grad               |  0.724  |    2.100e-06     | 7.28443932e-02 |
| smooth-grad            |  0.742  |    7.980e-07     | 7.28444145e-02 |
| smooth-FISTA-grad      |  0.106  |    2.066e-06     | 7.28444001e-02 |
| smooth-Nesterov-grad   |  0.064  |    2.502e-06     | 7.28445550e-02 |
| proximal-grad          |  0.700  |    2.788e-06     | 7.28442683e-02 |
| proximal-FISTA-grad    |  0.114  |    4.197e-06     | 7.28442749e-02 |
| proximal-Nesterov-grad |  0.076  |    1.198e-06     | 7.28443722e-02 |

Seed = 23333

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
| cvx-mosek              |  1.259  |     0.000e+00    | 7.99348749e-02 |
| cvx-gurobi             |  2.162  |     6.630e-06    | 7.99341909e-02 |
| mosek                  |  1.573  |     4.159e-06    | 7.99344433e-02 |
| gurobi                 |  1.697  |     6.624e-06    | 7.99341863e-02 |
| projection-grad        |  0.284  |     6.661e-06    | 7.99341858e-02 |
| sub-grad               |  0.822  |     6.206e-06    | 7.99343212e-02 |
| smooth-grad            |  0.832  |     5.196e-06    | 7.99343283e-02 |
| smooth-FISTA-grad      |  0.119  |     5.349e-06    | 7.99343334e-02 |
| smooth-Nesterov-grad   |  0.065  |     4.153e-06    | 7.99344929e-02 |
| proximal-grad          |  0.702  |     6.659e-06    | 7.99341858e-02 |
| proximal-FISTA-grad    |  0.115  |     6.450e-06    | 7.99341874e-02 |
| proximal-Nesterov-grad |  0.069  |     5.064e-06    | 7.99343058e-02 |

Seed = 666666

| Solver                 | Time(s) | Err to CVX-Mosek |     Optval     |
| :--------------------- | :----:  | :--------------: | :------------: |
| cvx-mosek              |  1.419  |     0.000e+00    | 6.37300442e-02 |
| cvx-gurobi             |  8.366  |     1.853e-06    | 6.37296052e-02 |
| mosek                  |  1.790  |     2.235e-06    | 6.37297788e-02 |
| gurobi                 |  1.853  |     2.368e-06    | 6.37295648e-02 |
| projection-grad        |  0.222  |     2.423e-06    | 6.37295644e-02 |
| sub-grad               |  0.808  |     1.906e-06    | 6.37297021e-02 |
| smooth-grad            |  0.811  |     6.960e-07    | 6.37297059e-02 |
| smooth-FISTA-grad      |  0.128  |     7.426e-07    | 6.37297146e-02 |
| smooth-Nesterov-grad   |  0.075  |     1.634e-06    | 6.37298085e-02 |
| proximal-grad          |  0.695  |     2.423e-06    | 6.37295644e-02 |
| proximal-FISTA-grad    |  0.115  |     2.116e-06    | 6.37295663e-02 |
| proximal-Nesterov-grad |  0.068  |     1.216e-06    | 6.37296339e-02 |

Under Construction...
