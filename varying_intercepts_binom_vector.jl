# Example taken from https://github.com/rmcelreath/rethinking_manual

using Soss, CSV

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

ucb = CSV.read("UCBadmit.csv")

dept_id = ucb.dept_id
applications = ucb.applications
male = ucb.male
admit = ucb.admit

post = nuts(varying_intercepts(dept_id = dept_id, applications = applications, male = male), (admit = admit,)) |> particles
println(post)
