# example taken from https://julialang.slack.com/archives/CLR9W2MJL/p1626220561096900
# by Chad Scherrer
using Soss
using MeasureTheory

n = 20

m = @model begin
    x ~ Sorted(Normal(), n)
    y ~ Sorted(Uniform(), n)
end

using SampleChainsDynamicHMC

s = sample(m(), dynamichmc(), 5, 1)
