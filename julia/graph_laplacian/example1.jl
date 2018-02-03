# -*- coding: utf-8 -*-
# graph laplacian and visualization of eigen values

using PyPlot
using PyCall
@pyimport matplotlib.patches as patch

# adjacency matrix
A = [0 0 0 1 0;
     1 0 1 0 0;
     0 0 0 0 1;
     0 1 0 0 0;
     1 0 0 0 0]

# degrees, maximum degree and laplacian L
D = diagm(squeeze(sum(A, 2), 2))
Δ = maximum(D)
L = D - A

# eigen values
evs, els = eig(L)
for cv in evs
    println(real(cv), ",", imag(cv))
end

# plot
figure(figsize=(5, 5))

# circle
c = patch.Circle([Δ, 0.0], Δ, fc="red", zorder=0, alpha=0.3)
ax = gca()
grid(true)
ax[:add_patch](c)
for cv in evs
    plot(real(cv), imag(cv), "rx")
end
xlim(-0.1, 2*Δ+0.1)
ylim(-Δ-0.1, Δ+0.1)
tight_layout()
savefig("output1.png")
show()
