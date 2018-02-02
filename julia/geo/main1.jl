# -*- coding: utf-8 -*-

struct Line
    a::Float64
    b::Float64
    c::Float64
end

function frompoints(x1::Float64, y1::Float64, x2::Float64, y2::Float64)
    dx = x2 - x1
    dy = y2 - y1
    return Line(dy, -dx, dx * y1 - dy * x1)
end

function getintersectionpoint(l1::Line, l2::Line)
    d = l1.a * l2.b - l2.a * l1.b
    if d == 0
        return nothing
    end
    x = (l1.b * l2.c - l2.b * l1.c) / d
    y = (l2.a * l1.c - l1.a * l2.c) / d
    return (x, y)
end

l1 = frompoints(0., 1., 6., 4.)
l2 = frompoints(3., 6., 5., 0.)
p = getintersectionpoint(l1, l2)
println(p)
