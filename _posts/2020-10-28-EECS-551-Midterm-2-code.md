---
title: EECS 551 Midterm 2 code
date: 2020-10-28 11:30:17 +0800
categories: [Learning, UMICH, EECS551]
tags: [EECS551, UMICH, Data Science, Linear Algebra, DSP, ML]
---
## inrange
```julia
using BenchmarkTools: @btime
using LinearAlgebra
"""
tf = inrange(B, z)
Return `true` or `false` depending on whether `z` is in the range of `B`
to within numerical precision. Must be as compute efficient as possible.
In:
* `B` a `M × N` matrix
* `z` vector of length `M`
"""
function inrange(B::AbstractMatrix, z::AbstractVector)
    U,s,V = svd(B);
    r = rank(Diagonal(s));
    return isapprox(U[:,1:r]*(U[:,1:r]'*z),z)
end

m = 6;
n = 10;

A = [ 1 2 3 4 5 6 7 8 9 0; 8 3 2 1 4 5 9 6 7 0; 0 2 3 7 4 8 9 6 5 1; 2 7 4 3 8 1 9 0 5 6; 1 2 3 4 5 6 7 8 9 0;1 2 3 4 5 6 7 8 9 0];

X,y,Z = svd(A);
r = rank(Diagonal(y));
test = X[:,1:r]*rand(r);
test1 = X[:,r:end]*rand(m-r+1);
test2 = X*rand(m);
test3 = X[:,1]*rand(1)[1];

@btime inrange(A,test);
@btime inrange(A,test1);
@btime inrange(A,test2);
@btime inrange(A,test3);
@show inrange(A,test);
@show inrange(A,test1);
@show inrange(A,test2);
@show inrange(A,test3);
```
## bestdiag
```julia
using LinearAlgebra
"""
D = bestdiag(X::Matrix, Y::Matrix)
Solve `\\arg\\min_{D diagonal} \\| X D - Y \\|_F`
In:
* `X`, `Y` `M × N` matrices
Out:
* `D` `N × N Diagonal`
"""
function bestdiag(X::Matrix, Y::Matrix)::Diagonal
    return Diagonal(mapslices(sum,(adjoint.(X).*Y),dims=1)./mapslices(norm,X,dims=1)[:].^2)
end
function bestdiag1(X::Matrix, Y::Matrix)::Diagonal
    return Diagonal(mapslices(sum,(adjoint.(X).*Y),dims=1)./mapslices(sum,(adjoint.(X).*X),dims=1))
end
#X = [1 1 1; 1 -1 0; 1 1 0]
#Y = [1 1 0; 0 0 1; 0 0 0]
function backup(X::Matrix, Y::Matrix)::Diagonal
    n = size(X,2)
    D = zeros(ComplexF64,n)
    for i = 1:n
        x = X[:,i]
        y = Y[:,i]
        D[i] = (x' * y) / (x' * x)
    end
    return Diagonal(D)
end

X = [10+2im 5-4im -2+7im; 1-9im -1+5im 0-3im; 1+2im 1-3im 0+1im]
Y = [1-1im 1+15im 0-3im; 0+2im 0-5im 1+8im; 0-5im 0+5im 0-10im]
@btime data1 = bestdiag(X,Y)
@btime data1 = bestdiag1(X,Y)
@btime data2 = backup(X,Y)
x = -1:0.001:5
function f(x,y)
    return norm(x*X[:,y]-Y[:,y]);
end

using Plots
data = f.(x,1);
@show hello = x[findmin(data)[2]]
plot(x,data)
```
## pseudosvd
```julia
using LinearAlgebra
"""
(Ur,Sr,Vr) = pseudosvd(A)
Return 3 matrices in a compact SVD of the Moore-Penrose pseudo-inverse of `A`
without calling (or duplicating) Julia's built-in pseudo-inverse function.
The returned triplet of matrices should satisfy `Ur*Sr*Vr' = A^+`
to within appropriate numerical precision.
"""
function pseudosvd(A::AbstractMatrix)
U,s,V = svd(A);
r = rank(Diagonal(s));
Ur = reverse(V[:,1:r],dims=2);
Vr = reverse(U[:,1:r],dims=2);
Sr = Diagonal((ones(r)./reverse(s[1:r])[:])[:]);
return Ur,Sr,Vr
end

using LinearAlgebra
"""
(Ur,Sr,Vr) = pseudosvd(A)
Return 3 matrices in a compact SVD of the Moore-Penrose pseudo-inverse of `A`
without calling (or duplicating) Julia's built-in pseudo-inverse function.
The returned triplet of matrices should satisfy `Ur*Sr*Vr' = A^+`
to within appropriate numerical precision.
"""
function pseudosvd(A::AbstractMatrix)
    U,s,V = svd(A);
    r = rank(Diagonal(s));
    Ur = reverse(V[:,1:r],dims=2);
    Vr = reverse(U[:,1:r],dims=2);
    Sr = Diagonal((ones(r)./reverse(s[1:r])[:])[:]);
    return Ur,Sr,Vr
end
```