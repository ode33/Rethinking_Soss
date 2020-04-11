# Example taken from https://github.com/cscherrer/Soss.jl
using Pkg; Pkg.activate("/home/oliver/Languages/Julia/Soss")
using Soss, Random

Random.seed!(3)

m = @model X begin
    β ~ Normal() |> iid(size(X,2))
    y ~ For(eachrow(X)) do x
        Normal(x' * β, 1)
    end
end

X = randn(6,2)
truth = rand(m(X=X))
# pairs(truth)

post = dynamicHMC(m(X=truth.X), (y=truth.y,))
println(particles(post))
