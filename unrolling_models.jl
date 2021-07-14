# example taken from https://julialang.zulipchat.com/#narrow/stream/240884-soss.2Ejl/topic/Upcoming.20plans.20for.20Soss
using Soss

prior = @model begin
  λ ~ HalfCauchy()
  a ~ Exponential(λ)
  b ~ Exponential(λ)
end

m = @model begin
  pars ~ prior()
  x ~ Beta(pars.a, pars.b)
end
