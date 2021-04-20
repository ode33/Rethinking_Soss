# taken from https://github.com/cscherrer/Soss.jl/issues/259
using Soss, MeasureTheory
using Soss: Dists

m1 = @model begin
    x1 ~ Soss.Normal(0.0, 1.0)
    x2 ~ Dists.MvNormal(fill(x1, 2), ones(2))
    return x2
end;

m2 = @model m begin
    μ ~ m
    y ~ For(μ) do x
        Soss.Normal(x, 1.0)
    end
end

println(testvalue(m1()))
println(testvalue(m2(m=m1())))
