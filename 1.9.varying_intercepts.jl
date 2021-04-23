# Example taken from https://github.com/rmcelreath/rethinking_manual
using CSV
using DataFrames
using MeasureTheory
using SampleChainsDynamicHMC
using Soss 

varying_intercepts = @model (dept_id, applications, male) begin
    α ~ For(dept_id) do id
        Normal(0,10)
    end
    β ~ Normal(0,1)
    p = logistic.(α .+ β .* male)
    N = length(male)
    admit ~ For(1:N) do n
        Binomial(applications[n], p[n])
    end
end

ucb = CSV.read("./UCBadmit.csv", DataFrame)

admit = ucb.admit
applications = ucb.applications
dept_id = ucb.dept_id
male = ucb.male

post = sample(DynamicHMCChain, varying_intercepts(dept_id=dept_id, applications=applications, male=male) | (admit=admit,))
display(post)
println("")
