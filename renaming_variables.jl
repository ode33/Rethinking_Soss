# example taken from https://julialang.zulipchat.com/#narrow/stream/240884-soss.2Ejl/topic/Upcoming.20plans.20for.20Soss
using Soss

m = @model begin
  μ ~ Normal()
  x ~ Normal(μ, 1)
end

rename(m, :μ => :mean)

@model begin
  mean ~ Normal()
  x ~ Normal(μ, 1)
end
