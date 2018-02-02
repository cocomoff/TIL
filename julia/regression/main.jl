# -*- coding: utf-8 -*-

import Iterators:product
using StatsBase
using PyPlot

function design_matrix(X)
    n, m = length(X[1]), length(X)
    return [j == 0 ? 1.0 : X[i][j] for i in 1:m, j in 0:n]
end

function linear_regression(X, y)
    theta = pinv(design_matrix(X)) * y
    return x -> dot(theta, [1; x])
end

function regression(X, y, bases)
    B = [b(x) for x in X, b in bases]
    theta = pinv(B) * y
    return x -> sum(theta[i] * bases[i](x) for i in 1:length(theta))
end

polynomial_bases_1d(i, k) = [x->x[i]^p for p in 0:k]
function polynomial_bases(n, k)
    bases = [polynomial_bases_1d(i, k) for i in 1:n]
    terms = Function[]
    for ks in product([0:k for i in 1:n]...)
        if sum(ks) <= k
            push!(terms,
                  x->prod(b[j+1](x) for (j, b) in zips(ks, bases)))
        end
    end
end

N = 5
xseq = collect(0:0.1:10)
x = sample(xseq, N)
y = 3 .* x + 1.5 .* randn(N)
ytrue = 3.* xseq

# poly
# pbase = polynomial_bases_1d(1, 3)
# freg = regression(x, y, pbase)
# yfreq = freg(xseq)
# println(yfreq)

# plot(xseq, ytrue, "k-")
# scatter(x, y)
# show()
