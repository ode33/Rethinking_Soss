#example taken from https://julialang.zulipchat.com/#narrow/stream/240884-soss.2Ejl/topic/Upcoming.20plans.20for.20Soss
using Soss

unroll(m; :pars) == @model begin
  pars ~ @struct begin
    pars_λ ~ HalfCauchy()
    pars_a ~ Exponential(λ)
    pars_b ~ Exponential(λ)
  end

  x ~ Beta(pars.a, pars.b)
end
