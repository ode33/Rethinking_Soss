# Example taken from https://github.com/rmcelreath/rethinking_manual
println("MLE not supported at this time C-c to abort")

using Soss, RDatasets

lin_reg2 = @model speed begin
    α = mean(dist)
    β = 0
    σ = std(dist)
    μ = α .+ β .* speed
    N = length(speed)
    dist ~ For(1:N) do n
        Normal(μ[n], σ)
    end
end

cars = RDatasets.dataset("datasets", "cars")

post = dynamicHMC(lin_reg2(speed = cars.Speed), (dist = cars.Dist,)) |> particles
println(post)
