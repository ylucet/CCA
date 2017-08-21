%convert the subdifferential of a gph function into a piecewise-linear function
%error out if the graph of the subdifferential is not a function (it is always
%piecewise-linear but may have vertical pieces).
function q = pl_gph(G)
  eps=1e-8;
  x0 = G(1,1:end-1);x1 = G(1,2:end);
  if any(find(abs(x1-x0)<eps)) 
 q=[]; cerror('Unable to convert graph of subdifferential to piecewise-linear function: graph is not a function!'); 
  end;
  x = [G(1,2:end-1)';inf];
  a = zeros(size(x));
  b = (G(2,2:end)-G(2,1:end-1))./ (G(1,2:end)-G(1,1:end-1));%can't divide by zero here because of test above
  c = G(2,1:end-1)-b .* x0;
  q=[x a b' c'];
end