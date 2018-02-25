# -*- coding: utf-8 -*-

using Distributions
using DataStructures
using PyPlot

function extend(v)
    i, j = v
    return [(i-1, j), (i+1, j), (i, j-1), (i, j+1)]
end


function generate(p, N)
    ber = Bernoulli(p)
    grid = zeros(Int64, N, N)
    for i in 1:N, j in 1:N
        grid[i, j] = Int(rand(ber))
    end
    if p > 0
        grid[Int(N/2), Int(N/2)] = 1
    end
    return grid
end


function gen_connected(grid)
    N = size(grid)[1]
    q = Deque{Tuple{Int, Int}}()
    con = Set{Tuple{Int, Int}}()
    v0 = (Int(N/2), Int(N/2))
    push!(q, v0)

    while length(q) > 0
        v = pop!(q)
        push!(con, v)
        lv = extend(v)
        for vv in lv
            ii, jj = vv
            if 1 <= ii <= N && 1 <= jj <= N
                if grid[ii, jj] == 1 && !in((ii, jj), con)
                    push!(q, vv)
                end
            end
        end
    end
    return con
end


# generater
function img_gen(p; N=10)
    grid = generate(p, N)
    con = gen_connected(grid)
    ratio = length(con) / (N * N)
    conmat = zeros(N, N)
    for (i, j) in con
        conmat[i, j] = 1.0
    end
    figure(figsize=(6, 3))
    subplot(1, 2, 1)
    imshow(grid, cmap="Blues")
    subplot(1, 2, 2)
    imshow(conmat, cmap="Blues")
    savefig("p$(p).png")
    return ratio
end


for N in 10:10:100
    rvec = Float64[]
    pp = 0.0:0.005:1.0
    figure()
    for p in pp
        grid = generate(p, N)
        con = gen_connected(grid)
        ratio = length(con) / (N * N)
        push!(rvec, ratio)
    end

    plot(pp, rvec, "bx--")
    tight_layout()
    savefig("ratio$N.png")
end
