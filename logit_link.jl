# Example taken from https://github.com/rmcelreath/rethinking_manual
using Soss, CSV

logit_link = @model (applications, male) begin
    α ~ Normal(0,10)
    β ~ Normal(0,1)
    p = logistic.(α .+ β .* male)
    N = length(applications)
    admit ~ For(1:N) do n
        Binomial(applications[n], p[n])
    end
end

ucb = CSV.read("./UCBadmit.csv")

applications = ucb.applications
male = ucb.male
admit = ucb.admit

post = dynamicHMC(logit_link(applications = applications, male = male), (admit = admit,)) |> particles
println(post)
println("Compare to:")
println("(β = 0.61 ± 0.06, α = -0.83 ± 0.05)")
