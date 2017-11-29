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

Under Construction...

## Experimental Results
Seed = 666666

| Solver | Optval | Err to CVX-Mosek | Time(s) |
| :----: | :-----: | :----: | :----: |
| CVX-Mosek | 6.37300442e-02 | 0.00e+00 | 1.46 |
| CVX-Gurobi | 6.37296052e-02 | 1.85e-06 | 6.79 |
| Mosek | 6.37297788e-02 | 2.23e-06 | 1.65 |
| Gurobi | 6.37295648e-02 | 2.37e-06 | 1.78 |
| Projection Gradient | 6.37295644e-02 | 2.39e-06 | 0.19 |
| Sub Gradient | 6.37299719e-02 | 1.79e-06 | 0.86 |

Seed = 23333

| Solver | Optval | Err to CVX-Mosek | Time(s) |
| :----: | :-----: | :----: | :----: |
| CVX-Mosek | 7.99348749e-02 | 0.00e+00 | 1.37 |
| CVX-Gurobi | 7.99341909e-02 | 6.63e-06 | 2.14 |
| Mosek | 7.99344433e-02 | 4.16e-06 | 1.68 |
| Gurobi | 7.99341863e-02 | 6.62e-06 | 1.84 |
| Projection Gradient | 7.99341858e-02 | 6.64e-06 | 0.39 |
| Sub Gradient | 7.99345605e-02 | 5.86e-06 | 0.77 |

Under Construction...
