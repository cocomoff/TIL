# required: Iterators, Julia v0.6s

import Iterators: product

function samples_full_factorial(a, b, m)
    #==
    a: vec. of lower bounds
    b: vec. of upper bounds
    m: vec. of number of samples
    ==#
    ranges = [linspace(a[i], b[i], m[i]) for i in 1:length(a)]
    collect.(collect(product(ranges...)))
end

a = [0.0, 0.0]
b = [1.0, 1.0]
m = [4, 4]
fact = samples_full_factorial(a, b, m)
for elem in fact
    println(elem)
end
