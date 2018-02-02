# -*- coding: utf-8 -*-

using PyPlot


x = -2:0.1:2;
f(x) = 1/5 * x .^5 - 3 / 4 * x + 1 / 6 * x .^ 2 + 1/4 * x.^3 - 1/17 * x.^7 + 1
y = f(x)

plot(x, y, "ro")
tight_layout()
savefig("graph.png", dpi=150)
