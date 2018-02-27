# -*- coding: utf-8 -*-

using Distributions
using PyPlot

N = 100
x = linspace(-1.0, 1.0, N);

k(x1, x2, σ) = exp(-(x1 - x2)^2 / σ^2)

# compute gram matrix K
K = zeros(N, N)
λ = 0.01
σ = 1.0
for i in 1:N, j in 1:N
    K[i, j] = k(x[i], x[j], σ)
end
K = Symmetric(K) + λ * eye(N)

# sample N-dim. vector from N(0, K)
trial = 5
figure(figsize=(6, 3))
dist = MvNormal(zeros(N), K)
for t in 1:trial
    y = rand(dist)
    plot(x, y)
end
ylim(-5.0, 5.0)
tight_layout()
    
savefig("func_sample_s$(σ).png", dpi=150)
