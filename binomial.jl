# Example taken from https://github.com/StanJulia/CmdStan.jl
using MeasureTheory
using SampleChainsDynamicHMC 
using Soss 

binomial = @model N begin
    θ ~ Beta(1,1)
    k ~ Binomial(N, θ)
end

N = 10; k = 5

post = sample(DynamicHMCChain, binomial(N=N) | (k=k,)) 
display(post)
println("")
println("Compare to:")
println("(θ = 0.5±0.29)")
