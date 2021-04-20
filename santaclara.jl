# Example taken from https://statmodeling.stat.columbia.edu/2020/05/01/simple-bayesian-analysis-inference-of-coronavirus-infection-rate-from-the-stanford-study-in-santa-clara-county/
using MeasureTheory
using SampleChainsDynamicHMC
using Soss

santaclara = @model (nsample, nspec, nsens) begin
  p = rand()
  sens = rand()
  spec = rand();
  psample = p * sens + (1 - p) * (1 - spec)
  ysample ~ Binomial(nsample, psample)
  ysens ~ Binomial(nsens, sens)
  yspec ~ Binomial(nspec, spec)
end

nsample = 3330
nsens = 122
nspec = 401
ysample = 50
ysens = 103
yspec = 399

post = sample(DynamicHMCChain, santaclara(nsample = nsample, nspec=nspec, nsens=nsens) | (ysample=ysample, yspec=yspec, ysens=ysens))
display(post)
println("")
