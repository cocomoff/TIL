# -*- coding: utf-8 -*-

using Distributions

M = 6
O = [25, 27, 20, 10, 13, 25]
Pr = ones(M) ./ M
N = 120
E = zeros(M) + 120 * Pr[1]

println(O)
println(Pr)

OmE = O .- E
OmE2 = OmE .^ 2
OmE2pE = OmE2 ./ E
chi2score = sum(OmE2pE)
println(chi2score)

dof = 5
alpha = 0.05
pvalue = cquantile(Chisq(dof), alpha)
println(pvalue)

if chi2score < pvalue
    println("less")
else
    println("more")
end
