# -*- coding: utf-8 -*-
using JuMP, Clp

# Reading data
data_file = "transportation.csv"
data = readcsv(data_file)

# build nodes, costs, etc.
supply_nodes = data[3:end, 2]
s = data[3:end, 1]

demand_nodes = collect(data[2, 3:end])
d = collect(data[1, 3:end])

c = data[3:end, 3:end]

# From array to dictionary
s_dict = Dict(zip(supply_nodes, s))
d_dict = Dict(zip(demand_nodes, d))
c_dict = Dict()
for i in 1:length(supply_nodes)
    for j in 1:length(demand_nodes)
        c_dict[supply_nodes[i], demand_nodes[j]] = c[i, j]
    end
end


# Optimization
tp = Model(solver=ClpSolver())

@variable(tp, x[supply_nodes, demand_nodes] >= 0)
@objective(tp, Min, sum(c_dict[i, j] * x[i, j]
                        for i in supply_nodes, j in demand_nodes))

for i in supply_nodes
    @constraint(tp, sum(x[i, j]
                        for j in demand_nodes) == s_dict[i])
end

for j in demand_nodes
    @constraint(tp, sum(x[i, j]
                        for i in supply_nodes) == d_dict[j])
end

println(tp)
solve(tp)
x_star = getvalue(x)
println(x_star)
