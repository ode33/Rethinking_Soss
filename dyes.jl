# Example taken from https://github.com/StanJulia/CmdStan.jl
using Distributions
using MeasureTheory
using SampleChainsDynamicHMC
using Soss

dyes = @model (batches, samples)  begin
    N = length(batches)

    θ ~ Normal(0.0, 1E5)
    τ₁ ~ Gamma(0.001, 0.001)
    τ₂ ~ Gamma(0.001, 0.001)

    σ₁ = 1 / sqrt(τ₁)
    σ₂ = 1 / sqrt(τ₂)

    μ ~ Normal(θ, σ₁) |> iid(N)
    y ~ For(1:N) do n
        Normal(μ[n], σ₂)
    end
end

batches = 6
samples = 5
y = reshape([
    [1545, 1540, 1595, 1445, 1595];
    [1520, 1440, 1555, 1550, 1440];
    [1630, 1455, 1440, 1490, 1605];
    [1595, 1515, 1450, 1520, 1560];
    [1510, 1465, 1635, 1480, 1580];
    [1495, 1560, 1545, 1625, 1445]
], 6, 5)

#  post = Soss.sample(DynamicHMCChain, dyes(batches=batches, samples=samples) | (y=y,))
#  display(post)
#  println("")
#  println(rand(dyes(batches=batches, samples=samples)))
println("Compare to:")
println("τ₂ = 3.9e-4 ± 1.2e-4, τ₁ = 1.3e-3 ± 2.8e-3, θ = 1.5e3 ± 2.2e1, μ = 1.5e3 ± 2.0e1")
