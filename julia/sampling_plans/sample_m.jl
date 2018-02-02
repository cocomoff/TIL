# -*- coding: utf-8 -*-

function uniform_projection_plan(m, n)
    perms = [randperm(m) for i in 1:n]
    [[perms[i][j] for i in 1:n] for j in 1:m]
end

m = 5
n = 4
unif = uniform_projection_plan(m, n)
for elem in unif
    println(elem)
end
