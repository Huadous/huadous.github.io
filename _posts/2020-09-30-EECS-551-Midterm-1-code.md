---
title: EECS 551 Midterm 1 code
date: 2020-09-30 17:30:17 +0800
categories: [Learning, UMICH, EECS551]
tags: [EECS551, UMICH, Data Science, Linear Algebra, DSP, ML]
---
## second_diff_2d
```julia
using SparseArrays
"""
A = second_diff_2d(M, N)
In:
- `M` and `N` are positive integers
Out:
- `A` is a appropriate matrix such that `A * X[:]` computes the
second finite differences down the columns (along x direction)
and across the (along y direction) of the `M x N` matrix `X`,
where `eltype(A) == Int8`
"""
function set_SN(N)
S_N = spzeros(Int8,N,N)
S_N[1,1], S_N[1,2], S_N[1,3] = -1, 2,-1;
S_N[N,N-2], S_N[N,N-1], S_N[N,N] = -1, 2,-1;
for i = 2:N-1
S_N[i,i-1],S_N[i,i],S_N[i,i+1] = -1,2,-1;
end
return S_N
end
function second_diff_2d(M, N)
S_M = set_SN(M);
I_M = sparse(I,M,M);
S_N = set_SN(N);
I_N = sparse(I,N,N);
return cat(kron(I_N,S_M),kron(S_N,I_M), dims = 1)
end
@show second_diff_2d(5,5)
m = 30;
n = 20;
X = Float64.([(x-m/4)^2+(y-n/3)^2 < 5^2 for x=1:m, y=1:n])
Y = second_diff_2d(m, n)*vec(X);
Y = reshape(Y,(m*n,2));
DFDX = reshape(Y[:,1], (m,n));
DFDY = reshape(Y[:,2], (m,n));
using MIRT
jim(cat(X,DFDX,DFDY, dims = 3))
```