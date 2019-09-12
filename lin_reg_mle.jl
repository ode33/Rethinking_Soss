# Example taken from https://github.com/rmcelreath/rethinking_manual

using Soss, RDatasets

cars_formula2 = @model (speed, dist) begin
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

post = nuts(cars_formula2, (speed = cars.Speed, dist = cars.Dist)) |> particles
println(post)
