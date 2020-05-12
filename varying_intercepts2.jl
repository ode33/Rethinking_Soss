# Example taken from https://github.com/rmcelreath/rethinking_manual
using Soss, CSV

varying_intercepts2 = @model (applicatons, dept_id, male) begin
    σ ~ Cauchy(0,2.5)
    ā ~ Normal(0,10)
    β ~ Normal(0,1)
    a ~ For(dept_id) do id
        Normal(ā,σ)
    end
    p = logistic.(a + b*male)
    N = length(male)
    admit ~ For(1:N) do n
        Binomial(applications[n], p[n])
    end
end

ucb = CSV.read("./UCBadmit.csv")

dept_id = ucb.dept_id
applications = ucb.applications
male = ucb.male
admit = ucb.admit

post = dynamicHMC(varying_intercepts2(applications = applications, dept_id = dept_id, male = male), (admit = admit,)) |> particles
println(post)
