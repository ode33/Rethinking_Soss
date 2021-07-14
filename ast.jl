# example taken from
# https://julialang.zulipchat.com/#narrow/stream/240884-soss.2Ejl/topic/ASTModels
using MeasureTheory
using Soss
using Soss: val2nt

m = @model begin
  p ~ Uniform()
  x ~ Bernoulli(p)
end

run_m = interpret(m)

function f(x,d,ctx)
  r = rand(d)
  (r,merge(ctx,val2nt(x,r)))
end

$run_m($f, NamedTuple())
