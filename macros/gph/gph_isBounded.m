%returns a 1x2 matrix

function B = gph_isBounded(gph)
  B = isinf([(gph(2,2)-gph(2,1))/(gph(1,2)-gph(1,1)), (gph(2,end)-gph(2,end-1))/(gph(1,end)-gph(1,end-1))]);
end
