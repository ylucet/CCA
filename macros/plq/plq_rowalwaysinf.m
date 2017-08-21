% A polynomial is always infinite if a and b are not infinite
% and not NaN, and c is infinite.
function [alwaysinf, sgn] = plq_rowalwaysinf(plqf)
  alwaysinf = ~(any(isinf(plqf(:,2:end-1)), 2) ......
                | any(isnan(plqf(:,2:end-1)), 2)) ......
              & isinf(plqf(:,end));
  sgn = sign(plqf(:,end));
end