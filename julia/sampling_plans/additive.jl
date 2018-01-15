# -*- coding: utf-8 -*-
# require: Primes

using Primes

function get_filling_set_additive_recurrence(m; c=φ-1)
    X = [rand()]
    for i in 2:m
        push!(X, mod(X[end] + c, 1))
    end
    return X
end

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
    return [collect(x) for x in zip(seqs...)]
end

m = 20
# Xseq1 = get_filling_set_additive_recurrence(m)
# println(Xseq1)

# Xseq_h1 = get_filling_set_halton(m, 19)
# Xseq_h2 = get_filling_set_halton(m, 23)
# println(Xseq_h1)
# println(Xseq_h2)
