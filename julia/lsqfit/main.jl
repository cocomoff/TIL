# -*- coding: utf-8 -*-

using LsqFit
using PyPlot

xdata = [15.2; 19.9;  2.2; 11.8; 12.1; 18.1; 11.8; 13.4; 11.5;  0.5;
         18.9; 10.2; 10.6; 13.8;  4.6;  3.8; 15.1; 15.1; 11.7;  4.2]
ydata = [0.73; 0.19; 1.54; 2.08; 0.84; 0.42; 1.77; 0.86; 1.95; 0.27;
         0.39; 1.39; 1.25; 0.76; 1.99; 1.53; 0.86; 0.52; 1.54; 1.05]

function model(xdata, beta)
    values = similar(xdata)
    for i in 1:length(values)
        values[i] = beta[1] * ((xdata[i] / beta[2]) ^ (beta[3] - 1)) * exp(- (xdata[i] / beta[2]) ^ beta[3])
    end
    return values
end

# model_eq(x, beta) = beta[1] * ((x / beta[2]) .^ (beta[3] - 1)) .* exp(-(x / beta[2]) .^ beta[3])

fit = curve_fit(model, xdata, ydata, [3.0, 8.0, 3.0])
beta = fit.param
errors = estimate_errors(fit)

println(beta)
println(errors)

# plot
xfit = 0:0.1:20
yfit = model(xfit, fit.param)

fig = figure()
plot(xdata, ydata, color="black", lw=2.0, marker="o", ls="None")
plot(xfit, yfit, color="red", lw=2.0)
xlabel("x", fontsize="xx-large")
ylabel("y", fontsize="xx-large")
savefig("fig_plot.png")
savefig("fig_plot.pdf")
