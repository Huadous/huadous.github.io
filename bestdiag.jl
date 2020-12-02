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
    _,n = size(X);
    return Diagonal((adjoint.(X[1,:]).*Y[1,:])./mapslices(norm,X,dims=1)[:])
end
