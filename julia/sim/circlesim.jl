# -*- coding: utf-8 -*-

module CircleSim

using PyPlot

export Point
struct Point
    x::Float64
    y::Float64
end

function Base.show(io::IO, p::Point)
    print(io, "($(p.x), $(p.y))")
end

export generate, circleplot, circleplotedges, dist, getedges

function generate(N; Δθ=0.001, Δr=0.1, Rmin=2.5, Rmax=5.0)
    points = Point[]
    # generate N random samples
    for n in 1:N
        θ = rand(0.0:Δθ:2π)
        r = rand(Rmin:Δr:Rmax)
        x = r * cos(θ)
        y = r * sin(θ)
        push!(points, Point(x, y))
    end
    return points
end

# plot N points
function circleplot(points::Array{Point, 1})
    figure(figsize=(5, 5))
    for n in 1:length(points)
        plot(points[n].x, points[n].y, "bo")
    end
    grid(true)
    xlim(-5.5, 5.5)
    ylim(-5.5, 5.5)
    tight_layout()
    show()
end

# plot N points and edges
function circleplotedges(points::Array{Point, 1}, edges::Dict{Int, Array{Int, 1}})
    figure(figsize=(5, 5))
    # plot edges
    for i in 1:length(points)
        pi = points[i]
        for j in edges[i]
            pj = points[j]
            plot([pi.x, pj.x], [pi.y, pj.y], lw=1.5, color="k", ls="-")
        end
    end

    # plot points
    for n in 1:length(points)
        plot(points[n].x, points[n].y, "bo")
    end
    grid(true)
    xlim(-5.5, 5.5)
    ylim(-5.5, 5.5)
    tight_layout()
    savefig("sim2.png", format="png", dpi=300)
    show()
end

dist(p1::Point, p2::Point) = sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)


function getedges(points::Array{Point, 1}; T::Float64=3.0)
    N = length(points)
    ret = Dict{Int, Array{Int64, 1}}()
    for i in 1:N
        pi = points[i]
        adj = Int64[]
        for j in 1:N
            pj = points[j]
            if dist(pi, pj) < T
                push!(adj, j)
            end
        end
        ret[i] = adj
    end
    return ret
end

# end of module
end

using CircleSim
N = 50
T = 3.0
points = generate(N)
edges = getedges(points, T=T)
# circleplot(points)
circleplotedges(points, edges)
