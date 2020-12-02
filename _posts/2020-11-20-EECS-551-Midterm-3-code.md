---
title: EECS 551 Midterm 3 code
date: 2020-11-20 14:45:01 +0800
categories: [Learning, UMICH, EECS551]
tags: [EECS551, UMICH, Data Science, Linear Algebra, DSP, ML]
---
```julia
"""
e = eigtiki(X, beta)
Return the eigenvalues in ascending order of `(X'X + beta I)^+` for `  0`,
without calling (or duplicating) functions listed in the problem statement.
The output should be a Vector.
"""
function eigtiki(X::AbstractMatrix, beta::Real)::Vector
    m,n = size(X);
    vals = norm.(svdvals(X)).^2 .+ beta
    ret = [vals; beta*ones(n-length(vals))]
    for i = 1:n
        if isapprox(ret[i],0,atol = 1e-9)
            ret = [0;ret[1:end-1]]
        else
            ret[i] = 1/ret[i]
        end
    end
    return ret
end
m1 = 30
n1 = 20
percent = 0;
beta = 10
for i = 1:100
    X = rand(ComplexF64,m1,n1)
    data = svdvals(pinv(X'*X+beta*I))
    ret = eigtiki(X,beta)
    if isapprox(ret[end:-1:1],data)
        global percent = percent+1
    end
end
X = [1+im 0 0 0 ; 0 1-im 0 0 ; 0 0 3-2im 0; 0 0 0 0 ;0 0 0 0 ]
@show data = svdvals(pinv(X'*X+beta*I))
@show ret = eigtiki(X,beta)
@show isapprox(ret[end:-1:1],data)

```
```julia
using LinearAlgebra
using FFTW
using BenchmarkTools
"""
Ah = lr_circ(A, K::Int)
Compute the rank-at-most-`K` best approximation to circulant matrix `A`
In:
- `A` : `N × N` circulant matrix
- `K` : rank constraint (nonnegative integer: 0, 1, 2, ...)
Out:
- `Ah` : `N × N` best approximation to `A` having rank  `K`
"""
function lr_circ(A, K::Int)::Matrix
    N = size(A,1)
    Sigma = fft(A[:,1])
    per = sortperm(Sigma; by=abs, rev=true)
    makeQ = (N,n) -> reshape([exp(im*2*pi*k/N)^M for k = per[1:K].-1 for M = 0:N-1],N,n) ./ sqrt(N)
    data = makeQ(N,K)
    return data*Diagonal(Sigma[per[1:K]])*data'
end

using SpecialMatrices: Circulant
N = 1000
K = 10
A = Circulant(rand(ComplexF64, N))
@btime test = lr_circ(A,K)
U,s,V = svd(Matrix(A))
B = U[:,1:K] * Diagonal(s[1:K]) * V[:,1:K]'
@show norm(test-B)
```
```julia
using LinearAlgebra
"""
T = nearptf(X)
Find nearest (in Frobenius norm sense) Parseval tight frame to matrix `X`.
In:
* `X` : `N × M` matrix
Out:
* `T` `N × M` matrix that is the nearest Parseval tight frame to `X`
"""
function nearptf(X::AbstractMatrix)
    U,s,V = svd(X);
    return U*V'
end
```