# taken from https://github.com/cscherrer/Soss.jl/issues/258
using Soss
using Soss: Dists

m1 = @model begin
    x1 ~ Soss.Normal(0.0, 1.0)
    x2 ~ Dists.LogNormal(0.0, 1.0)
    return x1^2/x2
end

m2 = @model m begin
    μ ~ m
    y ~ Soss.Normal(μ, 1.0)
end

mm = m2(m=m1())
display(mm)
display(xform(mm|(t=1.0,)))
