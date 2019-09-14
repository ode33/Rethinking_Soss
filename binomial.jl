# Example taken from https://github.com/StanJulia/CmdStan.jl

using Soss

binomial = @model N begin
    θ ~ Beta(1,1)
    k ~ Binomial(N, θ)
end

N = 10; k = 5

post = nuts(binomial(N=N), (k=k,)) |> particles
println(post)
println("Compare to:")
println("(θ = 0.5 ± 0.29)")
