---
title: EECS 551 HW 5 code
date: 2020-10-07 16:00:41 +0800
categories: [Learning, UMICH, EECS551]
tags: [EECS551, UMICH, Data Science, Linear Algebra, DSP, ML]
seo:
  date_modified: 2020-12-02 11:06:13 +0800
---
## lsgd
```julia
using LinearAlgebra
using LaTeXStrings
"""
x = lsgd(A, b ; mu=0, x0=zeros(size(A,2)), nIters::Int=200)
Performs gradient descent to solve the least squares problem:
``\\argmin_x 0.5 \\| b − A x \\|_2``
In:
− `A` `m × n` matrix
− `b` vector of length `m`
Option:
− `mu` step size to use, and must satisfy ``0 < mu < 2 / \\sigma_1(A)^2``
to guarantee convergence,
where ``\\sigma_1(A)`` is the first (largest) singular value.
Ch.5 will explain a default value for `mu`
− `x0` is the initial starting vector (of length `n`) to use.
Its default value is all zeros for simplicity.
− `nIters` is the number of iterations to perform (default 200)
Out:
− `x` vector of length `n` containing the approximate LS solution
"""
function lsgd(A, b ; mu::Real=0, x0=zeros(size(A,2)), nIters::Int=200)
    for i = 1:nIters
        ANS = A'*(A*x0-b);
        if isapprox(ANS,zeros(size(ANS)))
            return x0
        end
        x0=x0 -mu*ANS;
    end
    return x0
end

function lsgd1(A, b ; x0=zeros(size(A,2)), nIters::Int=200)
    obj = svd(A);
    mu = 1/obj.S[1]^2;
    x_ = A\b;
    data = zeros(201);
    data[1] = norm(x0-x_)
    for i = 1:nIters
        ANS = A'*(A*x0-b);
        x0=x0 -mu*ANS;
        data[i+1] = norm(x0-x_);
    end
    return data
end

using Random: seed!
m = 100; n = 50; sigma = 0.1
seed!(0) # seed random number generator
A = randn(m, n); xtrue = rand(n)
b = A * xtrue + sigma * randn(m)

using Plots
a=lsgd1(A,b)
scatter([0:1:200],a,yaxis=:log10,label= L"\sigma = 0.1")

sigma = 0.5
A = randn(m, n); xtrue = rand(n)
b = A * xtrue + sigma * randn(m)
scatter!([0:1:200],lsgd1(A,b),label= L"\sigma = 0.5")

sigma = 1
A = randn(m, n); xtrue = rand(n)
b = A * xtrue + sigma * randn(m)
scatter!([0:1:200],lsgd1(A,b),label= L"\sigma = 1")

sigma = 2
A = randn(m, n); xtrue = rand(n)
b = A * xtrue + sigma * randn(m)
scatter!([0:1:200],lsgd1(A,b),label= L"\sigma = 2")
```
## compute_normals
```julia
using LinearAlgebra
"""
`N = compute_normals(data, L)`
In:
- `data` `m × n × d` matrix whose `d` slices contain `m × n` images
of a common scene under different lighting conditions
- `L` `3 × d` matrix whose columns are the lighting direction vectors
for the images in data, with `d  3`
Out:
- `N` `m × n × 3` matrix containing the unit-norm surface normal vectors
for each pixel in the scene]]
"""
function compute_normals(data, L)
    m,n = size(data)[1:2]
    p = zeros(m,n,3)
    for i = 1:m
        for j = 1:n
            p[i,j,:] =  L' \ data[i,j,:];
            p[i,j,:] = p[i,j,:]/norm(p[i,j,:]);
        end
    end
    return p
end
```