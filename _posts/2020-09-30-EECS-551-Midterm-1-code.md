---
title: EECS 551 Midterm 1 code
date: 2020-09-30 17:30:17 +0800
categories: [Learning, UMICH, EECS551]
tags: [EECS551, UMICH, Data Science, Linear Algebra, DSP, ML]
---
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
```