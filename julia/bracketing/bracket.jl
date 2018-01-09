# -*- coding: utf-8 -*-

# already defined in Julia
# φ  =(1+√5)/2

function fibonacchi_search(f, a, b, n; ϵ=0.01)
    s = (1-√5)/(1+√5)
    ρ = 1 /(φ * (1 - s^(n+1)) / (1 - s^n))
    d = ρ * b + (1 - ρ) * a
    yd = f(d)
    for i in 1:n-1
        if i == n-1
            c = ϵ * a + (1 - ϵ) * d
        else
            c = ρ * a +(1 - ρ) * b
        end
        println("$a,$b,$c,$d")
        yc = f(c)
        if yc < yd
            b, d, yd = d, c, yc
        else
            a, b = b, c
        end
        ρ = 1 / (φ *(1 - s^(n-i+1)) / (1 - s^(n- i)))
    end
    return a < b ? (a, b) : (b, a)
end

function golden_section_search(f, a, b, n)
    ρ =φ - 1
    d = ρ * b + (1 - ρ) * a
    yd = f(d)
    for i = 1:n-1
        c = ρ * a + (1 - ρ) * b
        yc = f(c)
        if yc < yd
            b, d, yd = d, c, yc
        else
            a, b = b, c
        end
        println("$a,$b,$c,$d")
    end
    return a < b ? (a, b) : (b, a)
end

f = x -> x ^ 2
n = 10
a1, b1 = fibonacchi_search(f, -1, 1, n; ϵ=0.01)
println("[$a1,$b1]")
a2, b2 = golden_section_search(f, -1, 1, n)
println("[$a2,$b2]")
