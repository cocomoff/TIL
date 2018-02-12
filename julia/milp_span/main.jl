# -*- coding: utf-8 -*-

using JuMP, Cbc

el = Tuple{Int64,Int64}[
    (0, 1),
    (0, 2),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 4)
]
cicles = [
    (1, 3, 2),
    (1, 5, 6, 2),
    (3, 6, 5)
]
wdict = Dict(
    (0, 1) => 2,
    (0, 2) => 8,
    (1, 2) => 6,
    (1, 3) => 1,
    (1, 4) => 3,
    (2, 4) => 9
)
wlist = [2, 8, 6, 1, 3, 9]
V = 5
E = length(el)

# min. problem
m = Model(solver=CbcSolver())
@variable(m, x[1:E], Bin)

# objectives
@objective(m, Min, dot(wlist, x))

# constraints 1: cycle
for c in cicles
    c1 = zeros(E)
    for _c in c
        c1[_c] = 1
    end
    @constraint(m, dot(c1, x) <= length(c) - 1)
end

# constraint 2: # of edges
@constraint(m, dot(ones(E), x) == V - 1)

# print model
println(m)

# solve the model
status = solve(m)
println("Objective is: ", getobjectivevalue(m))
for i=1:E
    if getvalue(x[i]) > 0
        println("$(el[i])")
    end
end

