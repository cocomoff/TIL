# -*- coding:utf-8 -*-
# simulation example

using PyPlot

A = [0 1; -1 -1]
B = [0; 1]
u = 1
Δt = 0.05
tf = 20
x = [0; 0]
xx = []

# sim
for t in 0:Δt:tf
    push!(xx, x)
    Δx = A*x + B*u
    x += Δx * Δt
end

# plot
t = 0:Δt:tf
figure(figsize=(6, 3))
plot(t, xx)
grid(true)
savefig("ex1.png", format="png", dpi=300)
