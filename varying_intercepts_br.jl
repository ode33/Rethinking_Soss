# Example taken from https://github.com/rmcelreath/rethinking_manual

using Soss, CSV

varying_intercepts = @model (applications, male) begin
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

post = nuts(varying_intercepts(applications = applications, male = male), (admit = admit,)) |> particles
println(post)
