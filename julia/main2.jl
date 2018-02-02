# -*- coding: utf-8 -*-

using PyPlot

diff = 0.1
x = -2:diff:2;
f(x) = 1/5 * x .^5 - 3 / 4 * x + 1 / 6 * x .^ 2 + 1/4 * x.^3 - 1/17 * x.^7 + 1
y = f(x)

# data = [x'; y']'
x0 = 0.5
# index = findfirst(data, x0)
# print(index)
eps = 0.15
linS = 10
N=50

Mseq = [x0]

for iter=1:N
    xrange = linspace(x0-eps, x0+eps, linS)
    yvalues = f(xrange)

    println("Iter $iter")
    println(xrange)
    println(yvalues)
    NN = length(xrange)

    M = 0.0
    for id=1:NN
        M += xrange[id] * yvalues[id]
    end
    x0 = M / NN
    println("new x0: $x0")
    println()
    

    # compute diff (x_last - x)
    if abs(Mseq[end] - x0) < 1e-3
        break
    else
        push!(Mseq, x0)
    end
end
