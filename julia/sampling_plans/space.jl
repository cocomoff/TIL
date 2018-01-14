# -*- coding: utf-8 -*-

min_dist(a, B, p) = minimum(norm(a-b, p) for b in B)
d_max(A, B, p=2) = maximum(min_dist(a, B, p) for a in A)

function greedy_local_search(X, m, d=d_max)
    S = [X[rand(1:m)]]
    for i in 2:m
        j = indmin(x ∈ S ? Inf : d(X, push!(copy(S), x))
                   for x in X)
        push!(S, X[j])
    end
    return S
end

function exchange_algorithm(X, m, d=d_max)
    S = X[randperm(m)[1:m]]
    δ = d(X, S)
    done = false
    while !done
        best_pair = (0, 0)
        for i in 1:m
            s = S[i]
            for (j, x) in enumerate(X)
                if !in(x, S)
                    S[i] = x
                    δp = d(X, S)
                    if δp < δ
                        δ = δp
                        best_pair = (i, j)
                    end
                end
            end
            S[i] = s
        end
        done = best_pair == (0, 0)
        if !done
            i, j = best_pair
            S[i] = X[j]
        end
    end
    return S
end

function multistart_local_search(X, m, alg, k_max, d=d_max)
    sets = [alg(X, m, d) for i in 1:k_max]
    return sets[indmin(d(X, S) for S in sets)]
end

using PyPlot

N = 100
dim = 2
X = rand(N, dim)
# display(X); pintln(); println()

# get search
m = 10
Xgls = greedy_local_search(X, m)
Xexc = exchange_algorithm(X, m)

# get XY
# Xidx = find(x -> x in Xgls, X[:, 1])
Xidx = find(x -> x in Xexc, X[:, 1])
# display(X[XglsXY, :])

# plot
figure(figsize=(3, 3))
scatter(x=X[:, 1], y=X[:, 2], color="black")
scatter(x=X[Xidx, 1], y=X[Xidx, 2], color="red")
tight_layout()
show()
