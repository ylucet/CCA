%returns true if both functions are equal
function b = gph_isequal(g1,g2)
  p1=plq_gph(g1);
  p2=plq_gph(g2);
  b = plq_isEqual(p1,p2);
end