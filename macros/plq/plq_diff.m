%compute the piecewise linear derivative of p
%errors out (in pl_gph) if dp is not a function
function dp = plq_diff(p)
  G=gph_plq(p);
  dp=pl_gph(G);
end%