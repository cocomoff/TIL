# -*- coding:utf-8 -*-
# simulation example using graph laplacian L

using PyPlot

# 初期値
x = [1, 3, 5, 7, 9]

# グラフラプラシアンL
A = [0 0 0 1 0;
     1 0 1 0 0;
     0 0 0 0 1;
     0 1 0 0 0;
     1 0 0 0 0]
 D = diagm(squeeze(sum(A, 2), 2))
 Δ = maximum(D)
 L = D - A

 # シミュレーション
 Δt = 0.05
 tf = 10
 xx = []
 for t in 0:Δt:tf
     push!(xx, x)
     Δx = -L*x
     x += Δx * Δt
     print(x)
 end

 # plot
 t = 0:Δt:tf
 figure(figsize=(6, 3))
 plot(t, xx)
 grid(true)
 savefig("ex3.png", format="png", dpi=300)
