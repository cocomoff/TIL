# -*- coding: utf-8 -*-

c = [-3;
     -2;
     -1;
     -5;
     0;
     0;
     0]
A = [7 3 4 1 1 0 0;
     2 1 1 5 0 1 0;
     1 4 5 2 0 0 1]
b = [7;
     3;
     8]

include("search_bfs.jl")

opt_x, obj = searchBFS(c, A, b)

println("Opt obj: ", obj)
println("Opt x  : ", opt_x)
