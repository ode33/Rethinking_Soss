# Example taken from https://github.com/StanJulia/CmdStan.jl

using Soss

binormal = @model (μ,σ) begin
    y ~ MulivariateNormal(μ,σ)
end

μ = [0.,0]
σ = [1 1; .1 .1]

println(rand(binormal(μ=μ,σ=σ)))
