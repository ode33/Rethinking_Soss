# Example taken from https://github.com/StanJulia/CmdStan.jl
using MeasureTheory 
using SampleChainsDynamicHMC
using Soss

bernoulli = @model N begin
    θ ~ Beta(1,1)
    X ~ Bernoulli(θ) |> iid(N)
end

N = 10
X = [0,1,0,1,0,0,0,0,0,1]

post = sample(DynamicHMCChain, bernoulli(N=N) | (X=X,))
display(post)
println("")
println("Compare to:")
println("(θ = 0.33±0.003)")
