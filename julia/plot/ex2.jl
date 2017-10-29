# -*- coding: utf-8 -*-

using PyPlot

lower_bound = [4.0, 4.2, 4.4, 4.8, 4.9, 4.95, 4.99, 5.00]
upper_bound = [5.4, 5.3, 5.3, 5.2, 5.2, 5.15, 5.10, 5.05]
iter = 1:8

fig = figure()

plot(iter, lower_bound, color="red", lw=2.0, ls="-", marker="o", label=L"Lower Bound $Z^k_L$")
plot(iter, upper_bound, color="blue", lw=2.0, ls="-.", marker="D", label=L"Upper Bound $Z^k_U$")
xlabel(L"iteration clock $k$", fontsize="xx-large")
ylabel("objective function value", fontsize="xx-large")
legend(loc="upper right", fontsize="x-large")
grid(color="#DDDDDD", ls="-", lw=1.0)
tick_params(axis="both", which="major", labelsize="x-large")

title("Lower and Upper Bounds")
savefig("ex2.png")
savefig("ex2.pdf")
close(fig)
