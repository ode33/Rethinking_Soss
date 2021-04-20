# Example taken from https://github.com/cscherrer/Soss.jl
using MeasureTheory
using Random
using SampleChainsDynamicHMC
using Soss

Random.seed!(2021);

model = @model X begin
    p  = size(X, 2)
    β ~ Normal(0, 1) |> iid(p)
    y ~ For(eachrow(X)) do x
        Normal(x' * β, 1)
    end
end

#  model = @model X begin
    #  p = size(X, 2) # number of features
    #  α ~ Normal(0, 1) # intercept
    #  β ~ Normal(0, 1) |> iid(p) # coefficients
    #  σ ~ HalfNormal(1) # dispersion
    #  η = α .+ X * β # linear predictor
    #  μ = η # `μ = g⁻¹(η) = η`
    #  y ~ For(eachindex(μ)) do j
        #  Normal(μ[j], σ) # `Yᵢ ~ Normal(mean=μᵢ, variance=σ²)`
    #  end
#  end

X = randn(6,2)
truth = rand(model(X=X))
pairs(truth)

num_rows = 1_000
num_features = 2
X = randn(num_rows, num_features)

β_true = [2.0,-1.0]
α_true = 1.0
σ_true = 0.5

η_true = α_true .+ X * β_true
μ_true = η_true
noise = randn(num_rows) .* σ_true
y_true = μ_true .+ noise

posterior = sample(DynamicHMCChain, model(X=X) | (y=y_true,))
display(posterior)
#println("");
#pairs(posterior);

@show σ_true; @show α_true; @show β_true;

posterior_predictive = predictive(model, :β)
y_ppc = [rand(posterior_predictive(;X=X, p...)).y for p in posterior]
#  ppc = y_true - y_ppc
proposal = weightedSample(model(X=X), (y=y_true,))
@show proposal.β;
