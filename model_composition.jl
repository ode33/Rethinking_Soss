<<<<<<< HEAD
# taken from https://github.com/cscherrer/Soss.jl/issues/258
=======
# based on 
>>>>>>> ecdba33210d18a0e81abc8cee6af0933b0f716a9
using Soss
using Soss: Dists

m1 = @model begin
<<<<<<< HEAD
    x1 ~ Soss.Normal(0.0, 1.0)
    x2 ~ Dists.LogNormal(0.0, 1.0)
    return x1^2/x2
end

m2 = @model m begin
    μ ~ m
    y ~ Soss.Normal(μ, 1.0)
end

println(xform(m2(m=m1())|(y=1.0,)))
=======
  x1 ~ Soss.Normal(0.0,1.0)
  x2 ~ Dists.LogNormal(0.0,1.0)
  return x1^2/x2
end

m2 = @model m begin
  μ ~ m
  y ~ Soss.Normal(μ, 1.0)
end

mm = m2(m=m1())
println(mm)
println(xform(mm|(t=1.0,)))
>>>>>>> ecdba33210d18a0e81abc8cee6af0933b0f716a9
