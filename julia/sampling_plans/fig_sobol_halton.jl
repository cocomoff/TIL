# -*- coding: utf-8 -*-
# require: Primes and Sobol.jl

# packages
using Primes
using Sobol
using PyPlot

# halton sequences
function halton(i, b)
    result, f = 0.0, 1.0
    while i > 0
        f = f / b
        result = result + f * mod(i, b)
        i = floor(Int, i / b)
    end
    return result
end

get_filling_set_halton(m; b=2) = [halton(i, b) for i in 1:m]
function get_filling_set_halton(m, n)
    bs = primes(max(ceil(Int, m * (log(n) + log(log(n)))), 6))
    seqs = [get_filling_set_halton(m, b=b) for b in bs[1:n]]
    X = zeros(m, n)
    for i in 1:n
        X[:, i] = seqs[i]
    end
    return X
end


# num of data
ms = [10, 100, 1000]
s = SobolSeq(2)


figure(figsize=(9, 6))
counter = 1
for m in ms
    # halton sequences
    hs = get_filling_set_halton(m, 2)

    # sobol sequences
    ss = hcat([next(s) for i = 1:m]...)'

    # plot
    subplot(length(ms), 2, counter, aspect="equal")
    scatter(x=hs[:, 1], y=hs[:, 2], color="blue", marker=".")
    counter += 1
    subplot(length(ms), 2, counter, aspect="equal")
    scatter(x=ss[:, 1], y=ss[:, 2], color="blue", marker=".")
    counter += 1
end
tight_layout()
show()
close()
