# -*- coding: utf-8 -*-
# required: Sobol.jl (Pkg.add("Sobol"))


using Sobol
using PyPlot
s = SobolSeq(2)
m = 1000
p = hcat([next(s) for i = 1:m]...)'

figure(figsize=(4, 4))
plot(p[:, 1], p[:, 2], "b.")
show()
close()
