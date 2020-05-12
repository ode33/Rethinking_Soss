# Example taken from https://statmodeling.stat.columbia.edu/2020/05/01/simple-bayesian-analysis-inference-of-coronavirus-infection-rate-from-the-stanford-study-in-santa-clara-county/
using Soss

santaclara = @model (nsample, nspec, nsens) begin
  p = rand()
  sens = rand()
  spec = rand();
  psample = p * sens + (1 - p) * (1 - spec)
  ysample ~ Binomial(nsample, psample)
  yspec ~ Binomial(nspec, spec)
  ysens ~ Binomial(nsens, sens)
end

ysample = 50
yspec = 399
ysens = 103
nsample = 3330
nspec = 401
nsens = 122

post = dynamicHMC(santaclara(nsample = nsample, nspec=nspec, nsens=nsens),
  (ysample=ysample, yspec=yspec, ysens=ysens))
println(particles(post))
