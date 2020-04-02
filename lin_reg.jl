# Example taken from https://github.com/rmcelreath/rethinking_manual
using Pkg; Pkg.activate("/home/oliver/Languages/Julia/Soss/")
using Soss, RDatasets

lin_reg = @model speed begin
    σ ~ Uniform(0,50)
    α ~ Normal(0,100)
    β ~ Normal(0,10)
    μ = α .+ β .* speed
    N = length(speed)
    dist ~ For(1:N) do n
        Normal(μ[n],σ)
    end
end

cars = RDatasets.dataset("datasets", "cars")

post = dynamicHMC(lin_reg(speed = cars.Speed), (dist = cars.Dist,)) |> particles
println(post)
println("Compare to:")
println("(σ: 15.068462 ± 1.51, β: 3.921415 ± 0.41, α: -17.40014 ± 6.60)")
