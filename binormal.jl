# Example taken from https://github.com/StanJulia/CmdStan.jl
using Distributions
using LinearAlgebra 
using MeasureTheory
using Soss

binormal = @model (μ,σ) begin
    y ~ MultivariateNormal(μ,σ)
end

μ = [0.,0,0,0,0]
σ = Array{Float64}(rand(5,5))
σ = σ*σ'

isposdef(σ) && println(rand(binormal(μ=μ,σ=σ)))
