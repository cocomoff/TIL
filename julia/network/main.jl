# -*- coding: utf-8 -*-

using JuMP, Clp

network_data_file = "simple_network.csv"
network_data = readcsv(network_data_file, header=true)
data = network_data[1]
header = network_data[2]

start_node = round.(Int64, data[:,1])
end_node = round.(Int64, data[:,2])
c = data[:,3]
u = data[:,4]

println(u)

network_data2_file = "simple_network_b.csv"
network_data2 = readcsv(network_data2_file, header=true)
data2 = network_data2[1]
header2 = network_data2[2]

b = data2[:, 2]

num_node = max(maximum(start_node), maximum(end_node))
num_link = length(start_node)
println("$num_node $num_link")

nodes = 1:num_node
links = Array{Tuple{Int, Int}}(num_link)
for i=1:num_link
    links[i] = (start_node[i], end_node[i])
end
println(links)

c_dict = Dict()
u_dict = Dict()
for i=1:num_link
    c_dict[(start_node[i], end_node[i])] = c[i]
    u_dict[(start_node[i], end_node[i])] = u[i]
end

include("mcnf.jl")
x_star, obj, status = minimal_cost_network_flow(nodes, links, c_dict, u_dict, b)
println("The solution status is: $status")
println(obj)
println(x_star)
