# example taken from:
# https://julialang.zulipchat.com/#narrow/stream/240884-soss.2Ejl/topic/running.20some.20examples
using MeasureTheory
using RDatasets
using SampleChainsDynamicHMC
using Soss#master

m = @model X, refs_C, λ begin
  σ ~ Exponential(λ)

  μ_within ~ For(1:R) do k
    Normal(μ_across, σ_across)
  end

  y ~ For(1:N) do i
    level = refs_C[i]
    μ = μ_within[level]
    Normal(μ,σ)
  end
  
  return y
end

df = dataset("ggplot2", "diamonds")
df[!,:intercept] .= 1
X = Matrix(df[:,[:intercept, :X, :Y, :Z]])
C = df.Color
refs_C = C.refs
pool_C = C.pool
R = length(C.pool)

y = df[:,:Price]
N = size(df,1)

μ_across = 1.0
σ_across = 1.0
λ = 1.0

post = m(;X, refs_C, λ) | (;y)

ℓ = symlogdensity(post)
f = codegen(post; ℓ=ℓ)
ℓpar(par) = f((;X,refs_C,λ),(;y),par)
t = xform(post)
chains = initialize!(4,DynamicHMCChain, ℓpar, t)
drawsamples!(chains, 999)

