# -*- coding:utf-8 -*-
# simulation example using graph laplacian L

using PyPlot

# 初期値
x = [0, 3, 5, 8, 9, 11, 16, 18, 20]

# グラフラプラシアンL
L = [1 -1 0 0 0 0 0 0 0;
    -1 3 -1 0 0 0 0 0 -1;
    0 -1 2 -1 0 0 0 0 0;
    0 0 -1 2 -1 0 0 0 0;
    0 0 0 -1 2 -1 0 0 0;
    0 0 0 0 -1 2 -1 0 0;
    0 0 0 0 0 -1 2 -1 0;
    0 0 0 0 0 0 -1 2 -1;
    0 -1 0 0 0 0 0 -1 2]

# シミュレーション
Δt = 0.05
tf = 20
xx = []
for t in 0:Δt:tf
    push!(xx, x)
    Δx = -L*x
    x += Δx * Δt
end

# plot
t = 0:Δt:tf
figure(figsize=(6, 3))
plot(t, xx)
grid(true)
savefig("ex2.png", format="png", dpi=300)
