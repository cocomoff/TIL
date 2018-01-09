# -*- coding: utf-8 -*-

df(f, x, h=1e-6) = (f(x + h) - f(x)) / h
dc(f, x, h=1e-6) = (f(x + h/2) - f(x - h/2)) / h
db(f, x, h=1e-6) = (f(x) - f(x - h)) / h
di(f, x, h=1e-6) = imag(f(x + h * im)) / h

# example of sin(x^2)
f = x -> sin(x ^ 2)
h = 0.001
x0 = π/2
v = f(x0 + h*im)
println(real(v))
println(imag(v) / h)

# true value
fp = x -> 2 * x * cos(x ^ 2)
vfpx0 = fp(x0)
println(vfpx0)

# differences
hseq = [0.1 ^ i for i=18:-1:0]
eps1, eps2, eps3 = Float64[], Float64[], Float64[]
for i = 1:length(hseq)
    v1 = df(f, x0, hseq[i])
    v2 = db(f, x0, hseq[i])
    v3 = di(f, x0, hseq[i])
    push!(eps1, abs(v1 - vfpx0))
    push!(eps2, abs(v2 - vfpx0))
    push!(eps3, abs(v3 - vfpx0))
end

# plot
using PyPlot
figure()
plot(hseq, eps1, "ro--")
plot(hseq, eps2, "bv-.")
plot(hseq, eps3, "m^-")
tight_layout()
show()

