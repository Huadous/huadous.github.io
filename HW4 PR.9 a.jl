using CSV
using Plots; default(markerstrokecolor=:auto)
using LinearAlgebra
using LaTeXStrings

s = (t) -> 0.5*exp(0.8*t); # nonlinear function
T = LinRange(0, 2, 16) # fine sampling for showing curve
y = s.(T)

scatter(T, y, color=[:blue],
    label="data", xlabel="t", ylabel="y", xlim = (0:1000)/500)
plot!(T, y, line=(:blue), label=L"f(t)=0.5e^{0.8t}", legend=:topleft)

deg = 15 # polynomial degree
Afun = (tt) -> [t.^i for t in tt, i in 0:deg] # matrix of monomials
A = Afun(T) # M × 4 matrix
xh1 = A \ y;
plot!(T, Afun(T)*xh1, label= "a polynomial of degree 15")
@show norm(Afun(T)*xh1-y)
deg = 2 # polynomial degree
Afun = (tt) -> [t.^i for t in tt, i in 0:deg] # matrix of monomials
A = Afun(T) # M × 4 matrix
xh2 = A \ y;
plot!(T, Afun(T)*xh2, label= "a polynomial of degree 2")
@show norm(Afun(T)*xh2-y)
