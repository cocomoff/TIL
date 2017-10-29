# -*- coding: utf-8 -*-

using Calculus

f(x) = x^3 + exp(x) + sin(x)

println(derivative(f, 1.0))
println(second_derivative(f, 1.0))


g(x) = (x[1])^2 * sin(3x[2]) + exp(-2x[3])
println(gradient(g, [3.0, 1.0, 2.0]))
println(hessian(g, [3.0, 1.0, 2.0]))
