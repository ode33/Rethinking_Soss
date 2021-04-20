# Example taken from https://github.com/rmcelreath/rethinking_manual
using MeasureTheory
using RDatasets
using SampleChainsDynamicHMC
using Soss
using Soss: Dists

lin_reg = @model speed begin
    α ~ Normal(0,100)
    β ~ Normal(0,10)
    σ ~ Dists.Uniform(0,50)
    μ = α .+ β .* speed
    N = length(speed)
    dist ~ For(1:N) do n
        Normal(μ[n],σ)
    end
end

cars = RDatasets.dataset("datasets", "cars")

post = sample(DynamicHMCChain, lin_reg(speed = cars.Speed) | (dist = cars.Dist,))
display(post)
println("")
println("Compare to:")
println("(σ: 15.068462±1.51, β: 3.921415±0.41, α: -17.40014±6.60)")
