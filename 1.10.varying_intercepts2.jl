# Example taken from https://github.com/rmcelreath/rethinking_manual
using CSV
using DataFrames
using MeasureTheory
using SampleChainsDynamicHMC
using Soss

varying_intercepts2 = @model (applicatons, dept_id, male) begin
    ā ~ Normal(0,10)
    β ~ Normal(0,1)
    σ ~ Cauchy(0,2.5)
    a ~ For(dept_id) do id
        Normal(ā,σ)
    end
    p = logistic.(a + β*male)
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

post = sample(DynamicHMCChain, varying_intercepts2(applications=applications, dept_id=dept_id, male=male) | (admit=admit,))
display(post)
println("")
