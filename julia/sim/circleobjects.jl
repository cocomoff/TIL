# -*- coding: utf-8 -*-
# build N objects in a circle of radius R ∈ [Rmin, Rmax]

N = 50
Δθ = 0.001
Δr = 0.1
Rmin = 3.5
Rmax = 5.0

struct Point
    x::Float64
    y::Float64
end
points = Point[]

# generate N random samples
for n in 1:N
    θ = rand(0.0:Δθ:2π)
    r = rand(Rmin:Δr:Rmax)
    x = r * cos(θ)
    y = r * sin(θ)
    push!(points, Point(x, y))
end

# plot N points
using PyPlot
figure(figsize=(5, 5))
for n in 1:N
    plot(points[n].x, points[n].y, "bo")
end
grid(true)
xlim(-5.5, 5.5)
ylim(-5.5, 5.5)
tight_layout()
show()
