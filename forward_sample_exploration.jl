# example taken from: https://informativeprior.com/blog/2021/05-10-soss-sample-wrangling/index.html
using MeasureTheory
using Soss
using TupleVectors

m = @model n begin
    α ~ Normal()
    β ~ Normal()
    x ~ Normal() |> iid(n)
    σ ~ Exponential(λ = 1)
    y ~ For(x) do xj
      Normal(α + β * xj, σ)
    end
    return y
end

# the the model
rand(m(3))

# draw iid sample from the model
rand(m(3),5)

# or run a simulation
simulate(m(3), 5)
mysim = simulate(m(3), 1000)
mysim[1]

mytrace = mysim.trace
@with mytrace begin
  Ey = α .+ β .* x
  r = (y - Ey) / σ
  (;Ey, r)
end

@with mysim begin
  @with trace begin
    Ey = α .+ β .* x
    r = (y - Ey) / σ
    (;Ey, r)
  end
end
